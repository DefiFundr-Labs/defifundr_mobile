import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:defifundr_mobile/core/update/app_update_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── BLoC ──────────────────────────────────────────────────────────────────────

sealed class _UpdateEvent {}
class _Check extends _UpdateEvent {}
class _Dismiss extends _UpdateEvent {}
class _StatusReceived extends _UpdateEvent {
  _StatusReceived(this.status, this.latestVersion);
  final AppUpdateStatus status;
  final String latestVersion;
}

sealed class _UpdateState {}
class _Idle extends _UpdateState {}
class _SoftUpdate extends _UpdateState {
  _SoftUpdate(this.latestVersion);
  final String latestVersion;
}
class _ForceUpdate extends _UpdateState {
  _ForceUpdate(this.latestVersion);
  final String latestVersion;
}

class _UpdateBloc extends Bloc<_UpdateEvent, _UpdateState> with EventBusScope {
  _UpdateBloc() : super(_Idle()) {
    on<_Check>((_, __) => AppUpdateService.instance.check());

    on<_StatusReceived>((event, emit) {
      emit(switch (event.status) {
        AppUpdateStatus.forceUpdate => _ForceUpdate(event.latestVersion),
        AppUpdateStatus.softUpdate => _SoftUpdate(event.latestVersion),
        AppUpdateStatus.upToDate => _Idle(),
      });
    });

    on<_Dismiss>((_, emit) => emit(_Idle()));

    listenTo<FlagsRefreshed>((_) => add(_Check()));
    listenTo<AppUpdateRequired>(
        (e) => add(_StatusReceived(e.status, e.latestVersion)));

    add(_Check());
  }

  @override
  Future<void> close() {
    clearSubscriptions();
    return super.close();
  }
}

// ── Guard widget ──────────────────────────────────────────────────────────────

/// Wrap around your root router widget.
///
/// - Force update → replaces entire UI with a blocker screen.
/// - Soft update  → overlays a dismissible sheet above the app content.
/// - Up to date   → renders [child] with no interference.
///
/// ```dart
/// // In MaterialApp.router builder:
/// builder: (context, child) => AppUpdateGuard(
///   child: child ?? const SizedBox.shrink(),
/// ),
/// ```
class AppUpdateGuard extends StatelessWidget {
  const AppUpdateGuard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _UpdateBloc(),
      child: BlocBuilder<_UpdateBloc, _UpdateState>(
        builder: (context, state) {
          if (state is _ForceUpdate) {
            return _ForceUpdateScreen(latestVersion: state.latestVersion);
          }

          return Stack(
            children: [
              child,
              if (state is _SoftUpdate)
                _SoftUpdateOverlay(
                  latestVersion: state.latestVersion,
                  onUpdate: () {
                    context.read<_UpdateBloc>().add(_Dismiss());
                    AppUpdateService.instance.openStore();
                  },
                  onDismiss: () =>
                      context.read<_UpdateBloc>().add(_Dismiss()),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ── Soft update overlay ───────────────────────────────────────────────────────

class _SoftUpdateOverlay extends StatefulWidget {
  const _SoftUpdateOverlay({
    required this.latestVersion,
    required this.onUpdate,
    required this.onDismiss,
  });

  final String latestVersion;
  final VoidCallback onUpdate;
  final VoidCallback onDismiss;

  @override
  State<_SoftUpdateOverlay> createState() => _SoftUpdateOverlayState();
}

class _SoftUpdateOverlayState extends State<_SoftUpdateOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismiss(VoidCallback then) async {
    await _controller.reverse();
    then();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: Stack(
        children: [
          // Scrim
          GestureDetector(
            onTap: () => _dismiss(widget.onDismiss),
            child: Container(color: Colors.black45),
          ),
          // Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _slide,
              child: _SoftUpdateSheet(
                latestVersion: widget.latestVersion,
                onUpdate: () => _dismiss(widget.onUpdate),
                onDismiss: () => _dismiss(widget.onDismiss),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Force update screen ───────────────────────────────────────────────────────

class _ForceUpdateScreen extends StatelessWidget {
  const _ForceUpdateScreen({required this.latestVersion});

  final String latestVersion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.system_update_rounded, size: 72),
              const SizedBox(height: 24),
              Text(
                'Update Required',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'Version $latestVersion is required to continue. '
                'Please update now.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: AppUpdateService.instance.openStore,
                  child: const Text('Update Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Soft update sheet ─────────────────────────────────────────────────────────

class _SoftUpdateSheet extends StatelessWidget {
  const _SoftUpdateSheet({
    required this.latestVersion,
    required this.onUpdate,
    required this.onDismiss,
  });

  final String latestVersion;
  final VoidCallback onUpdate;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Icon(Icons.update_rounded, size: 48),
            const SizedBox(height: 16),
            Text(
              'Update Available',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Version $latestVersion is available with improvements and fixes.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDismiss,
                    child: const Text('Later'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: onUpdate,
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

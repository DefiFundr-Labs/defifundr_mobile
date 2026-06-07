import 'package:defifundr_mobile/core/design_system/design_system.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus.dart';
import 'package:defifundr_mobile/core/event_bus/event_bus_scope.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/update/app_update_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        AppUpdateStatus.softUpdate  => _SoftUpdate(event.latestVersion),
        AppUpdateStatus.upToDate    => _Idle(),
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
                  onDismiss: () => context.read<_UpdateBloc>().add(_Dismiss()),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ── Soft update overlay (animated) ───────────────────────────────────────────

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
      duration: const Duration(milliseconds: 340),
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
          GestureDetector(
            onTap: () => _dismiss(widget.onDismiss),
            child: Container(color: Colors.black54),
          ),
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
    final colors = context.theme.colors;
    final fonts  = context.theme.fonts;

    return Scaffold(
      backgroundColor: colors.bgB1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              // Logo
              SvgPicture.asset(
                context.isDarkMode
                    ? Assets.icons.logoWhite
                    : Assets.icons.logo,
                height: 40.h,
              ),

              const Spacer(),

              // Icon badge
              Container(
                width: 88.w,
                height: 88.w,
                decoration: BoxDecoration(
                  color: colors.brandDefault.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.system_update_rounded,
                  size: 40.w,
                  color: colors.brandDefault,
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                'Update Required',
                style: fonts.heading2Bold.copyWith(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 12.h),

              Text(
                'Version $latestVersion is required to continue using DeFiFundr. '
                'Please update the app to access the latest features.',
                style: fonts.textMdRegular.copyWith(color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Update button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: FilledButton(
                  onPressed: AppUpdateService.instance.openStore,
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.brandDefault,
                    foregroundColor: colors.brandDefaultContrast,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text('Update Now', style: fonts.textMdSemiBold),
                ),
              ),

              SizedBox(height: 40.h),
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
    final colors = context.theme.colors;
    final fonts  = context.theme.fonts;

    return Material(
      color: colors.bgB0,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.textTertiary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 24.h),

            // Icon badge
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: colors.brandDefault.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.update_rounded,
                size: 36.w,
                color: colors.brandDefault,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              'Update Available',
              style: fonts.heading3Bold.copyWith(color: colors.textPrimary),
            ),

            SizedBox(height: 8.h),

            Text(
              'Version $latestVersion is available with new features and improvements.',
              style: fonts.textMdRegular.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 28.h),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: onDismiss,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.textPrimary,
                        side: BorderSide(color: colors.textTertiary.withValues(alpha: 0.4)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text('Later', style: fonts.textMdSemiBold),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: FilledButton(
                      onPressed: onUpdate,
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.brandDefault,
                        foregroundColor: colors.brandDefaultContrast,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text('Update', style: fonts.textMdSemiBold),
                    ),
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

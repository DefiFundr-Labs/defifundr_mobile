import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Semantic type for [AppSonner] toasts.
enum AppToastType {
  /// Neutral — generic message. Dark background.
  message,

  /// Green — operation completed successfully.
  success,

  /// Red — something went wrong.
  error,

  /// Orange — non-blocking warning.
  warning,

  /// Blue — informational notice.
  info,
}

/// A toast entry displayed by [AppSonner].
class AppToast {
  AppToast._({
    required this.message,
    required this.type,
    this.description,
    this.action,
    this.actionLabel,
    this.duration = const Duration(seconds: 4),
  });

  final String message;
  final AppToastType type;
  final String? description;
  final VoidCallback? action;
  final String? actionLabel;
  final Duration duration;
}

/// Sonner-style stacked toast notification system, inspired by shadcn/sonner.
///
/// ## Setup
///
/// Wrap your app (or individual scaffold) with [AppSonner]:
///
/// ```dart
/// // In MaterialApp.builder
/// MaterialApp(
///   builder: (context, child) => AppSonner(child: child!),
/// )
/// ```
///
/// ## Showing toasts
///
/// Call anywhere you have a [BuildContext] (or use the global overlay key):
///
/// ```dart
/// AppSonner.of(context).show('Invoice sent');
/// AppSonner.of(context).success('Payment received');
/// AppSonner.of(context).error('Transaction failed', description: 'Insufficient funds');
/// AppSonner.of(context).warning('2FA not enabled');
/// AppSonner.of(context).info('New contract available');
///
/// // With action button
/// AppSonner.of(context).success(
///   'File exported',
///   action: () => launchUrl(fileUri),
///   actionLabel: 'Open',
/// );
/// ```
class AppSonner extends StatefulWidget {
  const AppSonner({super.key, required this.child});

  final Widget child;

  static AppSonnerState of(BuildContext context) {
    final state =
        context.findAncestorStateOfType<AppSonnerState>();
    assert(state != null,
        'AppSonner.of() called outside of an AppSonner widget.');
    return state!;
  }

  @override
  State<AppSonner> createState() => AppSonnerState();
}

class AppSonnerState extends State<AppSonner> {
  final List<_ToastEntry> _toasts = [];

  void show(
    String message, {
    String? description,
    VoidCallback? action,
    String? actionLabel,
    Duration duration = const Duration(seconds: 4),
  }) =>
      _add(AppToast._(
        message: message,
        type: AppToastType.message,
        description: description,
        action: action,
        actionLabel: actionLabel,
        duration: duration,
      ));

  void success(
    String message, {
    String? description,
    VoidCallback? action,
    String? actionLabel,
    Duration duration = const Duration(seconds: 4),
  }) =>
      _add(AppToast._(
        message: message,
        type: AppToastType.success,
        description: description,
        action: action,
        actionLabel: actionLabel,
        duration: duration,
      ));

  void error(
    String message, {
    String? description,
    VoidCallback? action,
    String? actionLabel,
    Duration duration = const Duration(seconds: 4),
  }) =>
      _add(AppToast._(
        message: message,
        type: AppToastType.error,
        description: description,
        action: action,
        actionLabel: actionLabel,
        duration: duration,
      ));

  void warning(
    String message, {
    String? description,
    VoidCallback? action,
    String? actionLabel,
    Duration duration = const Duration(seconds: 4),
  }) =>
      _add(AppToast._(
        message: message,
        type: AppToastType.warning,
        description: description,
        action: action,
        actionLabel: actionLabel,
        duration: duration,
      ));

  void info(
    String message, {
    String? description,
    VoidCallback? action,
    String? actionLabel,
    Duration duration = const Duration(seconds: 4),
  }) =>
      _add(AppToast._(
        message: message,
        type: AppToastType.info,
        description: description,
        action: action,
        actionLabel: actionLabel,
        duration: duration,
      ));

  void _add(AppToast toast) {
    final entry = _ToastEntry(toast: toast, key: UniqueKey());
    setState(() => _toasts.add(entry));
    Future.delayed(toast.duration, () => _remove(entry));
  }

  void _remove(_ToastEntry entry) {
    if (!mounted) return;
    setState(() => _toasts.remove(entry));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: MediaQuery.paddingOf(context).bottom + 16.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _toasts.reversed
                .take(3)
                .map((e) => _ToastCard(
                      key: e.key,
                      toast: e.toast,
                      onDismiss: () => _remove(e),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ToastEntry {
  const _ToastEntry({required this.toast, required this.key});
  final AppToast toast;
  final Key key;
}

class _ToastCard extends StatefulWidget {
  const _ToastCard({
    super.key,
    required this.toast,
    required this.onDismiss,
  });

  final AppToast toast;
  final VoidCallback onDismiss;

  @override
  State<_ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<_ToastCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final toast = widget.toast;

    final (icon, iconColor, bg) = switch (toast.type) {
      AppToastType.success => (
          Icons.check_circle_outline_rounded,
          colors.greenDefault,
          colors.bgB0,
        ),
      AppToastType.error => (
          Icons.error_outline_rounded,
          colors.redDefault,
          colors.bgB0,
        ),
      AppToastType.warning => (
          Icons.warning_amber_rounded,
          colors.orangeDefault,
          colors.bgB0,
        ),
      AppToastType.info => (
          Icons.info_outline_rounded,
          colors.blueDefault,
          colors.bgB0,
        ),
      AppToastType.message => (
          null,
          colors.textSecondary,
          colors.constantDefault,
        ),
    };

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: GestureDetector(
            onTap: widget.onDismiss,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: colors.strokePrimary),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: iconColor, size: 18.w),
                    SizedBox(width: 10.w),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          toast.message,
                          style: fonts.textBaseMedium.copyWith(
                            color: toast.type == AppToastType.message
                                ? colors.contrastWhite
                                : colors.textPrimary,
                          ),
                        ),
                        if (toast.description != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            toast.description!,
                            style: fonts.textSmRegular.copyWith(
                              color: toast.type == AppToastType.message
                                  ? colors.contrastWhite.withOpacity(0.7)
                                  : colors.textSecondary,
                            ),
                          ),
                        ],
                        if (toast.action != null &&
                            toast.actionLabel != null) ...[
                          SizedBox(height: 6.h),
                          GestureDetector(
                            onTap: () {
                              toast.action!();
                              widget.onDismiss();
                            },
                            child: Text(
                              toast.actionLabel!,
                              style: fonts.textSmMedium.copyWith(
                                color: colors.brandDefault,
                                decoration: TextDecoration.underline,
                                decorationColor: colors.brandDefault,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

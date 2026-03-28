import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Semantic color variant for [AppStatusBadge].
enum AppStatusVariant {
  /// Green — paid, completed, active, success
  success,

  /// Orange — pending, in review, awaiting
  warning,

  /// Red — overdue, failed, rejected, cancelled
  error,

  /// Blue — processing, sent, draft
  info,

  /// Gray — inactive, archived, unknown
  neutral,
}

/// A generic pill-shaped status badge.
///
/// Renders a filled + bordered chip using semantic design-system color tokens.
/// All status-specific chips in the app should use this component.
///
/// ```dart
/// AppStatusBadge(label: 'Paid',    variant: AppStatusVariant.success)
/// AppStatusBadge(label: 'Pending', variant: AppStatusVariant.warning)
/// AppStatusBadge(label: 'Overdue', variant: AppStatusVariant.error)
///
/// // With a leading dot indicator
/// AppStatusBadge(
///   label: 'Active',
///   variant: AppStatusVariant.success,
///   showDot: true,
/// )
/// ```
class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    required this.variant,
    this.showDot = false,
  });

  final String label;
  final AppStatusVariant variant;

  /// Whether to show a small colored dot before the label. Defaults to `false`.
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final config = _resolveConfig(variant, colors);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: config.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: config.border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: config.foreground,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: context.theme.fonts.textSmMedium.copyWith(
              color: config.foreground,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  _BadgeConfig _resolveConfig(
      AppStatusVariant variant, dynamic colors) {
    switch (variant) {
      case AppStatusVariant.success:
        return _BadgeConfig(
          background: colors.greenFill,
          foreground: colors.greenDefault,
          border: colors.greenStroke,
        );
      case AppStatusVariant.warning:
        return _BadgeConfig(
          background: colors.orangeFill,
          foreground: colors.orangeDefault,
          border: colors.orangeStroke,
        );
      case AppStatusVariant.error:
        return _BadgeConfig(
          background: colors.redFill,
          foreground: colors.redDefault,
          border: colors.redStroke,
        );
      case AppStatusVariant.info:
        return _BadgeConfig(
          background: colors.blueFill,
          foreground: colors.blueDefault,
          border: colors.blueStroke,
        );
      case AppStatusVariant.neutral:
        return _BadgeConfig(
          background: colors.bgB2,
          foreground: colors.textSecondary,
          border: colors.grayQuaternary,
        );
    }
  }
}

class _BadgeConfig {
  const _BadgeConfig({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;
}

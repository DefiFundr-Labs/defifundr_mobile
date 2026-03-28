import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Semantic variant for [AppChip] and [AppStatusChip].
enum AppChipVariant {
  /// Green — paid, approved, completed, success
  success,

  /// Orange — pending, awaiting, in-progress
  warning,

  /// Red — overdue, rejected, failed, error
  danger,

  /// Blue — informational, used, scheduled
  info,

  /// Grey — neutral, all, default, inactive
  neutral,
}

/// A small pill-shaped label chip — the single source of truth for every
/// status badge, filter tag, and category label in the app.
///
/// Replaces the four divergent `StatusChip` / `InvoiceStatusChip`
/// implementations that each used raw `Colors.*` values.
///
/// ```dart
/// // Status label (no dot)
/// AppChip(label: 'Paid', variant: AppChipVariant.success)
///
/// // With dot indicator
/// AppChip(label: 'Pending', variant: AppChipVariant.warning, showDot: true)
///
/// // Filter chip (tappable, shows selected state)
/// AppChip(
///   label: 'Overdue',
///   variant: AppChipVariant.danger,
///   selected: _isSelected,
///   onTap: () => setState(() => _isSelected = !_isSelected),
/// )
/// ```
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.variant,
    this.showDot = false,
    this.selected,
    this.onTap,
    this.fontSize,
  });

  /// Display text.
  final String label;

  /// Semantic color variant.
  final AppChipVariant variant;

  /// Whether to show a small filled circle before the label. Defaults to `false`.
  final bool showDot;

  /// When non-null the chip behaves as a toggle filter chip. Pass `true` to
  /// show a highlighted border (selected state).
  final bool? selected;

  /// Optional tap handler. Provide alongside [selected] for filter chips.
  final VoidCallback? onTap;

  /// Override the default font size (`10.sp`).
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final config = _resolve(variant, colors);
    final isSelected = selected ?? false;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? config.fill : config.fill,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? config.foreground : config.stroke,
            width: isSelected ? 1.5 : 1,
          ),
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
              SizedBox(width: 5.w),
            ],
            Text(
              label,
              style: fonts.textSmMedium.copyWith(
                fontSize: fontSize ?? 10.sp,
                color: config.foreground,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ChipConfig _resolve(AppChipVariant variant, dynamic colors) {
    switch (variant) {
      case AppChipVariant.success:
        return _ChipConfig(
          fill: colors.greenFill,
          foreground: colors.greenDefault,
          stroke: colors.greenStroke,
        );
      case AppChipVariant.warning:
        return _ChipConfig(
          fill: colors.orangeFill,
          foreground: colors.orangeDefault,
          stroke: colors.orangeStroke,
        );
      case AppChipVariant.danger:
        return _ChipConfig(
          fill: colors.redFill,
          foreground: colors.redDefault,
          stroke: colors.redStroke,
        );
      case AppChipVariant.info:
        return _ChipConfig(
          fill: colors.blueFill,
          foreground: colors.blueDefault,
          stroke: colors.blueStroke,
        );
      case AppChipVariant.neutral:
        return _ChipConfig(
          fill: colors.bgB0,
          foreground: colors.textSecondary,
          stroke: colors.strokePrimary,
        );
    }
  }
}

class _ChipConfig {
  const _ChipConfig({
    required this.fill,
    required this.foreground,
    required this.stroke,
  });
  final Color fill;
  final Color foreground;
  final Color stroke;
}

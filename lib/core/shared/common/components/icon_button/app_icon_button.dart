import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Visual style variant for [AppIconButton].
enum AppIconButtonVariant {
  /// Solid brand-colored background. Use for primary actions.
  filled,

  /// Transparent background with a border. Use for secondary actions.
  outline,

  /// No background or border. Use for tertiary / toolbar actions.
  ghost,
}

/// Size preset for [AppIconButton].
enum AppIconButtonSize {
  /// 32 × 32 dp container, 16 dp icon.
  sm,

  /// 40 × 40 dp container, 20 dp icon. Default.
  md,

  /// 48 × 48 dp container, 24 dp icon.
  lg,
}

/// A square icon-only button with three visual variants (filled, outline, ghost)
/// and three sizes (sm, md, lg), inspired by shadcn's `IconButton`.
///
/// ```dart
/// // Primary filled action
/// AppIconButton(
///   svgPath: Assets.icons.add,
///   onPressed: () => context.router.push(const CreateInvoiceRoute()),
/// )
///
/// // Ghost toolbar button
/// AppIconButton(
///   svgPath: Assets.icons.filter,
///   variant: AppIconButtonVariant.ghost,
///   onPressed: _openFilter,
/// )
///
/// // Danger outline (e.g. delete)
/// AppIconButton(
///   svgPath: Assets.icons.trash,
///   variant: AppIconButtonVariant.outline,
///   iconColor: context.theme.colors.redDefault,
///   onPressed: _confirmDelete,
/// )
///
/// // Disabled
/// AppIconButton(svgPath: Assets.icons.send, onPressed: null)
/// ```
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.svgPath,
    required this.onPressed,
    this.variant = AppIconButtonVariant.ghost,
    this.size = AppIconButtonSize.md,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.tooltip,
  });

  /// SVG asset path. Use `Assets.icons.<name>` from flutter_gen.
  final String svgPath;

  /// Tap handler. Pass `null` to disable.
  final VoidCallback? onPressed;

  /// Visual style. Defaults to [AppIconButtonVariant.ghost].
  final AppIconButtonVariant variant;

  /// Size preset. Defaults to [AppIconButtonSize.md].
  final AppIconButtonSize size;

  /// Override the icon tint color.
  final Color? iconColor;

  /// Override the container background (only relevant for [AppIconButtonVariant.filled]).
  final Color? backgroundColor;

  /// Override the border color (only relevant for [AppIconButtonVariant.outline]).
  final Color? borderColor;

  /// Optional tooltip shown on long-press.
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final disabled = onPressed == null;

    final (containerSize, iconSize) = switch (size) {
      AppIconButtonSize.sm => (32.0, 16.0),
      AppIconButtonSize.md => (40.0, 20.0),
      AppIconButtonSize.lg => (48.0, 24.0),
    };

    final effectiveIconColor = disabled
        ? colors.textTertiary
        : iconColor ??
            switch (variant) {
              AppIconButtonVariant.filled => Colors.white,
              AppIconButtonVariant.outline => colors.textPrimary,
              AppIconButtonVariant.ghost => colors.textPrimary,
            };

    final effectiveBg = disabled
        ? Colors.transparent
        : switch (variant) {
            AppIconButtonVariant.filled =>
              backgroundColor ?? colors.brandDefault,
            AppIconButtonVariant.outline => Colors.transparent,
            AppIconButtonVariant.ghost => Colors.transparent,
          };

    final border = switch (variant) {
      AppIconButtonVariant.outline => Border.all(
          color: disabled
              ? colors.strokePrimary
              : borderColor ?? colors.strokePrimary,
        ),
      _ => null,
    };

    Widget button = GestureDetector(
      onTap: onPressed,
      child: AnimatedOpacity(
        opacity: disabled ? 0.4 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: containerSize.w,
          height: containerSize.w,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: BorderRadius.circular(10.r),
            border: border,
          ),
          child: Center(
            child: SvgPicture.asset(
              svgPath,
              width: iconSize.w,
              height: iconSize.w,
              colorFilter:
                  ColorFilter.mode(effectiveIconColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

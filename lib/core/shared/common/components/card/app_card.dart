import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A theme-aware card container.
///
/// Renders a rounded rectangle using semantic background tokens so it
/// automatically adapts to light and dark mode without a brightness check.
///
/// ```dart
/// AppCard(
///   child: Text('Hello'),
/// )
///
/// // Custom padding / radius
/// AppCard(
///   padding: EdgeInsets.all(12.w),
///   borderRadius: BorderRadius.circular(12.r),
///   child: content,
/// )
///
/// // With a visible stroke border
/// AppCard(
///   showBorder: true,
///   child: content,
/// )
/// ```
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.showBorder = false,
    this.borderColor,
    this.onTap,
  });

  final Widget child;

  /// Inner padding. Defaults to `EdgeInsets.all(16.w)`.
  final EdgeInsetsGeometry? padding;

  /// Corner radius. Defaults to `BorderRadius.circular(16.r)`.
  final BorderRadiusGeometry? borderRadius;

  /// Card background color.
  /// Defaults to `context.theme.colors.bgB0` (white in light / darkest in dark).
  final Color? backgroundColor;

  /// Whether to render a subtle stroke border. Defaults to `false`.
  final bool showBorder;

  /// Border color when [showBorder] is `true`.
  /// Defaults to `context.theme.colors.strokeSecondary`.
  final Color? borderColor;

  /// Optional tap handler. Wraps the card in an [InkWell] when provided.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(16.r);
    final effectiveBg = backgroundColor ?? colors.bgB0;

    Widget card = Container(
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: showBorder
            ? Border.all(color: borderColor ?? colors.strokeSecondary)
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveRadius is BorderRadius ? effectiveRadius : null,
          splashColor: colors.brandFill.withAlpha(80),
          highlightColor: Colors.transparent,
          child: card,
        ),
      );
    }

    return card;
  }
}

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A themed icon container: a rounded square with a background color and an
/// SVG icon centered inside. Used for list item icons, action buttons, etc.
///
/// ```dart
/// AppIconContainer(
///   svgPath: Assets.icons.wallet,
/// )
///
/// // Red/destructive variant
/// AppIconContainer(
///   svgPath: Assets.icons.signOut,
///   backgroundColor: context.theme.colors.redFill,
///   iconColor: context.theme.colors.redDefault,
/// )
/// ```
class AppIconContainer extends StatelessWidget {
  const AppIconContainer({
    super.key,
    required this.svgPath,
    this.backgroundColor,
    this.iconColor,
    this.containerSize = 36,
    this.iconSize = 20,
    this.borderRadius,
  });

  /// Path to the SVG asset. Use `Assets.icons.<name>` from flutter_gen.
  final String svgPath;

  /// Background color of the container.
  /// Defaults to `context.theme.colors.brandFill`.
  final Color? backgroundColor;

  /// Color applied to the SVG icon.
  /// Defaults to `context.theme.colors.brandDefault`.
  final Color? iconColor;

  /// Size of the outer container in dp (applied to both width and height).
  /// Defaults to `36`.
  final double containerSize;

  /// Size of the SVG icon inside the container.
  /// Defaults to `20`.
  final double iconSize;

  /// Border radius of the container.
  /// Defaults to `BorderRadius.circular(8.r)`.
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Container(
      width: containerSize.w,
      height: containerSize.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.brandFill,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: iconSize.w,
          height: iconSize.w,
          colorFilter: ColorFilter.mode(
            iconColor ?? colors.brandDefault,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

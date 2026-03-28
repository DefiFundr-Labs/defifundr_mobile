import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A large circular icon badge. Used as the hero graphic on single-purpose
/// screens such as 2FA setup, confirmation, and success states.
///
/// This is distinct from [AppIconContainer] (square-rounded, used in lists)
/// — this one is always a circle and typically used as a centred hero icon.
///
/// ```dart
/// // Default brand colors
/// AppCircleIconBadge(svgPath: Assets.icons.shieldStar)
///
/// // Larger success circle
/// AppCircleIconBadge(
///   svgPath: Assets.icons.shieldCheck,
///   containerSize: 96,
///   iconSize: 52,
///   backgroundColor: context.theme.colors.greenFill,
///   iconColor: context.theme.colors.greenDefault,
/// )
/// ```
class AppCircleIconBadge extends StatelessWidget {
  const AppCircleIconBadge({
    super.key,
    required this.svgPath,
    this.backgroundColor,
    this.iconColor,
    this.containerSize = 96,
    this.iconSize = 52,
  });

  /// Path to the SVG asset. Use `Assets.icons.<name>` from flutter_gen.
  final String svgPath;

  /// Background color of the circle.
  /// Defaults to `context.theme.colors.brandFill`.
  final Color? backgroundColor;

  /// Tint color applied to the SVG.
  /// Defaults to `context.theme.colors.brandDefault`.
  final Color? iconColor;

  /// Diameter of the outer circle in dp. Defaults to `96`.
  final double containerSize;

  /// Size of the SVG icon inside. Defaults to `52`.
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Container(
      width: containerSize.w,
      height: containerSize.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.brandFill,
        shape: BoxShape.circle,
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

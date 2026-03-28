import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A circular avatar that displays two-letter initials using brand colors.
///
/// Used for user profile pictures when no photo is available.
///
/// ```dart
/// AppAvatarInitials(initials: 'AO')
///
/// // Larger size
/// AppAvatarInitials(initials: 'JD', size: 64)
///
/// // Custom colors (e.g., for a secondary user or org)
/// AppAvatarInitials(
///   initials: 'XY',
///   backgroundColor: context.theme.colors.blueFill,
///   textColor: context.theme.colors.blueDefault,
///   borderColor: context.theme.colors.blueDefault,
/// )
/// ```
class AppAvatarInitials extends StatelessWidget {
  const AppAvatarInitials({
    super.key,
    required this.initials,
    this.size = 52,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.showBorder = true,
  });

  /// The initials to display (1–2 characters recommended).
  final String initials;

  /// Diameter of the circle in dp. Defaults to `52`.
  final double size;

  /// Circle fill color. Defaults to `context.theme.colors.brandFill`.
  final Color? backgroundColor;

  /// Initials text color. Defaults to `context.theme.colors.brandDefault`.
  final Color? textColor;

  /// Border color. Defaults to `context.theme.colors.brandDefault`.
  final Color? borderColor;

  /// Whether to show the branded border ring. Defaults to `true`.
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    final effectiveTextColor = textColor ?? colors.brandDefault;

    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.brandFill,
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: borderColor ?? colors.brandDefault,
                width: 2.w,
              )
            : null,
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: fonts.textLgBold.copyWith(
            color: effectiveTextColor,
            fontSize: (size * 0.35).sp,
          ),
        ),
      ),
    );
  }
}

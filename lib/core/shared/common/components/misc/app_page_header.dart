import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A title + optional subtitle heading block for flow/form screens.
///
/// Replaces the repeated raw `Text` + `copyWith(fontSize: 24.sp, …)` pattern
/// found on onboarding, settings, and 2FA screens. Uses design-system font
/// tokens instead of `context.theme.textTheme.*`.
///
/// ```dart
/// // Title only
/// AppPageHeader(title: 'Personal Details')
///
/// // Title + subtitle
/// AppPageHeader(
///   title: 'Set Up 2FA',
///   subtitle: 'Scan the QR code with your authenticator app.',
/// )
///
/// // Centred (e.g. success / confirmation screens)
/// AppPageHeader(
///   title: 'All done!',
///   subtitle: 'Your wallet has been created.',
///   textAlign: TextAlign.center,
/// )
/// ```
class AppPageHeader extends StatelessWidget {
  const AppPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.start,
    this.bottomSpacing = 24,
  });

  /// Primary headline text.
  final String title;

  /// Optional supporting description below the title.
  final String? subtitle;

  /// Text alignment for both title and subtitle. Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// Vertical space added **below** the header block (between the header and
  /// the next sibling). Defaults to `24`. Set to `0` to manage spacing manually.
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: fonts.headerLarger.copyWith(
            fontSize: 24.sp,
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 4.h),
          Text(
            subtitle!,
            textAlign: textAlign,
            style: fonts.headerSmall.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: colors.textSecondary,
            ),
          ),
        ],
        if (bottomSpacing > 0) SizedBox(height: bottomSpacing.h),
      ],
    );
  }
}

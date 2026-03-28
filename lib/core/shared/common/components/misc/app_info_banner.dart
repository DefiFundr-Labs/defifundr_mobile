import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Semantic variant that controls the color scheme of [AppInfoBanner].
enum AppBannerVariant {
  /// Blue — informational, tips, guidance
  info,

  /// Orange — caution, warnings, partial states
  warning,

  /// Red — destructive actions, security risks, errors
  danger,

  /// Green — success, confirmation, completed actions
  success,
}

/// A full-width informational/warning banner used to surface important context
/// to the user, e.g. security warnings, action consequences, or tips.
///
/// ```dart
/// // Simple text banner
/// AppInfoBanner(
///   variant: AppBannerVariant.danger,
///   title: 'Never share your private key',
///   body: 'Anyone with your private key has full control of your wallet.',
/// )
///
/// // With a leading SVG icon
/// AppInfoBanner(
///   variant: AppBannerVariant.warning,
///   svgIcon: Assets.icons.warning,
///   title: 'Unconfirmed transaction',
///   body: 'This may take up to 10 minutes to confirm on-chain.',
/// )
///
/// // Info with emoji leading icon
/// AppInfoBanner(
///   variant: AppBannerVariant.info,
///   leadingEmoji: 'ℹ️',
///   body: 'Scan the QR code with your authenticator app.',
/// )
/// ```
class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({
    super.key,
    required this.variant,
    this.title,
    this.body,
    this.svgIcon,
    this.leadingEmoji,
  }) : assert(
          title != null || body != null,
          'Provide at least title or body.',
        );

  final AppBannerVariant variant;

  /// Optional bold headline. Rendered above [body].
  final String? title;

  /// Supporting description text.
  final String? body;

  /// Optional SVG asset path shown to the left of the text block.
  /// Use `Assets.icons.<name>` from flutter_gen.
  final String? svgIcon;

  /// Optional emoji shown to the left of the title (e.g. `'🔒'`).
  /// Ignored when [svgIcon] is also provided.
  final String? leadingEmoji;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final config = _resolveConfig(variant, colors);

    Widget? leadingWidget;
    if (svgIcon != null) {
      leadingWidget = SvgPicture.asset(
        svgIcon!,
        width: 20.w,
        height: 20.w,
        colorFilter: ColorFilter.mode(config.foreground, BlendMode.srcIn),
      );
    } else if (leadingEmoji != null) {
      leadingWidget = Text(
        leadingEmoji!,
        style: TextStyle(fontSize: 18.sp),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: config.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: config.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Row(
              mainAxisAlignment: leadingWidget != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.start,
              children: [
                if (leadingWidget != null) ...[
                  leadingWidget,
                  SizedBox(width: 8.w),
                ],
                Expanded(
                  child: Text(
                    title!,
                    style: fonts.textBaseSemiBold.copyWith(
                      color: config.foreground,
                    ),
                  ),
                ),
              ],
            ),
          if (title != null && body != null) SizedBox(height: 8.h),
          if (body != null)
            Text(
              body!,
              style: fonts.textMdRegular.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }

  _BannerConfig _resolveConfig(AppBannerVariant variant, dynamic colors) {
    switch (variant) {
      case AppBannerVariant.info:
        return _BannerConfig(
          background: colors.blueFill,
          foreground: colors.blueDefault,
          border: colors.blueStroke,
        );
      case AppBannerVariant.warning:
        return _BannerConfig(
          background: colors.orangeFill,
          foreground: colors.orangeDefault,
          border: colors.orangeStroke,
        );
      case AppBannerVariant.danger:
        return _BannerConfig(
          background: colors.redFill,
          foreground: colors.redDefault,
          border: colors.redStroke,
        );
      case AppBannerVariant.success:
        return _BannerConfig(
          background: colors.greenFill,
          foreground: colors.greenDefault,
          border: colors.greenStroke,
        );
    }
  }
}

class _BannerConfig {
  const _BannerConfig({
    required this.background,
    required this.foreground,
    required this.border,
  });
  final Color background;
  final Color foreground;
  final Color border;
}

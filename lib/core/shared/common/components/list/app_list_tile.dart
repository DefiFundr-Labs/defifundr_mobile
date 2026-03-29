import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Trailing action type for [AppListTile].
enum AppListTileTrailing {
  /// Right-pointing chevron — navigates somewhere. Default.
  chevron,

  /// North-east arrow — opens an external link or new context.
  externalLink,

  /// No trailing widget.
  none,
}

/// A consistent tappable list row used across settings, detail, and menu screens.
///
/// Promoted from `MoreListItem` (which lives inside the `more` feature module)
/// to a shared component. Supports leading icon, title, optional subtitle, and
/// a configurable trailing indicator.
///
/// For a row with a trailing [Switch] use [AppSwitchTile].
///
/// ```dart
/// // Navigation row (default)
/// AppListTile(
///   leading: AppIconContainer(svgPath: Assets.icons.lock),
///   title: 'Change Password',
///   onTap: () => context.router.push(const ChangePasswordRoute()),
/// )
///
/// // With subtitle
/// AppListTile(
///   leading: AppIconContainer(svgPath: Assets.icons.device),
///   title: 'Trusted Devices',
///   subtitle: '2 devices',
///   onTap: () => context.router.push(const DeviceManagementRoute()),
/// )
///
/// // External link
/// AppListTile(
///   leading: AppIconContainer(svgPath: Assets.icons.twitter),
///   title: 'Follow us on X',
///   trailing: AppListTileTrailing.externalLink,
///   onTap: () => launchUrl(twitterUri),
/// )
///
/// // No trailing indicator
/// AppListTile(
///   leading: AppIconContainer(svgPath: Assets.icons.info),
///   title: 'App Version 1.0.0',
///   trailing: AppListTileTrailing.none,
/// )
/// ```
class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.title,
    this.leading,
    this.subtitle,
    this.trailing = AppListTileTrailing.chevron,
    this.trailingWidget,
    this.onTap,
    this.titleColor,
    this.showDivider = false,
  });

  /// Optional leading widget — typically an [AppIconContainer].
  final Widget? leading;

  /// Primary row label.
  final String title;

  /// Optional secondary text below [title].
  final String? subtitle;

  /// Trailing indicator type. Defaults to [AppListTileTrailing.chevron].
  /// Ignored when [trailingWidget] is provided.
  final AppListTileTrailing trailing;

  /// Fully custom trailing widget. Overrides [trailing].
  final Widget? trailingWidget;

  /// Tap callback. When null the row is non-interactive.
  final VoidCallback? onTap;

  /// Override the title text color. Defaults to `colors.textPrimary`.
  /// Pass `colors.redDefault` for destructive actions like "Delete Account".
  final Color? titleColor;

  /// Whether to draw a hairline divider below the row. Defaults to `false`.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.h),
            child: Row(
              children: [
                if (leading != null) ...[
                  leading!,
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: fonts.textBaseMedium.copyWith(
                          color: titleColor ?? colors.textPrimary,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 2.h),
                        Text(
                          subtitle!,
                          style: fonts.textSmRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailingWidget ?? _buildTrailing(colors),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: colors.strokePrimary,
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }

  Widget _buildTrailing(dynamic colors) {
    switch (trailing) {
      case AppListTileTrailing.chevron:
        return Icon(Icons.chevron_right, color: colors.textTertiary, size: 20.w);
      case AppListTileTrailing.externalLink:
        return Icon(Icons.north_east, color: colors.textTertiary, size: 18.w);
      case AppListTileTrailing.none:
        return const SizedBox.shrink();
    }
  }
}

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A design-system-aware toggle switch.
///
/// Wraps Flutter's [Switch] with brand colors applied so every toggle in the
/// app is visually consistent without repeating `activeTrackColor` /
/// `activeThumbColor` at every call site.
///
/// For settings rows with a leading icon and label use [AppSwitchTile].
///
/// ```dart
/// // Standalone switch bound to a ValueNotifier
/// AppSwitch(
///   value: _notifier.value,
///   onChanged: (v) => _notifier.value = v,
/// )
///
/// // Disabled state
/// AppSwitch(value: false, onChanged: null)
/// ```
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  /// Current toggle state.
  final bool value;

  /// Called when the user flips the switch. Pass `null` to disable.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.white,
      activeTrackColor: colors.brandDefault,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: colors.strokePrimary,
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}

/// A full-width settings row: leading [icon], [title], optional [subtitle],
/// and a trailing [AppSwitch].
///
/// ```dart
/// AppSwitchTile(
///   icon: SvgPicture.asset(Assets.icons.notification),
///   title: 'Push notifications',
///   value: _enabled,
///   onChanged: (v) => _enabled = v,
/// )
///
/// // With subtitle
/// AppSwitchTile(
///   icon: SvgPicture.asset(Assets.icons.faceId),
///   title: 'Face ID',
///   subtitle: 'Use biometrics to unlock the app',
///   value: _biometrics,
///   onChanged: cubit.toggleBiometrics,
/// )
/// ```
class AppSwitchTile extends StatelessWidget {
  const AppSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.icon,
    this.subtitle,
  });

  /// Optional leading widget (typically a sized SVG or [AppIconContainer]).
  final Widget? icon;

  /// Primary row label.
  final String title;

  /// Optional secondary description below [title].
  final String? subtitle;

  /// Current toggle state.
  final bool value;

  /// Called when the user flips the switch. Pass `null` to disable.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Row(
      children: [
        if (icon != null) ...[
          icon!,
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: fonts.textBaseMedium.copyWith(color: colors.textPrimary),
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
        AppSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

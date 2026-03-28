import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A design-system-aware checkbox with an inline label.
///
/// Replaces the 5 separate raw `Checkbox(` usages spread across KYC, quickpay,
/// delete account, tax info, and payment filter screens — all of which
/// re-implemented the same tap-to-toggle + label pattern independently.
///
/// ```dart
/// // Simple agreement checkbox
/// AppCheckbox(
///   value: _agreed,
///   onChanged: (v) => setState(() => _agreed = v ?? false),
///   label: 'I agree to the Terms and Conditions',
/// )
///
/// // Multi-line label with rich text
/// AppCheckbox(
///   value: _selected,
///   onChanged: (v) => _notifier.value = v ?? false,
///   labelWidget: RichText(
///     text: TextSpan(children: [
///       TextSpan(text: 'I accept the '),
///       TextSpan(text: 'Privacy Policy', style: linkStyle),
///     ]),
///   ),
/// )
///
/// // Disabled
/// AppCheckbox(value: true, onChanged: null, label: 'Already agreed')
/// ```
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.labelWidget,
  }) : assert(
          label != null || labelWidget != null,
          'Provide either label or labelWidget.',
        );

  /// Current checked state.
  final bool value;

  /// Called when the user taps. Pass `null` to disable.
  final ValueChanged<bool?>? onChanged;

  /// Plain text label rendered to the right of the checkbox.
  final String? label;

  /// Fully custom label widget. Overrides [label].
  final Widget? labelWidget;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.w,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: colors.brandDefault,
              checkColor: Colors.white,
              side: BorderSide(color: colors.strokePrimary, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: labelWidget ??
                Text(
                  label!,
                  style: fonts.textMdRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

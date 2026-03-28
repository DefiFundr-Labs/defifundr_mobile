import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A horizontal label–value pair used in detail/profile/summary screens.
///
/// The label takes 40% of the width; the value takes 60% and is
/// right-aligned. A custom [valueWidget] can replace the plain text value
/// when richer content is needed (e.g., a badge, a link, a copyable field).
///
/// ```dart
/// // Simple string value
/// AppDetailRow(label: 'Email', value: 'user@example.com')
///
/// // Widget value (e.g., status badge)
/// AppDetailRow(
///   label: 'Status',
///   valueWidget: AppStatusBadge(
///     label: 'Active',
///     variant: AppStatusVariant.success,
///   ),
/// )
///
/// // With a divider below
/// AppDetailRow(label: 'Full name', value: 'John Doe', showDivider: true)
/// ```
class AppDetailRow extends StatelessWidget {
  const AppDetailRow({
    super.key,
    required this.label,
    this.value,
    this.valueWidget,
    this.showDivider = false,
    this.labelFlex = 4,
    this.valueFlex = 6,
  }) : assert(
          value != null || valueWidget != null,
          'Provide either value or valueWidget.',
        );

  /// The label text displayed on the left.
  final String label;

  /// Plain-text value displayed on the right.
  /// Ignored when [valueWidget] is provided.
  final String? value;

  /// Custom widget displayed in the value slot.
  /// Takes priority over [value].
  final Widget? valueWidget;

  /// Whether to show a hairline divider below the row. Defaults to `false`.
  final bool showDivider;

  /// Flex factor for the label column. Defaults to `4`.
  final int labelFlex;

  /// Flex factor for the value column. Defaults to `6`.
  final int valueFlex;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: labelFlex,
                child: Text(
                  label,
                  style: fonts.textMdRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                flex: valueFlex,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: valueWidget ??
                      Text(
                        value ?? '',
                        style: fonts.textMdMedium.copyWith(
                          color: colors.textPrimary,
                        ),
                        textAlign: TextAlign.right,
                      ),
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: colors.strokeSecondary,
          ),
      ],
    );
  }
}

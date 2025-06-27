import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';

class StatusCheckboxRow extends StatelessWidget {
  final String label;
  final bool? value; // tristate: true, false, or null
  final ValueChanged<bool?> onChanged;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final bool tristate;

  const StatusCheckboxRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.fillColor,
    required this.borderColor,
    required this.textColor,
    this.tristate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style:
                    context.theme.fonts.textSmMedium.copyWith(color: textColor),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            tristate: tristate,
            value: value,
            onChanged: onChanged,
            checkColor: AppColors.white,
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return context.theme.colors.brandDefault;
              }
              return Colors.transparent;
            }),
            side: BorderSide(
              color: context.theme.colors.strokeSecondary,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ],
    );
  }
}

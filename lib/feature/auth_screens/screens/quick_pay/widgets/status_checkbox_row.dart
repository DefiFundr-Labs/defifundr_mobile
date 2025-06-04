import 'package:defifundr_mobile/core/utils/resolve_color.dart';
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
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
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
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.brandDefault;
              }
              return Colors.transparent;
            }),
            side: BorderSide(
              color: resolveColor(
                context: context,
                lightColor: AppColors.strokeSecondary,
                darkColor: AppColorDark.strokeSecondary.withValues(alpha: 0.32),
              ),
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

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: context.theme.fonts.textMdRegular.copyWith(color: context.theme.colors.textPrimary),
                ),
              ),
              Checkbox(
                activeColor: value
                    ? context.theme.colors.brandDefault
                    : context.theme.colors.bgB0,
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return context.theme.colors.brandDefault;
                  }
                  return context.theme.colors.bgB0;
                }),
                checkColor: context.theme.colors.bgB0,
                side: BorderSide(
                    color: value
                        ? context.theme.colors.brandDefault
                        : context.theme.colors.strokeSecondary,
                    width: 1),
                value: value,
                onChanged: onChanged,
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

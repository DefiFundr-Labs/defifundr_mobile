import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionPillBar extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;
  final double? padding;
  final double? borderRadius;

  const SelectionPillBar({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 2),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(borderRadius ?? 8).r,
      ),
      child: Row(
        children: options.map((option) {
          final isSelected = selectedOption == option;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.theme.colors.bgB0
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular((borderRadius ?? 8) - 2),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    option,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: isSelected
                          ? context.theme.colors.textPrimary
                          : context.theme.colors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

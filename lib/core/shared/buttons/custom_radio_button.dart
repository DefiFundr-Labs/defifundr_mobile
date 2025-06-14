import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final String label, subLabel;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  final EdgeInsets padding;

  const CustomRadioButton({
    Key? key,
    required this.label,
    required this.subLabel,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
              color: _isSelected
                  ? AppColors.brandDefaultContrast
                  : Colors.transparent,
              width: 1),
          color: AppColors.bgB0,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: context.theme.fonts.textBaseSemiBold),
                  SizedBox(height: 4),
                  Text(
                    subLabel,
                    style: context.theme.fonts.textSmRegular,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _isSelected
                    ? AppColors.brandDefaultContrast
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: AppColors.constantDefaultBorder,
                  width: 1,
                ),
              ),
              child: _isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

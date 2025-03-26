import 'package:defifundr_mobile/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final String label;
  final String value;
  final double? width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoField({
    Key? key,
    required this.label,
    required this.value,
    this.width,
    this.height = 38,
    this.borderRadius = 10,
    this.borderColor = AppColors.lightPurple,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.labelStyle,
    this.valueStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(fontSize: 12);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Text(
              label,
              style: labelStyle ?? defaultStyle,
            ),
            Text(
              ' $value',
              style: valueStyle ?? defaultStyle,
            ),
          ],
        ),
      ),
    );
  }
}

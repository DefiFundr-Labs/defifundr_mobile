import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class ReviewRow extends StatelessWidget {
  final String label;
  final String value;
  final String? subtitle;
  final String? icon;

  const ReviewRow({
    Key? key,
    required this.label,
    required this.value,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (icon != null) ...[
                      Image.asset(icon!, width: 16, height: 16),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: Text(
                        value,
                        style: context.theme.fonts.textMdMedium,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: context.theme.fonts.textXsMedium.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                    textAlign: TextAlign.right,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

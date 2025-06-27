import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

Widget buildDetailsRow(BuildContext context, String title, Widget value) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: context.theme.fonts.textMdRegular
                .copyWith(color: context.theme.colors.textSecondary)),
        Align(
            alignment: Alignment.centerRight,
            child: Expanded(child: value)),
      ],
    ),
  );
}

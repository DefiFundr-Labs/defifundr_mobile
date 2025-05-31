import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: context.theme.colors.textPrimary,
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.maybePop(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: resolveColor(
            context: context,
            lightColor: AppColors.textPrimary,
            darkColor: AppColorDark.textPrimary,
          ),
        ),
      ),
    );
  }
}

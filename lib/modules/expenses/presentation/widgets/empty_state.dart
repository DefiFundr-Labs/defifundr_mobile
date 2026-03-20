import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.icons.emptyExpense),
        Text('No expenses yet', style: context.theme.fonts.textMdSemiBold),
        Text(
          'Keep track of your contract-related spending\nhere.',
          textAlign: TextAlign.center,
          style: context.theme.fonts.textMdRegular.copyWith(
            color: context.theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

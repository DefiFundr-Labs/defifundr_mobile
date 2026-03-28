import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

void showExpenseSubmittedBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ExpenseSubmittedBottomSheet(),
  );
}

class ExpenseSubmittedBottomSheet extends StatelessWidget {
  const ExpenseSubmittedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.fromLTRB(16, 32, 16, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.theme.colors.brandFill,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(Assets.icons.receipt,
                  color: context.theme.colors.brandDefault)),
          SizedBox(height: 20.h),
          Text(
            context.l10n.expenseSubmitted,
            style: context.theme.fonts.heading2Bold,
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              context.l10n.expenseSubmittedDesc2,
              textAlign: TextAlign.center,
              style: context.theme.fonts.textMdRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          PrimaryButton(
            text: context.l10n.done,
            onPressed: () =>
                context.router.popUntilRouteWithName(ExpensesRoute.name),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

class DeleteExpenseSheet extends StatelessWidget {
  final Expense expense;

  const DeleteExpenseSheet({required this.expense});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.fromLTRB(20, 12, 20, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 48.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: context.theme.colors.strokePrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(context.l10n.deleteExpenseTitle, style: context.theme.fonts.heading3Bold),
          SizedBox(height: 4.h),
          Text(
            context.l10n.deleteExpensePrompt,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.theme.colors.fillTertiary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.name,
                        style: context.theme.fonts.textMdSemiBold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Expense Date: ${DateFormat('dd MMM yyyy').format(expense.expenseDate)}',
                        style: context.theme.fonts.textSmRegular.copyWith(
                          color: context.theme.colors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${expense.amount.toInt()} USDT',
                      style: context.theme.fonts.textMdSemiBold,
                    ),
                    SizedBox(height: 4.h),
                    StatusChip(status: expense.status, isDot: true),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: context.l10n.goBack,
                  backgroundColor: context.theme.colors.fillTertiary,
                  borderColor: Colors.transparent,
                  enableShine: false,
                  onPressed: () => context.router.maybePop(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SecondaryButton(
                  text: context.l10n.deleteExpense,
                  backgroundColor: context.theme.colors.redDefault,
                  textColor: context.theme.colors.contrastWhite,
                  enableShine: false,
                  onPressed: () {
                    context.router.popUntilRouteWithName(ExpensesRoute.name);
                    AppSnackbar.show(context, 'Expense deleted successfully');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

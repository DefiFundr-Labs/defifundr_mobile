import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseListItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseListItem({
    Key? key,
    required this.expense,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isLight ? context.theme.colors.bgB0 : context.theme.colors.bgB1,
          borderRadius: BorderRadius.circular(8),
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
                    style: context.theme.fonts.textMdRegular.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Expense Date: ${_formatDate(expense.expenseDate)}',
                    style: context.theme.fonts.textMdRegular.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${expense.amount.toStringAsFixed(2)} USDT',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: context.theme.colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                _buildStatusChip(context, expense.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, ExpenseStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case ExpenseStatus.approved:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        text = 'Approved';
        break;
      case ExpenseStatus.pending:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[700]!;
        text = 'Pending';
        break;
      case ExpenseStatus.rejected:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[700]!;
        text = 'Rejected';
        break;
    }

    return Row(
      children: [
        Container(
          height: 6.h,
          width: 6.w,
          decoration: BoxDecoration(
            color: textColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        SizedBox(width: 3.w),
        Text(
          text,
          style: context.theme.fonts.textMdSemiBold.copyWith(
            fontSize: 12.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

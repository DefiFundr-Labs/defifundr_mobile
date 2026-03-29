import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusChip extends StatelessWidget {
  final ExpenseStatus status;
  final bool isDot;

  const StatusChip({required this.status, this.isDot = false});

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late String label;

    switch (status) {
      case ExpenseStatus.approved:
        bg = context.theme.colors.greenFill;
        fg = context.theme.colors.greenDefault;
        label = 'Approved';
        break;
      case ExpenseStatus.pending:
        bg = context.theme.colors.orangeFill;
        fg = context.theme.colors.orangeDefault;
        label = 'Pending approval';
        break;
      case ExpenseStatus.rejected:
        bg = context.theme.colors.redFill;
        fg = context.theme.colors.redDefault;
        label = 'Rejected';
        break;
    }

    if (isDot) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6.h,
            width: 6.w,
            decoration: BoxDecoration(
              color: fg,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            label,
            style: context.theme.fonts.textSmMedium.copyWith(color: fg),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: fg.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: context.theme.fonts.textSmMedium.copyWith(color: fg),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showExpenseSubmittedBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ExpenseSubmittedBottomSheet(),
  );
}

class ExpenseSubmittedBottomSheet extends StatelessWidget {
  const ExpenseSubmittedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.indigo[100],
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.receipt_long,
              size: 40,
              color: Colors.indigo,
            ),
          ),

          SizedBox(height: 24),

          // Title
          Text(
            'Expense submitted',
            style: context.theme.fonts.heading2Bold.copyWith(
              color: context.theme.colors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 8),

          // Description
          Text(
            'An email has been sent for your request to be\nreviewed.',
            textAlign: TextAlign.center,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: 32),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: PrimaryButton(
              text: 'Done',
              onPressed: () {
                context.router.maybePop();
                context.router.maybePop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/feature/transaction_screen/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../core/shared/appbar/appbar.dart';

class TransactionDetailSheet extends StatelessWidget {
  final TransactionModel transaction;
  final String transactionIcon;
  final VoidCallback onHelp;
  final VoidCallback onShareReceipt;
  final double fiatValue;
  final Widget child;
  final Widget? contractContent;
  final Widget? timelineContent;

  const TransactionDetailSheet({
    super.key,
    required this.transaction,
    required this.transactionIcon,
    required this.fiatValue,
    required this.onHelp,
    required this.onShareReceipt,
    required this.child,
    this.contractContent,
    this.timelineContent,
  });

  String _getTransactionTitle(TransactionType type) {
    switch (type) {
      case TransactionType.withdrawal:
        return 'Withdrawal';
      case TransactionType.contract:
        return 'Contract Payment';
      case TransactionType.invoice:
        return 'Invoice';
      case TransactionType.quickpay:
        return 'QuickPay';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            title: _getTransactionTitle(transaction.type),
            isBack: true,
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalMargin(24.h),
                  _buildHeader(context),
                  VerticalMargin(24.h),
                  _buildTransactionDetails(context),
                  VerticalMargin(24.h),
                  transaction.type == TransactionType.contract
                      ? _buildTransactionContract(context)
                      : SizedBox.shrink(),
                  VerticalMargin(24.h),
                  transaction.type == TransactionType.invoice ||
                          transaction.type == TransactionType.contract
                      ? _buildTransactionTimeline(context)
                      : SizedBox.shrink(),
                  VerticalMargin(MediaQuery.sizeOf(context).height * .14.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                      bottom: 16.h + MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colors.bgB0.withAlpha(1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: onHelp,
                            icon: Icon(Icons.headset_mic_outlined),
                            label: Text('Help center'),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: theme.colors.fillTertiary,
                              foregroundColor: theme.colors.textPrimary,
                              side: BorderSide(
                                color: theme.colors.fillTertiary,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                        HorizontalMargin(16.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: onShareReceipt,
                            icon: Icon(Icons.share),
                            label: Text('Share receipt'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.theme.colors.blueActive,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))
        ])));
  }

  Container _buildTransactionDetails(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Container _buildTransactionContract(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(20),
      ),
      child: contractContent,
    );
  }

  Container _buildTransactionTimeline(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(20),
      ),
      child: timelineContent,
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32.h),
            decoration: BoxDecoration(
              color: theme.colors.bgB0,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(transactionIcon),
                VerticalMargin(16.h),
                Text(
                  '${transaction.amount} ${transaction.currency}',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: transaction.status == TransactionStatus.successful
                        ? AppColors.greenActive
                        : transaction.status == TransactionStatus.processing
                            ? AppColors.orangeActive
                            : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (fiatValue != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '≈ ${NumberFormat.simpleCurrency().format(fiatValue)}',
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: theme.colors.grayTertiary),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

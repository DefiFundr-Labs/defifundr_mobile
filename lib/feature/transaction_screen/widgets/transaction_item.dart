import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/feature/transaction_screen/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'transactionDetail',
          extra: transaction,
        );
      },
      child: Container(
        width: 303.w,
        height: 40.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTransactionIcon(transaction.type),
            HorizontalMargin(16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        transaction.title,
                        style: theme.textTheme.labelLarge,
                      ),
                      Text(
                        _formatTime(transaction.timestamp),
                        style: theme.textTheme.labelMedium!
                            .copyWith(color: theme.colors.textSecondary),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${transaction.amount} ${transaction.currency}',
                        style: theme.textTheme.labelLarge,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(_getStatusIcon(transaction.status)),
                          HorizontalMargin(4),
                          Text(
                            _getStatusText(transaction.status),
                            style: theme.textTheme.labelMedium!.copyWith(
                                color: _getStatusColor(transaction.status)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionIcon(TransactionType type) {
    String typeIcon;
    String arrowIcon;

    switch (type) {
      case TransactionType.withdrawal:
        typeIcon = AppIcons.currencyCircleDollar;
        arrowIcon = AppIcons.arrowOut;
        break;
      case TransactionType.contract:
        typeIcon = AppIcons.money;
        arrowIcon = AppIcons.arrowIn;
        break;
      case TransactionType.invoice:
        typeIcon = AppIcons.invoice;
        arrowIcon = AppIcons.arrowIn;
        break;
      case TransactionType.quickpay:
        typeIcon = AppIcons.handCoin;
        arrowIcon = AppIcons.arrowIn;
        break;
    }

    return Stack(
      children: [
        SvgPicture.asset(typeIcon),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(arrowIcon),
        )
      ],
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} ${timestamp.hour < 12 ? 'AM' : 'PM'}';
  }

  String _getStatusIcon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.processing:
        return AppIcons.orangeDot;
      case TransactionStatus.successful:
        return AppIcons.greenDot;
      case TransactionStatus.failed:
        return AppIcons.redDot;
    }
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.processing:
        return 'Processing';
      case TransactionStatus.successful:
        return 'Succesful';
      case TransactionStatus.failed:
        return 'Failed';
    }
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.processing:
        return AppColors.orangeDefault;
      case TransactionStatus.successful:
        return AppColors.greenActive;
      case TransactionStatus.failed:
        return AppColors.redActive;
    }
  }
}

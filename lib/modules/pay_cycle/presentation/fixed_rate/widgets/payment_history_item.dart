import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/pay_cycle/data/models/contract.dart';
import 'package:defifundr_mobile/modules/pay_cycle/data/models/payment_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentHistoryItemWidget extends StatelessWidget {
  final PaymentHistoryItem item;
  final VoidCallback? onTap;

  const PaymentHistoryItemWidget({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                      'For ${item.startDate.dayMonth} - ${item.endDate.dayMonthYear}',
                      style: context.theme.fonts.textMdSemiBold),
                ),
                Text('${item.amount.toInt()} ${item.currency}',
                    style: context.theme.fonts.textMdSemiBold),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Submitted: ${item.submissionDate.dayMonthYear}',
                    style: context.theme.fonts.textSmMedium.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ),
                _buildStatusWithDot(context, item.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusWithDot(BuildContext context, PaymentStatus status) {
    Color color;
    String text;
    switch (status) {
      case PaymentStatus.pending:
        color = context.theme.colors.orangeDefault;
        text = 'Pending approval';
        break;
      case PaymentStatus.approved:
      case PaymentStatus.paid:
        color = context.theme.colors.greenDefault;
        text = status == PaymentStatus.approved ? 'Approved' : 'Paid';
        break;
      case PaymentStatus.overdue:
        color = context.theme.colors.redDefault;
        text = 'Overdue';
        break;
      case PaymentStatus.pendingSubmission:
        color = context.theme.colors.orangeDefault;
        text = 'Pending submission';
        break;
      case PaymentStatus.pendingApproval:
        color = context.theme.colors.orangeDefault;
        text = 'Pending approval';
        break;
      case PaymentStatus.awaitingPayment:
        color = context.theme.colors.brandDefault;
        text = 'Awaiting payment';
        break;
      case PaymentStatus.rejected:
        color = context.theme.colors.redDefault;
        text = 'Rejected';
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: context.theme.fonts.textSmMedium.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}

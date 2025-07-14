import 'package:defifundr_mobile/modules/pay_cycle/data/models/contract.dart';
import 'package:defifundr_mobile/modules/pay_cycle/data/models/payment_history.dart';
import 'package:flutter/material.dart';

import 'status_chip.dart';

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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'For ${item.startDate.dayMonth} - ${item.endDate.dayMonth}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Submitted: ${item.submissionDate.dayMonthYear}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${item.amount.toInt()} ${item.currency}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                StatusChip(status: item.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart'; // You might need to add the intl package to your pubspec.yaml
import '../models/payment.dart';

class PaymentItemCard extends StatelessWidget {
  final Payment payment;

  const PaymentItemCard({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Determine status color
    Color statusColor;
    switch (payment.status) {
      case PaymentStatus.upcoming:
        statusColor =
            colorScheme.primary; // Example: Use primary color for upcoming
        break;
      case PaymentStatus.overdue:
        statusColor = colorScheme.error; // Example: Use error color for overdue
        break;
    }

    // Format date
    final formattedDate =
        DateFormat('dd MMMM yyyy').format(payment.estimatedDate);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: payment.iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                payment.icon, // Use dynamic icon path
                height: 16, // Match previous size
                width: 16, // Match previous size
                // Apply color
              ),
            ),
            const SizedBox(width: 16),
            // Payment Details (Title and Date)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    payment.title,
                    style: textTheme.titleMedium, // Adjust text style as needed
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Est. date: $formattedDate',
                    style: textTheme.bodySmall?.copyWith(
                        color: textTheme.bodySmall?.color
                            ?.withOpacity(0.7)), // Adjust text style as needed
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${payment.amount} ${payment.currency}',
                  style: textTheme.titleMedium, // Adjust text style as needed
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      payment.status == PaymentStatus.upcoming
                          ? 'In 7 days'
                          : 'Overdue', // You might want to calculate days dynamically
                      style: textTheme.bodySmall?.copyWith(
                          color: statusColor), // Adjust text style as needed
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

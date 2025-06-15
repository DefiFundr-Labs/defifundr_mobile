import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

import '../../../data/models/payment.dart';

class PaymentItemCard extends StatelessWidget {
  final Payment payment;

  const PaymentItemCard({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colors = theme.extension<AppColorExtension>()!;
    final fontTheme = theme.extension<AppFontThemeExtension>()!;

    // Determine status color
    Color statusColor;
    switch (payment.status) {
      case PaymentStatus.upcoming:
        statusColor = colors.greenDefault;
        break;
      case PaymentStatus.overdue:
        statusColor = colors.redDefault;
        break;
      default:
        statusColor = colors.textSecondary; // Default color
    }

    // Format date
    final formattedDate =
        DateFormat('dd MMMM yyyy').format(payment.estimatedDate);

    return SingleChildScrollView(
      child: Container(
        margin:
            const EdgeInsets.symmetric(vertical: 8.0), // Add vertical margin
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Adjust padding
        decoration: BoxDecoration(
          color: colors.bgB1, // Use bgB1 for the card background
          borderRadius: BorderRadius.circular(12.0), // Apply border radius
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the top
          children: [
            // Icon and Network/Status Badge (using Stack)
            Stack(
              clipBehavior:
                  Clip.none, // Allows badge to be outside Stack bounds
              children: [
                // Icon Container
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: payment
                        .iconBackgroundColor, // Use background color from Payment model
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      payment.icon,
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Placeholder Badge (similar to network badge in AssetListItem)
                Positioned(
                  bottom: -4, // Adjust position as needed
                  right: -4, // Adjust position as needed
                  child: Container(
                      padding: const EdgeInsets.all(2.0), // Adjust padding
                      decoration: BoxDecoration(
                        color: colors.greenDefault, // Use a color for the badge
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/images/ArrowDownLeft.png',
                          width: 12, height: 12)),
                ),
              ],
            ),
            const SizedBox(width: 12), // Spacing between icon and text

            // Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    payment.title, // Transaction title
                    style: fontTheme.textBaseSemiBold, // Style for title
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Handle long titles
                  ),
                  const SizedBox(height: 4), // Spacing
                  Text(
                    'Est. date: $formattedDate', // Format date
                    style: fontTheme.textSmRegular.copyWith(
                      color: colors.textSecondary, // Style for date
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12), // Spacing between details and amount

            // Amount and Status
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align text to the right
              children: [
                Text(
                  '${payment.amount} ${payment.currency}', // Amount and currency
                  style: fontTheme.textBaseSemiBold, // Style for amount
                ),
                const SizedBox(height: 4), // Spacing
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      payment.status == PaymentStatus.upcoming
                          ? 'In 7 days'
                          : payment.status
                              .toString()
                              .split('.')
                              .last, // Display status
                      style: fontTheme.textSmRegular.copyWith(
                          fontWeight: FontWeight.w600,
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

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class UpcomingPaymentItemCard extends StatelessWidget {
  final Payment payment;

  const UpcomingPaymentItemCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    final fontTheme = context.theme.fonts;
    final colors = context.theme.colors;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final estDate = DateTime(
      payment.estimatedDate.year,
      payment.estimatedDate.month,
      payment.estimatedDate.day,
    );
    final daysUntil = estDate.difference(today).inDays;

    String statusLabel;
    Color statusColor;
    if (payment.status == PaymentStatus.overdue || daysUntil < 0) {
      statusLabel = 'Overdue';
      statusColor = colors.redDefault;
    } else if (daysUntil == 0) {
      statusLabel = 'Today';
      statusColor = colors.orangeDefault;
    } else {
      statusLabel = 'In $daysUntil day${daysUntil == 1 ? '' : 's'}';
      statusColor = colors.brandDefault;
    }

    final formattedDate =
        DateFormat('dd MMMM yyyy').format(payment.estimatedDate);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: payment.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 16.sp,
              height: 16.sp,
              child: SvgPicture.asset(
                payment.icon,
                fit: BoxFit.scaleDown,
                width: 16.sp,
                height: 16.sp,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment.title,
                  style: fontTheme.textBaseSemiBold.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Est. date: $formattedDate',
                  style: fontTheme.textSmRegular.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${payment.amount} ${payment.currency}',
                style: fontTheme.textBaseSemiBold.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(height: 4),
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
                    statusLabel,
                    style: fontTheme.textSmRegular.copyWith(
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

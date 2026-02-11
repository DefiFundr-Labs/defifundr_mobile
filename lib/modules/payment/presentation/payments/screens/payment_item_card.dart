import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../data/models/payment.dart';

class PaymentItemCard extends StatelessWidget {
  final Payment payment;

  const PaymentItemCard({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontTheme = context.theme.fonts;
    final colors = context.theme.colors;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    Color statusColor;
    switch (payment.status) {
      case PaymentStatus.upcoming:
        statusColor = colors.greenDefault;
        break;
      case PaymentStatus.overdue:
        statusColor = colors.redDefault;
        break;
    }

    final formattedDate =
        DateFormat('dd MMMM yyyy').format(payment.estimatedDate);
    final formattedTime = DateFormat('hh:mm a').format(payment.estimatedDate);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isLightMode ? colors.bgB0 : colors.bgB1,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
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
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: colors.greenDefault,
                      border: Border.all(
                        color: colors.bgB0,
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      Assets.icons.arrowDownLeft,
                      width: 8.sp,
                      height: 8.sp,
                    ),
                  ),
                ),
              ],
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
                    '$formattedDate • $formattedTime',
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
                Text('${payment.amount} ${payment.currency}',
                    style: fontTheme.textBaseSemiBold.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    )),
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
                      payment.status == PaymentStatus.upcoming
                          ? 'Successful'
                          : 'Failed',
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
      ),
    );
  }
}

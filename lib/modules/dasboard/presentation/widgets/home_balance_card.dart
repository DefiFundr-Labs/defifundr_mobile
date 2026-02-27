import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBalanceCard extends StatelessWidget {
  final double totalBalance;
  final double changePercent;
  final double changeAmount;
  final VoidCallback? onTap;

  const HomeBalanceCard({
    super.key,
    required this.totalBalance,
    required this.changePercent,
    required this.changeAmount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    final isNegative = changePercent < 0;
    final hasActivity = totalBalance > 0 || changeAmount != 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: isLightMode ? colors.bgB0 : colors.bgB1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total balance',
                  style: fonts.textSmSemiBold.copyWith(
                    color: colors.textSecondary,
                    fontFamily: FontFamily.hankenGrotesk,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${totalBalance.toStringAsFixed(2)}',
                  style: fonts.heading1Bold.copyWith(
                    fontSize: 40.sp,
                    fontFamily: FontFamily.hankenGrotesk,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${isNegative ? '' : '+'}${changePercent.toStringAsFixed(4)}% (\$${changeAmount.abs().toStringAsFixed(2)})',
                  style: fonts.textMdMedium.copyWith(
                    color: hasActivity
                        ? (isNegative ? colors.redDefault : colors.greenDefault)
                        : colors.textTertiary,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textSecondary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

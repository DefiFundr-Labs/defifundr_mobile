import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractCard extends StatelessWidget {
  final TimeTrackingContract contract;
  final VoidCallback onTap;

  const ContractCard({
    Key? key,
    required this.contract,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.textPrimary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    ellipsify(word: contract.title, maxLength: 28),
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  clipBehavior: Clip.antiAlias,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: contract.status.fillColor(context),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: contract.status.borderColor(context),
                    ),
                  ),
                  child: Text(
                    contract.status.titleCase,
                    style: context.theme.fonts.textXsSemiBold.copyWith(
                      fontSize: 10.sp,
                      color: contract.status.textColor(context),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        fontSize: 12.sp,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      contract.type.titleCase,
                      style: context.theme.fonts.textMdSemiBold.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${contract.rate.toInt()} ${contract.currency}',
                      style: context.theme.fonts.textMdSemiBold.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      'Per Hour',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        fontSize: 12.sp,
                        color: context.theme.colors.textSecondary,
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

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractCard extends StatelessWidget {
  final Contract contract;
  final VoidCallback onTap;

  const ContractCard({
    Key? key,
    required this.contract,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contract.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 25.sp),
                  Text(
                    'Type',
                    style: context.theme.fonts.textSmRegular.copyWith(
                      fontSize: 12.sp,
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                  Text(
                    contract.type,
                    style: context.theme.fonts.textMdRegular.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: context.theme.colors.greenFill,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: context.theme.colors.greenStroke,
                    ),
                  ),
                  child: Text(
                    contract.status,
                    style: context.theme.fonts.textXsSemiBold.copyWith(
                      fontSize: 10.sp,
                      color: context.theme.colors.greenDefault,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 25.sp),
                Text(
                  '${contract.rate.toInt()} ${contract.currency}',
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
      ),
    );
  }
}

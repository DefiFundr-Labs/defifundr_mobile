import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetListItem extends StatelessWidget {
  final NetworkAsset asset;
  final VoidCallback? onTap;

  const AssetListItem({
    super.key,
    required this.asset,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          _buildAssetIcon(),
          SizedBox(width: 12.w),
          Expanded(child: _buildAssetInfo(context)),
          _buildBalanceInfo(context),
        ],
      ),
    );
  }

  Widget _buildAssetIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          asset.iconPath,
          width: 36.sp,
          height: 36.sp,
        ),
        if (asset.network != null)
          Positioned(
            bottom: -6,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset(
                asset.network!.iconPath,
                width: 16,
                height: 16,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAssetInfo(BuildContext context) {
    final fontTheme = context.theme.fonts;
    final colors = context.theme.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(asset.name,
            style: fontTheme.textBaseSemiBold.copyWith(
              color: colors.textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            )),
        SizedBox(height: 2.h),
        Row(
          children: [
            Text(
              asset.price,
              style: fontTheme.textSmRegular.copyWith(
                color: colors.textSecondary,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              asset.change,
              style: fontTheme.textSmRegular.copyWith(
                color: colors.redDefault,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceInfo(BuildContext context) {
    final fontTheme = context.theme.fonts;
    final colors = context.theme.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          asset.balance,
          style: fontTheme.textMdSemiBold.copyWith(
            color: colors.textPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          asset.balanceCurrency,
          style: fontTheme.textMdRegular.copyWith(
            color: colors.textSecondary,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

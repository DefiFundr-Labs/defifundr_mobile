import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// Widget for a single Network List Item
class NetworkListItem extends StatelessWidget {
  final Network network;
  final VoidCallback? onTap;

  const NetworkListItem({
    super.key,
    required this.network,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        child: Row(
          children: [
            // Icon
            Image.asset(
              network.iconPath,
              width: 36.w,
              height: 36.w,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet,
                  size: 20.w,
                  color: colors.textSecondary,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Network Details (Name and Subtitle)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    network.name,
                    style: fontTheme.textBaseSemiBold,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    network.subtitle,
                    style: fontTheme.textSmRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Balance Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  network.balance,
                  style: fontTheme.textBaseSemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  network.balanceCurrency,
                  style: fontTheme.textSmRegular.copyWith(
                    color: colors.textSecondary,
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

class SelectNetworkScreen extends StatelessWidget {
  final bool forDeposit;
  final NetworkAsset? selectedAsset;

  const SelectNetworkScreen({
    super.key,
    this.forDeposit = false,
    this.selectedAsset,
  });

  // Constants
  static const String _placeholderAddress =
      '0xf1EBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3';

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: DeFiRaiseAppBar(
        title: 'Select network',
        textStyle: fontTheme.heading3SemiBold.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
        isBack: true,
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isLightMode ? colors.bgB0 : colors.bgB1,
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10.sp),
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
            itemCount: Network.supportedNetworks.length,
            itemBuilder: (context, index) => _buildNetworkItem(context, index),
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkItem(BuildContext context, int index) {
    final network = Network.supportedNetworks[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: NetworkListItem(
        network: network,
        onTap: () => _handleNetworkSelection(context, network),
      ),
    );
  }

  void _handleNetworkSelection(BuildContext context, Network network) {
    if (forDeposit && selectedAsset != null) {
      _navigateToAssetDeposit(context, network);
    } else {
      Navigator.pop(context, network);
    }
  }

  void _navigateToAssetDeposit(BuildContext context, Network network) {
    context.pushNamed(
      RouteConstants.assetDeposit,
      extra: {
        'asset': selectedAsset!,
        'network': network,
        'address': _placeholderAddress,
      },
    );
  }
}

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance/widget/asset_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SelectAssetScreen extends StatelessWidget {
  final bool forReceive;

  const SelectAssetScreen({super.key, this.forReceive = false});

  // Constants
  static const String _placeholderAddress =
      '0xf1EBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3';
  static const String _ethereumNetworkName = 'Ethereum';

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fontTheme = context.theme.fonts;

    return Scaffold(
      appBar: DeFiRaiseAppBar(
        title: 'Select asset',
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
            color: colors.bgB0,
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 10.sp),
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
            itemCount: _supportedAssets.length,
            itemBuilder: (context, index) => _buildAssetItem(context, index),
          ),
        ),
      ),
    );
  }

  Widget _buildAssetItem(BuildContext context, int index) {
    final asset = _supportedAssets[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AssetListItem(
        asset: asset,
        onTap: () => _handleAssetSelection(context, asset),
      ),
    );
  }

  void _handleAssetSelection(BuildContext context, NetworkAsset asset) {
    if (forReceive) {
      _navigateToAssetDeposit(context, asset);
    } else {
      Navigator.pop(context, asset);
    }
  }

  void _navigateToAssetDeposit(BuildContext context, NetworkAsset asset) {
    final ethereumNetwork = Network(
      iconPath: Assets.images.ethPng.path,
      name: _ethereumNetworkName,
      subtitle: _ethereumNetworkName,
      balance: '',
      balanceCurrency: '',
    );

    context.pushNamed(
      RouteConstants.assetDeposit,
      extra: {
        'asset': asset,
        'network': ethereumNetwork,
        'address': _placeholderAddress,
      },
    );
  }

  // Extracted static data for better maintainability
  static List<NetworkAsset> _supportedAssets = [
    NetworkAsset(
      iconPath: Assets.images.ethPng.path,
      name: 'ETH',
      price: 'Ethereum',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 ETH',
    ),
    NetworkAsset(
      iconPath: Assets.images.usdtPng.path,
      name: 'USDC',
      price: 'USD Coin',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    NetworkAsset(
      iconPath: Assets.images.usdtPng.path,
      name: 'USDT',
      price: 'Tether USD',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 USDT',
    ),
    NetworkAsset(
      iconPath: Assets.images.dai.path,
      name: 'DAI',
      price: 'Dai Stablecoin',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 DAI',
    ),
    NetworkAsset(
      iconPath: Assets.images.usdd.path,
      name: 'USDD',
      price: 'Decentralized USD',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 USDD',
    ),
    NetworkAsset(
      iconPath: Assets.images.lusd.path,
      name: 'LUSD',
      price: 'Liquity USD',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 LUSD',
    ),
    NetworkAsset(
      iconPath: Assets.images.eurt.path,
      name: 'EURt',
      price: 'Euro Tether',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 EURt',
    ),
    NetworkAsset(
      iconPath: Assets.images.starknet.path,
      name: 'STARK',
      price: 'Starknet',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 STARK',
    ),
    NetworkAsset(
      iconPath: Assets.images.xdai.path,
      name: 'xDAI',
      price: 'Gnosis Chain',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 xDAI',
    ),
    NetworkAsset(
      iconPath: Assets.images.bnb.path,
      name: 'BNB',
      price: 'BNB Chain',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 BNB',
    ),
    NetworkAsset(
      iconPath: Assets.images.matic.path,
      name: 'POL',
      price: 'Polygon',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 POL',
    ),
  ];
}

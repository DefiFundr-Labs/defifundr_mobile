import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance/widget/asset_list_item.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class FundWalletScreen extends StatefulWidget {
  const FundWalletScreen({super.key});

  @override
  State<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends State<FundWalletScreen> {
  List<NetworkAsset> get _networkAssets {
    return Network.supportedNetworks.map((network) {
      final token = _nativeToken(network);
      return NetworkAsset(
        iconPath: network.iconPath,
        name: token,
        price: network.name,
        change: '',
        balance: '\$0.00',
        balanceCurrency: '0 $token',
        network: network,
      );
    }).toList();
  }

  String _nativeToken(Network network) {
    switch (network.name) {
      case 'Ethereum':
        return 'ETH';
      case 'Polygon':
        return 'POL';
      case 'Base':
        return 'BASE_ETH';
      case 'BNB Chain':
        return 'BNB';
      case 'Optimism':
        return 'OP_ETH';
      case 'Starknet':
        return 'STRK';
      case 'Arbitrum':
        return 'ARB_ETH';
      case 'Gnosis Chain':
        return 'xDAI';
      case 'zkSync Era':
        return 'ERA_ETH';
      case 'Celo':
        return 'CELO';
      default:
        return network.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: DeFiRaiseAppBar(
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Fund Wallet',
              style: fonts.heading2Bold.copyWith(
                color: colors.textPrimary,
                fontFamily: 'HankenGrotesk',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Top up your wallet to cover transaction fees when creating contracts and sending invoices.',
              style: fonts.textMdRegular.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isLightMode ? colors.bgB0 : colors.bgB1,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _networkAssets.length,
                separatorBuilder: (context, index) => Divider(
                  color: colors.grayQuaternary.withAlpha(60),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final asset = _networkAssets[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: AssetListItem(
                      asset: asset,
                      onTap: () {
                        context.router.push(
                          AssetDepositRoute(
                            asset: asset,
                            network: asset.network!,
                            address:
                                '0xfEBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3',
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

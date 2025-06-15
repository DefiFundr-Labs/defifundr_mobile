import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance_home_screen.dart'; // To reuse Asset data model and AssetListItem
import 'package:defifundr_mobile/modules/finance/presentation/select_network_screen.dart'; // Import SelectNetworkScreen and Network model
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/user_interface/appbar/appbar.dart'; // Import DeFiRaiseAppBar

// Convert to StatefulWidget to handle the selected asset temporarily
class SelectAssetScreen extends StatefulWidget {
  // Add a parameter to indicate if this is for the receive flow
  final bool forReceive;

  const SelectAssetScreen({Key? key, this.forReceive = false})
      : super(key: key);

  @override
  _SelectAssetScreenState createState() => _SelectAssetScreenState();
}

class _SelectAssetScreenState extends State<SelectAssetScreen> {
  // Dummy data for assets (replace with actual data)
  final List<Asset> dummyAssets = [
    Asset(
      iconPath: 'assets/images/usdc.png', // Placeholder icon path
      name: 'ETH',
      price: 'Ethereum',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 ETH',
    ),
    Asset(
      iconPath: 'assets/images/usdc.png', // Placeholder icon path
      name: 'USDC',
      price: 'USD Coin',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Asset(
      iconPath: 'assets/images/usdt.png', // Placeholder icon path
      name: 'USDT',
      price: 'Tether USD',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 USDT',
    ),
    Asset(
      iconPath: 'assets/images/dai.png', // Placeholder icon path
      name: 'DAI',
      price: 'Dai Stablecoin',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 DAI',
    ),
    Asset(
      iconPath: 'assets/images/usdd.png', // Placeholder icon path
      name: 'USDD',
      price: 'Decentralized USD',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 USDD',
    ),
    Asset(
      iconPath: 'assets/images/lusd.png', // Placeholder icon path
      name: 'LUSD',
      price: 'Liquity USD',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 LUSD',
    ),
    Asset(
      iconPath: 'assets/images/eurt.png', // Placeholder icon path
      name: 'EURt',
      price: 'Euro Tether',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 EURt',
    ),
    Asset(
      iconPath: 'assets/images/starknet.png', // Placeholder icon path
      name: 'STARK',
      price: 'Starknet',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 STARK',
    ),
    Asset(
      iconPath: 'assets/images/xdai.png', // Placeholder icon path
      name: 'xDAI',
      price: 'Gnosis Chain',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 xDAI',
    ),
    Asset(
      iconPath: 'assets/images/bnb.png', // Placeholder icon path
      name: 'BNB',
      price: 'BNB Chain',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 BNB',
    ),
    Asset(
      iconPath: 'assets/images/matic.png', // Placeholder icon path
      name: 'POL',
      price: 'Polygon',
      change: '', // Not shown in this view
      balance: '\$0.00',
      balanceCurrency: '0 POL',
    ),
    // Add more dummy assets as needed
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB0,
      appBar: const DeFiRaiseAppBar(
        title: 'Select asset',
        isBack: true,
      ), // Use shared AppBar
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colors.bgB1),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            itemCount: dummyAssets.length,
            itemBuilder: (context, index) {
              final asset = dummyAssets[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AssetListItem(
                  asset: asset,
                  onTap: () async {
                    if (widget.forReceive) {
                      // If for receive flow, navigate directly to AssetDepositScreen
                      // Assuming Ethereum network for USDC receive based on the provided design
                      final ethereumNetwork = Network(
                        iconPath:
                            'assets/images/eth.png', // Replace with actual Ethereum icon path
                        name: 'Ethereum',
                        subtitle: 'Ethereum', // Or relevant subtitle
                        balance: '', // Not needed for deposit
                        balanceCurrency: '', // Not needed for deposit
                      );
                      // TODO: Replace with actual generated address for the selected asset and network
                      const String placeholderAddress =
                          '0xf1EBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3';

                      context.pushNamed(
                        RouteConstants.assetDeposit,
                        extra: {
                          'asset': asset,
                          'network': ethereumNetwork,
                          'address': placeholderAddress
                        },
                      );
                    } else {
                      // If not for receive flow, pop with the selected asset
                      Navigator.pop(context, asset);
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

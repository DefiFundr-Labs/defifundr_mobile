import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/finance/presentation/finance_home_screen.dart'; // Import for Asset model
import 'package:defifundr_mobile/feature/finance/presentation/asset_deposit_screen.dart'; // Import for AssetDepositScreen
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart'; // Import DeFiRaiseAppBar

// Define a simple data model for a Network
class Network {
  final String iconPath;
  final String name;
  final String subtitle;
  final String balance;
  final String balanceCurrency;

  Network({
    required this.iconPath,
    required this.name,
    required this.subtitle,
    required this.balance,
    required this.balanceCurrency,
  });
}

// Widget for a single Network List Item
class NetworkListItem extends StatelessWidget {
  final Network network;

  const NetworkListItem({Key? key, required this.network}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          // Icon
          Image.asset(
            network.iconPath, // Assuming network icons are images
            width: 36, // Adjust size as needed
            height: 36, // Adjust size as needed
          ),
          const SizedBox(width: 12), // Spacing between icon and text
          // Network Details (Name and Subtitle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  network.name,
                  style: fontTheme.textBaseSemiBold, // Network name style
                ),
                const SizedBox(height: 2),
                Text(
                  network.subtitle,
                  style: fontTheme.textSmRegular
                      ?.copyWith(color: colors.textSecondary), // Subtitle style
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
                style: fontTheme.textBaseSemiBold, // Balance amount style
              ),
              const SizedBox(height: 4),
              Text(
                network.balanceCurrency,
                style: fontTheme.textSmRegular?.copyWith(
                    color: colors.textSecondary), // Balance currency style
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectNetworkScreen extends StatelessWidget {
  // Add parameters for the receive flow
  final bool forDeposit;
  final Asset? selectedAsset;

  const SelectNetworkScreen(
      {Key? key, this.forDeposit = false, this.selectedAsset})
      : super(key: key);

  // Dummy data for networks (replace with actual data)
  static final List<Network> dummyNetworks = [
    Network(
      iconPath: 'assets/images/eth.png',
      name: 'Ethereum',
      subtitle: 'Ethereum',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/starknet.png',
      name: 'Starknet',
      subtitle: 'Starknet',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/base.png', 
      name: 'Base',
      subtitle: 'Base',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/optimism.png', 
      name: 'Optimism',
      subtitle: 'Optimism',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/arbitrum.png', 
      name: 'Arbitrum',
      subtitle: 'Arbitrum',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/bnb.png', 
      name: 'BNB Chain',
      subtitle: 'BNB Chain',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/matic.png', 
      name: 'Polygon',
      subtitle: 'Polygon',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/gnosis.png', 
      name: 'Gnosis Chain',
      subtitle: 'Gnosis Chain',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/zksync.png', 
      name: 'zkSync Era',
      subtitle: 'zkSync Era',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/celo.png', 
      name: 'Celo',
      subtitle: 'Celo',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB0,
      appBar: const DeFiRaiseAppBar(
        title: 'Select network',
        isBack: true,
      ), // Use shared AppBar
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colors.bgB1,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: dummyNetworks.length,
            itemBuilder: (context, index) {
              final network = dummyNetworks[index];
              return InkWell(
                onTap: () {
                  if (forDeposit && selectedAsset != null) {
                    // If for deposit, navigate to AssetDepositScreen
                    context.pushNamed(
                      RouteConstants.assetDeposit,
                      extra: {'asset': selectedAsset!, 'network': network},
                    );
                  } else {
                    // If not for deposit, pop with the selected network
                    Navigator.pop(context, network);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
                  child:
                      NetworkListItem(network: network), // Use NetworkListItem
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

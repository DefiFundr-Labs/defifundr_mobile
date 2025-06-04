import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';

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
                  style: fontTheme.textBaseMedium, // Network name style
                ),
                const SizedBox(height: 4),
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
                style: fontTheme.textBaseMedium, // Balance amount style
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
  const SelectNetworkScreen({Key? key}) : super(key: key);

  // Dummy data for networks (replace with actual data)
  static final List<Network> dummyNetworks = [
    Network(
      iconPath: 'assets/images/eth.png', // Placeholder icon path
      name: 'Ethereum',
      subtitle: 'Ethereum',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/starknet.png', // Placeholder icon path
      name: 'Starknet',
      subtitle: 'Starknet',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/base.png', // Placeholder icon path
      name: 'Base',
      subtitle: 'Base',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/optimism.png', // Placeholder icon path
      name: 'Optimism',
      subtitle: 'Optimism',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/arbitrum.png', // Placeholder icon path
      name: 'Arbitrum',
      subtitle: 'Arbitrum',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/bnb.png', // Placeholder icon path
      name: 'BNB Chain',
      subtitle: 'BNB Chain',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/matic.png', // Placeholder icon path
      name: 'Polygon',
      subtitle: 'Polygon',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/gnosis.png', // Placeholder icon path
      name: 'Gnosis Chain',
      subtitle: 'Gnosis Chain',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/zksync.png', // Placeholder icon path
      name: 'zkSync Era',
      subtitle: 'zkSync Era',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: 'assets/images/celo.png', // Placeholder icon path
      name: 'Celo',
      subtitle: 'Celo',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    // Add more dummy networks as needed
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB1, // Assuming a light background color
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: colors.textPrimary), // Back button
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select network', // Screen title
          style: fontTheme.heading2Bold, // Heading style
        ),
        backgroundColor: colors.bgB1,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colors.bgB0),
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
            itemCount: dummyNetworks.length,
            itemBuilder: (context, index) {
              final network = dummyNetworks[index];
              return InkWell(
                onTap: () {
                  // TODO: Navigate to Address Book screen or similar after selecting network
                  context.pushNamed(RouteConstants.addressBook);
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

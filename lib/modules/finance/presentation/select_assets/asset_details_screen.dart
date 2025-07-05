import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart'; // Import DeFiRaiseAppBar
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance/widget/asset_list_item.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart'; // Assuming Payment model can be reused for transactions
import 'package:defifundr_mobile/modules/payment/presentation/payments/screens/payment_item_card.dart'; // Reusing PaymentItemCard
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart'; // For icons

// Assuming you pass the Asset and Network objects to this screen
class AssetDetailsScreen extends StatelessWidget {
  final NetworkAsset asset;
  final Network network;

  const AssetDetailsScreen(
      {Key? key, required this.asset, required this.network})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;
    final textTheme = context.theme.textTheme;
    // Dummy data for transactions (replace with actual data)
    final List<Payment> dummyTransactions = [
      Payment(
        title: 'Withdrawal',
        paymentType: PaymentType.invoice, // Placeholder type
        estimatedDate: DateTime(2025, 5, 21), // Placeholder date
        amount: 581,
        paymentNetwork: PaymentNetwork.ethereum, // Placeholder network
        currency: 'USDC',
        status: PaymentStatus.overdue, // Placeholder status (red in image)
        icon: AppIcons.money, // Using the image path
        iconBackgroundColor: colors.brandDefault, // Using theme color
      ),
      Payment(
        title: 'MintForge Bug fixes a...',
        paymentType: PaymentType.contract, // Placeholder type
        estimatedDate: DateTime(2025, 5, 21), // Placeholder date
        amount: 581,
        paymentNetwork: PaymentNetwork.starknet, // Placeholder network
        currency: 'USDC',
        status: PaymentStatus.upcoming, // Placeholder status (green in image)
        icon: AppIcons.invoice, // Using the image path
        iconBackgroundColor: colors.orangeDefault, // Using theme color
      ),
      // Add more dummy transactions as needed
    ];
    final List<NetworkAsset> dummyAssets = [
      NetworkAsset(
        iconPath: 'assets/images/usdt.png', // Placeholder icon path
        name: 'Tether USD',
        price: '\$1.00',
        change: '-0.0018%',
        balance: '\$476.19',
        balanceCurrency: '581 USDT',
        network: Network.supportedNetworks.firstWhere(
            (net) => net.name == 'Ethereum'), // Assign Ethereum network
      ),
      NetworkAsset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'USD Coin',
        price: '\$0.99',
        change: '-0.005%',
        balance: '\$381.19',
        balanceCurrency: '381 USDC',
        network: Network.supportedNetworks.firstWhere(
            (net) => net.name == 'Optimism'), // Assign Optimism network
      ),
      NetworkAsset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'USD Coin',
        price: '\$0.99',
        change: '-0.005%',
        balance: '\$200.19',
        balanceCurrency: '200 USDC',
        network: Network.supportedNetworks
            .firstWhere((net) => net.name == 'Base'), // Assign Base network
      ),
      // Add more dummy assets as needed
    ];

    return Scaffold(
      backgroundColor: colors.bgB0, // Assuming a light background color
      appBar: DeFiRaiseAppBar(
        title: asset.name,
        isBack: true,
      ), // Use shared AppBar
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Asset Info Section (replace with actual asset data)
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colors.bgB1, // Light blue background
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Asset Icon (replace with actual asset icon)
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: colors.brandDefault, // Placeholder color
                      child:
                          Image.asset(asset.iconPath), // Use actual asset icon
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '581 ${asset.name}', // Placeholder balance
                      style: fontTheme.heading1Bold, // Large bold text
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '≈ \$581.19', // Placeholder approximate value
                      style: fontTheme.textBaseRegular.copyWith(
                          color: colors.textSecondary), // Smaller text
                    ),
                    const SizedBox(height: 24),
                    // Receive and Withdraw Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to SelectAssetScreen to start the receive flow
                              context.pushNamed(RouteConstants.receive);
                            },
                            icon: SvgPicture.asset('assets/icons/signIn.svg',
                                height: 20,
                                width: 20,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  BlendMode.srcIn,
                                )),
                            label: Text(
                              'Receive',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? colors.blueDefault // Light mode color
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? colors.brandFill // Light mode color
                                  : colors.bgB2,
                              foregroundColor: colors.textPrimary,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.pushNamed(RouteConstants.withdraw);
                            },
                            icon: SvgPicture.asset('assets/icons/signOut.svg',
                                height: 20,
                                width: 20,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  BlendMode.srcIn,
                                )),
                            label: Text(
                              'Withdraw',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? colors.blueDefault // Light mode color
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? colors.brandFill // Light mode color
                                  : colors.bgB2,
                              foregroundColor: colors.textPrimary,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // My USDC Section
              Text(
                'My ${asset.name}', // Dynamic label based on asset name
                style: textTheme.displayMedium, // Section title style
              ),
              const SizedBox(height: 16),
              // TODO: Add My USDC list here (based on the second image if needed, or a simple list)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                    color: colors.bgB1,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    // Replaced with ListView.builder
                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling for this list
                      itemCount: dummyAssets.length,
                      itemBuilder: (context, index) {
                        final asset = dummyAssets[index];
                        return AssetListItem(
                          asset: asset,
                          onTap: () {
                            // Get the default network for this asset (using the first network for now)
                            final defaultNetwork =
                                Network.supportedNetworks.first;
                            context.pushNamed(
                              RouteConstants.assetDetails,
                              extra: {
                                'asset': asset,
                                'network': defaultNetwork,
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Transactions Section
              Text(
                'Transactions', // Section title
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              // Transactions List (using PaymentItemCard)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dummyTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = dummyTransactions[index];
                  return PaymentItemCard(
                      payment: transaction); // Reuse PaymentItemCard
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

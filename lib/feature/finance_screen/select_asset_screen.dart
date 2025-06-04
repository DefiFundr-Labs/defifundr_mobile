import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/feature/finance_screen/finance_home_screen.dart'; // To reuse Asset data model and AssetListItem
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';

class SelectAssetScreen extends StatelessWidget {
  const SelectAssetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

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
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'DAI',
        price: 'Dai Stablecoin',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 DAI',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'USDD',
        price: 'Decentralized USD',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 USDD',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'LUSD',
        price: 'Liquity USD',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 LUSD',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'EURt',
        price: 'Euro Tether',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 EURt',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'STARK',
        price: 'Starknet',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 STARK',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'xDAI',
        price: 'Gnosis Chain',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 xDAI',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'BNB',
        price: 'BNB Chain',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 BNB',
      ),
      Asset(
        iconPath: 'assets/images/usdc.png', // Placeholder icon path
        name: 'POL',
        price: 'Polygon',
        change: '', // Not shown in this view
        balance: '\$0.00',
        balanceCurrency: '0 POL',
      ),
      // Add more dummy assets as needed
    ];

    return Scaffold(
      backgroundColor: colors.bgB1, // Assuming a light background color
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: colors.textPrimary), // Back button
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select asset', // Screen title
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            itemCount: dummyAssets.length,
            itemBuilder: (context, index) {
              final asset = dummyAssets[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: AssetListItem(
                  asset: asset,
                  onTap: () {
                    // Return the selected asset to the previous screen (WithdrawScreen)
                    Navigator.pop(context, asset);
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

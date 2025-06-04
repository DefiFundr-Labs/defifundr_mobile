import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/feature/payment_screens/models/payment.dart'; // Assuming Payment model can be reused for transactions
import 'package:defifundr_mobile/feature/payment_screens/widgets/payment_item_card.dart'; // Reusing PaymentItemCard
import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:go_router/go_router.dart'; // For icons

// Assuming you pass the Asset object to this screen
class AssetDetailsScreen extends StatelessWidget {
  // final Asset asset; // Uncomment and add Asset model if needed

  const AssetDetailsScreen({Key? key}) : super(key: key);

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

    return Scaffold(
      backgroundColor: colors.bgB1, // Assuming a light background color
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: colors.textPrimary), // Back button
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'USD Coin', // Dynamic title based on asset name
          style: fontTheme.heading2Bold, // Heading style
        ),
        backgroundColor: colors.bgB1,
        elevation: 0,
      ),
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
                  color: colors.bgB0, // Light blue background
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Asset Icon (replace with actual asset icon)
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: colors.brandDefault, // Placeholder color
                      child: Icon(Icons.attach_money,
                          color: colors.textWhite,
                          size: 30), // Placeholder icon
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '581 USDC', // Placeholder balance
                      style: fontTheme.heading1Bold, // Large bold text
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '≈ \$581.19', // Placeholder approximate value
                      style: fontTheme.textBaseRegular?.copyWith(
                          color: colors.textSecondary), // Smaller text
                    ),
                    const SizedBox(height: 24),
                    // Receive and Withdraw Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.pushNamed(RouteConstants.selectAsset);
                            },
                            icon: Icon(
                              Icons.arrow_downward,
                              color: colors.blueDefault,
                            ),
                            label: Text(
                              'Receive',
                              style: TextStyle(color: colors.blueDefault),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.brandFill,
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
                            icon: Icon(
                              Icons.arrow_upward,
                              color: colors.blueDefault,
                            ),
                            label: Text(
                              'Withdraw',
                              style: TextStyle(color: colors.blueDefault),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.brandFill,
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
                'My USDC', // Dynamic label based on asset name
                style: textTheme.displayMedium, // Section title style
              ),
              const SizedBox(height: 16),
              // TODO: Add My USDC list here (based on the second image if needed, or a simple list)
              Container(
                height: 100, // Placeholder height
                color: colors.bgB1, // Placeholder background
                child: Center(
                    child: Text('My USDC List Placeholder',
                        style: fontTheme.textBaseRegular)),
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

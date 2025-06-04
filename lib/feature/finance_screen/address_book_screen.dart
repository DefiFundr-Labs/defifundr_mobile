import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';

class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    // Dummy data for address book entries
    final List<Map<String, String>> dummyAddresses = [
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'Ethereum',
        'address': '0xC524b945dDB20f703338f4696102D10bbC12629C',
      },
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'Starknet',
        'address': '0xCa14007Eff0dB1F8135f4C25B34De49AB0d42766',
      },
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'Universal address',
        'address': '0xC524b945dDB20f703338f4696102D10bbC12629C',
      },
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'Optimism',
        'address': '0xC524b945dDB20f703338f4696102D10bbC12629C',
      },
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'Arbitrum',
        'address': '0xC524b945dDB20f703338f4696102D10bbC12629C',
      },
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'Polygon',
        'address': '0xC524b945dDB20f703338f4696102D10bbC12629C',
      },
      {
        'icon': 'assets/images/usdc.png', // Placeholder icon
        'name': 'Zion\'s wallet',
        'network': 'BNB Chain',
        'address': '0xC524b945dDB20f703338f4696102D10bbC12629C',
      },
      // Add more dummy addresses as needed
    ];

    return Scaffold(
      backgroundColor: colors.bgB0,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Address book',
          style: fontTheme.heading2Bold,
        ),
        backgroundColor: colors.bgB0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: dummyAddresses.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Placeholder for illustration
                            Icon(Icons.book,
                                size: 80,
                                color: colors.textSecondary.withOpacity(0.5)),
                            const SizedBox(height: 16),
                            Text(
                              'No saved addresses yet',
                              style: fontTheme.textBaseBold,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Save your go-to crypto addresses so sending funds is faster and safer.',
                              style: fontTheme.textSmRegular
                                  ?.copyWith(color: colors.textSecondary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      itemCount: dummyAddresses.length,
                      itemBuilder: (context, index) {
                        final addressEntry = dummyAddresses[index];
                        return Card(
                          color: colors.bgB1, // Card background color
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0), // Spacing between cards
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // Placeholder for icon (replace with actual image/SVG)
                                CircleAvatar(
                                  // Using CircleAvatar as a placeholder for the icon
                                  backgroundColor: colors
                                      .brandDefault, // Placeholder background color
                                  child: Text('Z',
                                      style: fontTheme.heading2Bold?.copyWith(
                                          color: colors
                                              .textWhite)), // Placeholder text
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        addressEntry['name']!,
                                        style: fontTheme
                                            .textBaseMedium, // Address name style
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            addressEntry['address']!,
                                            style: fontTheme.textSmRegular
                                                ?.copyWith(
                                                    color: colors
                                                        .textSecondary), // Address style
                                            overflow: TextOverflow
                                                .ellipsis, // Prevent overflow
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2.0),
                                            decoration: BoxDecoration(
                                              color: colors
                                                  .bgB2, // Light grey background
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12.0), // Pill shape
                                            ),
                                            child: Text(
                                              addressEntry['network']!,
                                              style: fontTheme.textXsMedium
                                                  ?.copyWith(
                                                      color: colors
                                                          .textSecondary), // Network text style
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Options icon
                                IconButton(
                                  icon: Icon(Icons.more_horiz,
                                      color: colors.textSecondary),
                                  onPressed: () {
                                    // TODO: Implement options menu
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            // Add New Address Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(RouteConstants.addAddress);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault, // Purple button color
                    foregroundColor: colors.textWhite, // White text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child:
                      Text('Add new address', style: fontTheme.textBaseMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/modules/finance/presentation/add_address_screen.dart';
import 'dart:math';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart'; // Import DeFiRaiseAppBar

// Define a data model for a saved address entry
class SavedAddress {
  final String iconPath; // Assuming you'll store an icon path
  final String name;
  final String network;
  final String address;

  SavedAddress({
    required this.iconPath,
    required this.name,
    required this.network,
    required this.address,
  });
}

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({Key? key}) : super(key: key);

  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  // Use a mutable list to hold the addresses
  final List<SavedAddress> _addresses = [
    // Convert dummy data to SavedAddress objects
    SavedAddress(
      iconPath: 'assets/images/usdc.png',
      name: 'Zion\'s wallet',
      network: 'Ethereum',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
    SavedAddress(
      iconPath: 'assets/images/usdc.png',
      name: 'Zion\'s wallet',
      network: 'Starknet',
      address: '0xCa14007Eff0dB1F8135f4C25B34De49AB0d42766',
    ),
    // Add other dummy addresses here converted to SavedAddress
    SavedAddress(
      iconPath: 'assets/images/usdc.png', // Placeholder icon
      name: 'Zion\'s wallet',
      network: 'Universal address',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
    SavedAddress(
      iconPath: 'assets/images/usdc.png', // Placeholder icon
      name: 'Zion\'s wallet',
      network: 'Optimism',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
    SavedAddress(
      iconPath: 'assets/images/usdc.png', // Placeholder icon
      name: 'Zion\'s wallet',
      network: 'Arbitrum',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
    SavedAddress(
      iconPath: 'assets/images/usdc.png', // Placeholder icon
      name: 'Zion\'s wallet',
      network: 'Polygon',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
    SavedAddress(
      iconPath: 'assets/images/usdc.png', // Placeholder icon
      name: 'Zion\'s wallet',
      network: 'BNB Chain',
      address: '0xC524b945dDB20f703338f4696102D10bbC12629C',
    ),
  ];

  // Method to add a new address and update the state
  void _addAddress(SavedAddress newAddress) {
    setState(() {
      _addresses.add(newAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB0,
      // Use shared AppBar
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            DeFiRaiseAppBar(
              title: 'Address book',
              isBack: true,
            ),
            SizedBox(height: 16),
            Expanded(
              child: _addresses.isEmpty
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
                                  .copyWith(color: colors.textSecondary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: colors.bgB1,
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: ListView.builder(
                        itemCount: _addresses.length,
                        itemBuilder: (context, index) {
                          final addressEntry = _addresses[index];
                          return Card(
                            color: colors.bgB1, // Card background color
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0), // Spacing between cards
                            child: InkWell(
                              // Add InkWell for tap effect
                              onTap: () {
                                // Return the selected address to the previous screen
                                Navigator.pop(context, addressEntry.address);
                              },
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
                                          style: fontTheme.heading2Bold.copyWith(
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
                                            addressEntry.name,
                                            style: fontTheme
                                                .textBaseMedium, // Address name style
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Text(
                                                addressEntry.address.length > 24
                                                    ? '${addressEntry.address.substring(0, 24)}...'
                                                    : addressEntry.address,
                                                style: fontTheme.textSmRegular
                                                    .copyWith(
                                                        color: colors
                                                            .textSecondary), // Address style
                                                overflow: TextOverflow
                                                    .ellipsis, // Prevent overflow
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 2.0),
                                                decoration: BoxDecoration(
                                                  color: colors
                                                      .bgB2, // Light grey background
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0), // Pill shape
                                                ),
                                                child: Text(
                                                  addressEntry.network,
                                                  style: fontTheme.textXsMedium
                                                      .copyWith(
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
                            ),
                          );
                        },
                      ),
                    ),
            ),
            // Add New Address Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // Navigate to AddAddressScreen and wait for result
                    final newAddress = await Navigator.push<SavedAddress>(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddAddressScreen()),
                    );
                    if (newAddress != null) {
                      _addAddress(newAddress);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors
                        .brandDefault, // Use brandDefault for button background
                    foregroundColor: colors.textWhite, // White text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0), // Pill shape
                    ),
                    textStyle: fontTheme.textBaseMedium, // Button text style
                  ),
                  child: Text(
                    'Add new address',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black // Light mode color
                          : Colors.white,
                    ), // Button text color
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

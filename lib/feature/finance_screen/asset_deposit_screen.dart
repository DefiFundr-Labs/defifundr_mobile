import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/feature/finance_screen/finance_home_screen.dart'; // For Asset model
import 'package:defifundr_mobile/feature/finance_screen/select_network_screen.dart'; // For Network model
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart'; // Import DeFiRaiseAppBar
import 'package:qr_flutter/qr_flutter.dart'; // Import qr_flutter library

class AssetDepositScreen extends StatelessWidget {
  final Asset asset;
  final Network network;
  final String address; // Add address field

  const AssetDepositScreen({
    Key? key,
    required this.asset,
    required this.network,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB1,
      // Use shared AppBar
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              DeFiRaiseAppBar(
                isBack: true,
              ),
              SizedBox(height: 32),
              // Warning Message
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0), // Adjusted padding
                decoration: BoxDecoration(
                  color: colors.bgB0, // Use orangeFill
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: colors.orangeDefault,
                        size: 20), // Use orangeDefault, adjusted size
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Send only ${asset.name} via the ${network.name} network. Using any other asset or network will result in permanent loss.', // Dynamic warning text
                        style: fontTheme.textMdMedium?.copyWith(
                            color: colors.textPrimary), // Use orangeDefault
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // QR Code
              Container(
                padding:
                    const EdgeInsets.all(16.0), // Add padding around QR code
                decoration: BoxDecoration(
                  color: colors.bgB0, // White background for QR code area
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                ),
                child: QrImageView(
                  data: address, // Use the provided address for QR code
                  version: QrVersions.auto,
                  size: 200.0,
                  backgroundColor:
                      colors.bgB0, // White background for QR code itself
                  foregroundColor:
                      colors.textPrimary, // Black for QR code pattern
                ),
              ),
              const SizedBox(height: 24),

              // Network, Asset, and Address Details
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: colors.bgB0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    // Network
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Network',
                            style: fontTheme.textSmRegular
                                ?.copyWith(color: colors.textSecondary)),
                        Row(
                          children: [
                            // Assuming network.iconPath is a valid image asset path
                            Image.asset(network.iconPath,
                                width: 20, height: 20), // Network icon
                            const SizedBox(width: 4),
                            Text(network.name,
                                style:
                                    fontTheme.textBaseMedium), // Network name
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12), // Spacing
                    // Asset
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Asset',
                            style: fontTheme.textSmRegular
                                ?.copyWith(color: colors.textSecondary)),
                        Row(
                          children: [
                            // Assuming asset.iconPath is a valid image asset path
                            Image.asset(asset.iconPath,
                                width: 20, height: 20), // Asset icon
                            const SizedBox(width: 4),
                            Text(asset.name,
                                style: fontTheme.textBaseMedium), // Asset name
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12), // Spacing
                    // Address
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align to the top
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Address',
                            style: fontTheme.textSmRegular
                                ?.copyWith(color: colors.textSecondary)),
                        const SizedBox(
                            width: 16), // Spacing between label and address
                        Expanded(
                          child: Row(
                            // Use Row for address and copy icon side-by-side
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align items to the top
                            mainAxisAlignment:
                                MainAxisAlignment.end, // Align to the end
                            children: [
                              Expanded(
                                // Allow address text to take available space
                                child: Text(
                                  address, // Use the provided address
                                  style: fontTheme.textBaseMedium?.copyWith(
                                      color:
                                          colors.textPrimary), // Address style
                                  textAlign: TextAlign
                                      .end, // Align address text to the end
                                  overflow: TextOverflow
                                      .ellipsis, // Handle long addresses
                                  maxLines:
                                      2, // Allow up to 2 lines for address
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      8), // Spacing between address and copy icon
                              Icon(Icons.copy,
                                  color: colors.textSecondary,
                                  size: 20), // Copy icon
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(), // Pushes the button to the bottom

              // Share Address Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Share functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault, // Purple background
                    foregroundColor: colors.textWhite, // White text
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0), // Pill shape
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload, color: colors.textWhite), // Share icon
                      const SizedBox(width: 8), // Spacing
                      Text('Share address',
                          style: fontTheme.textBaseMedium?.copyWith(
                              color: colors.textWhite)), // Button text
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

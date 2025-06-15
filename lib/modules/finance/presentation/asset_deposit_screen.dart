import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance_home_screen.dart'; // For Asset model
import 'package:defifundr_mobile/modules/finance/presentation/select_network_screen.dart'; // For Network model
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart'; // Import DeFiRaiseAppBar
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
      backgroundColor: colors.bgB0,
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
                  color: colors.bgB1, // Use orangeFill
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

              // Combined QR Code and Details Container
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 55), // Padding for the combined container
                decoration: BoxDecoration(
                  color: colors.bgB1, // White background
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                child: Column(
                  children: [
                    // QR Code
                    QrImageView(
                      data: address, // Use the provided address for QR code
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor:
                          colors.bgB1, // White background for QR code itself
                      foregroundColor:
                          colors.textPrimary, // Black for QR code pattern
                    ),
                    const SizedBox(
                        height: 42), // Spacing between QR and details
                    // Network, Asset, and Address Details
                    Column(
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
                                    style: fontTheme
                                        .textBaseMedium), // Network name
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 36), // Spacing
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
                                    style:
                                        fontTheme.textBaseMedium), // Asset name
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 36), // Spacing
                        // Address
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align to the top
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Address',
                                      style: fontTheme.textSmRegular?.copyWith(
                                          color: colors.textSecondary)),
                                  const SizedBox(
                                      height:
                                          4), // Spacing between label and address
                                  Text(
                                    address, // Use the provided address
                                    style: fontTheme.textBaseMedium?.copyWith(
                                        color: colors
                                            .textPrimary), // Address style
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 100),

                            Icon(Icons.copy,
                                color: colors.textSecondary,
                                size: 20), // Copy icon
                          ],
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
                      Icon(Icons.upload, color: Colors.white), // Share icon
                      const SizedBox(width: 8), // Spacing
                      Text('Share address',
                          style: fontTheme.textBaseMedium
                              ?.copyWith(color: Colors.white)), // Button text
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

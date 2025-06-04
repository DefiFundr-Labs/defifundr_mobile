import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB0,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add address',
          style: fontTheme.heading2Bold,
        ),
        backgroundColor: colors.bgB0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Asset Field
              Text(
                'Asset',
                style: fontTheme.textSmRegular
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'USDC', // Placeholder asset
                      style: fontTheme.textBaseMedium,
                    ),
                    // Placeholder for Asset Icon
                    Icon(Icons.attach_money, color: colors.textPrimary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Network Field
              Text(
                'Network',
                style: fontTheme.textSmRegular
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ethereum', // Placeholder network
                      style: fontTheme.textBaseMedium,
                    ),
                    // Placeholder for Network Icon
                    Icon(Icons.swap_vert, color: colors.textPrimary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Wallet address Input Field
              Text(
                'Wallet address',
                style: fontTheme.textSmRegular
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText:
                              '0xC524b945dDB20f703338f4696102D10bbC12629C', // Placeholder address
                          hintStyle: fontTheme.textBaseRegular
                              ?.copyWith(color: colors.textTertiary),
                          border: InputBorder.none,
                          isDense: true, // Reduce vertical space
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: fontTheme.textBaseRegular,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Clear icon
                    Icon(Icons.cancel, color: colors.textSecondary),
                    const SizedBox(width: 8),
                    // Scan icon
                    Icon(Icons.qr_code_scanner, color: colors.textPrimary),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Wallet label Input Field
              Text(
                'Wallet label',
                style: fontTheme.textSmRegular
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Zion\'s wallet', // Placeholder label
                    hintStyle: fontTheme.textBaseRegular
                        ?.copyWith(color: colors.textTertiary),
                    border: InputBorder.none,
                    isDense: true, // Reduce vertical space
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: fontTheme.textBaseRegular,
                ),
              ),

              const Spacer(), // Pushes the button to the bottom

              // Save Button
              SizedBox(
                // Wrap in SizedBox to make the button full width
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Save functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault, // Purple button color
                    foregroundColor: colors.textWhite, // White text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text('Save',
                      style: fontTheme.textBaseMedium), // Text style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

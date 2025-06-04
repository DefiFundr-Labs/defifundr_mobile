import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';

class SentScreen extends StatelessWidget {
  const SentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB0,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: colors.textPrimary), // Close button
          onPressed: () =>
              Navigator.pop(context), // Assuming closing the screen
        ),
        title: Text(
          'Sent!',
          style: fontTheme.heading2Bold,
        ),
        backgroundColor: colors.bgB0,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkmark Icon
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: colors.brandFill, // Light purple background
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check, // Checkmark icon
                  size: 40,
                  color: colors.brandDefault, // Purple color
                ),
              ),
              const SizedBox(height: 24),

              // Success Message
              Text(
                'Sent!',
                style: fontTheme.heading2Bold, // Bold heading
              ),
              const SizedBox(height: 8),

              // Transaction Details
              Text(
                '5 USDC was successfully sent to',
                style: fontTheme.textBaseRegular
                    ?.copyWith(color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '0x6885afa...6f23b3', // Placeholder address
                style: fontTheme.textBaseMedium, // Bold address
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // View in Explorer Link
              InkWell(
                onTap: () {
                  // TODO: Implement View in Explorer functionality
                },
                child: Text(
                  'View in Explorer',
                  style: fontTheme.textBaseMedium?.copyWith(
                      color: colors.brandDefault), // Purple link color
                ),
              ),

              const Spacer(), // Pushes the button to the bottom

              // Done Button
              SizedBox(
                // Wrap in SizedBox to make the button full width
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement Done functionality (e.g., navigate back to finance home)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault, // Purple button color
                    foregroundColor: colors.textWhite, // White text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text('Done',
                      style: TextStyle(color: colors.bgB0)), // Text style
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart'; // Import DeFiRaiseAppBar
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address_book_screen.dart'; // Import for SavedAddress model
import 'package:defifundr_mobile/modules/finance/presentation/finance_home_screen.dart'; // Import for Asset model
import 'package:defifundr_mobile/modules/finance/presentation/select_asset_screen.dart'; // Import for SelectAssetScreen
import 'package:defifundr_mobile/modules/finance/presentation/select_network_screen.dart'; // Import for Network model
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  Asset? _selectedAsset;
  Network? _selectedNetwork;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();

  // Remove Dummy data for Assets and Networks as they are no longer used here
  // final List<Asset> _assets = [
  //   Asset(
  //     iconPath: 'assets/images/usdt.png', // Placeholder icon path
  //     name: 'Tether USD',
  //   ),
  //   Asset(
  //     iconPath: 'assets/images/usdc.png', // Placeholder icon path
  //     name: 'USD Coin',
  //   ),
  //   // Add more dummy assets as needed
  // ];

  // final List<Network> _networks = [
  //   Network(
  //     iconPath: 'assets/images/eth.png', // Placeholder icon path
  //     name: 'Ethereum',
  //   ),
  //   Network(
  //     iconPath: 'assets/images/starknet.png', // Placeholder icon path
  //     name: 'Starknet',
  //   ),
  //   // Add more dummy networks as needed
  // ];

  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers to trigger UI updates for button state
    _addressController.addListener(_updateSaveButtonState);
    _labelController.addListener(_updateSaveButtonState);
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _addressController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  // Method to check if the form is valid for saving
  bool _isFormValid() {
    return _selectedAsset != null &&
        _selectedNetwork != null &&
        _addressController.text.isNotEmpty &&
        _labelController.text.isNotEmpty;
  }

  // Method to update the state and rebuild the widget when inputs change
  void _updateSaveButtonState() {
    // Calling setState forces the widget to rebuild and check _isFormValid
    setState(() {});
  }

  // Method to save the address and return it to the previous screen
  void _saveAddress() {
    if (_isFormValid()) {
      final newAddress = SavedAddress(
        // Use the icon path from the selected asset
        iconPath: _selectedAsset!.iconPath,
        // Use the label as the name, or a default if label is empty (though validation prevents empty label now)
        name: _labelController.text,
        network: _selectedNetwork!.name,
        address: _addressController.text,
      );
      Navigator.pop(context, newAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? colors.bgB1 // Light mode color
          : Colors.black,
      // Use shared AppBar
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Asset Field
              SizedBox(height: 16),
              DeFiRaiseAppBar(
                title: 'Add address',
                isBack: true,
              ),
              SizedBox(height: 32),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final selectedAsset = await Navigator.push<Asset>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectAssetScreen()),
                  );
                  if (selectedAsset != null) {
                    setState(() {
                      _selectedAsset = selectedAsset;
                      _updateSaveButtonState(); // Update state when asset changes
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: colors.bgB1,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asset',
                              style: fontTheme.textSmRegular.copyWith(
                                  color: colors.textSecondary), // Label style
                            ),
                            const SizedBox(
                                height:
                                    4), // Spacing between label and selected asset name
                            Text(
                              _selectedAsset?.name ?? 'Select Asset',
                              style: fontTheme.textBaseMedium.copyWith(
                                  color: _selectedAsset == null
                                      ? colors
                                          .textSecondary // Placeholder color
                                      : colors.textPrimary), // Selected color
                            ),
                          ],
                        ),
                      ),
                      if (_selectedAsset != null)
                        Image.asset(
                          _selectedAsset!.iconPath,
                          width: 36, // Adjust size to match image
                          height: 36, // Adjust size to match image
                        ),
                      const SizedBox(
                          width: 12.0), // Spacing between icon and arrow
                      Icon(Icons.arrow_forward_ios,
                          color: colors.textSecondary,
                          size: 16.0), // Arrow icon
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Network Field

              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final selectedNetwork = await Navigator.push<Network>(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectNetworkScreen()),
                  );
                  if (selectedNetwork != null) {
                    setState(() {
                      _selectedNetwork = selectedNetwork;
                      _updateSaveButtonState(); // Update state when network changes
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: colors.bgB1,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Network',
                              style: fontTheme.textSmRegular.copyWith(
                                  color: colors.textSecondary), // Label style
                            ),
                            const SizedBox(
                                height:
                                    4), // Spacing between label and selected network name
                            Text(
                              _selectedNetwork?.name ?? 'Select Network',
                              style: fontTheme.textBaseMedium.copyWith(
                                  color: _selectedNetwork == null
                                      ? colors
                                          .textSecondary // Placeholder color
                                      : colors.textPrimary), // Selected color
                            ),
                          ],
                        ),
                      ),
                      if (_selectedNetwork != null)
                        Image.asset(
                          _selectedNetwork!.iconPath,
                          width: 36, // Adjust size
                          height: 36, // Adjust size
                        ),
                      const SizedBox(
                          width: 12.0), // Spacing between icon and arrow
                      Icon(Icons.arrow_forward_ios,
                          color: colors.textSecondary,
                          size: 16.0), // Arrow icon
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Address Input Field

              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address',
                      style: fontTheme.textSmRegular
                          .copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            labelText: 'Address',
                            controller: _addressController,
                            onChanged: (value) {
                              // Handle address change if needed
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Paste functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.bgB2,
                            foregroundColor: colors.textPrimary,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            textStyle: fontTheme.textSmMedium,
                          ),
                          child: const Text('Paste'),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.qr_code_scanner, color: colors.textPrimary),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Label Input Field

              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Label',
                      style: fontTheme.textSmRegular
                          .copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _labelController,
                      decoration: InputDecoration(
                        hintText: 'E.g. My ETH Wallet',
                        hintStyle: fontTheme.textBaseRegular
                            .copyWith(color: colors.textTertiary),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: fontTheme.textBaseRegular,
                    ),
                  ],
                ),
              ),
              const Spacer(), // Pushes the button to the bottom

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // Disable button if form is not valid
                  onPressed: _isFormValid() ? _saveAddress : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault,
                    foregroundColor: colors.textWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text('Save', style: TextStyle(color: colors.bgB0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

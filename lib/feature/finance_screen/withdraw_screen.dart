import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/finance_screen/finance_home_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/select_network_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/withdraw_details_model.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  Asset? _selectedAsset;
  Network? _selectedNetwork;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Get assets from FinanceHomeScreen
  final List<Asset> _assets = FinanceHomeScreen.dummyAssets;

  // Get networks from SelectNetworkScreen
  final List<Network> _networks = SelectNetworkScreen.dummyNetworks;

  @override
  void dispose() {
    _amountController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB1,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Withdraw',
          style: fontTheme.heading2Bold,
        ),
        backgroundColor: colors.bgB1,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Asset Selection Field
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
                  color: colors.bgB0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<Asset>(
                  value: _selectedAsset,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                    'Select Asset',
                    style: fontTheme.textBaseMedium,
                  ),
                  items: _assets.map((Asset asset) {
                    return DropdownMenuItem<Asset>(
                      value: asset,
                      child: Row(
                        children: [
                          Image.asset(
                            asset.iconPath,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            asset.name,
                            style: fontTheme.textBaseMedium,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Asset? newValue) {
                    setState(() {
                      _selectedAsset = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Network Selection Field
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
                  color: colors.bgB0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<Network>(
                  value: _selectedNetwork,
                  isExpanded: true,
                  underline: Container(),
                  hint: Text(
                    'Select Network',
                    style: fontTheme.textBaseMedium,
                  ),
                  items: _networks.map((Network network) {
                    return DropdownMenuItem<Network>(
                      value: network,
                      child: Row(
                        children: [
                          Image.asset(
                            network.iconPath,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            network.name,
                            style: fontTheme.textBaseMedium,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Network? newValue) {
                    setState(() {
                      _selectedNetwork = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Amount Input Field
              Text(
                'Amount',
                style: fontTheme.textSmRegular
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: colors.bgB0, // White background
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  // Use Column to stack input and available balance
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              hintText: '0',
                              hintStyle: fontTheme.heading1Bold?.copyWith(
                                  color:
                                      colors.textSecondary), // Large hint text
                              border: InputBorder.none,
                              isDense: true, // Reduce vertical space
                              contentPadding: EdgeInsets.all(12),
                            ),
                            style: fontTheme.heading1Bold, // Large input text
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Up/Down icon (if applicable)
                            Icon(Icons.unfold_more,
                                color: colors.textSecondary, size: 16),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                        height:
                            8), // Spacing between input and available balance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Available: 20 USDC', // Placeholder available balance
                          style: fontTheme.textSmRegular
                              ?.copyWith(color: colors.textSecondary),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Max button functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors
                                .brandFill, // Light brand color background
                            foregroundColor:
                                colors.brandDefault, // Brand color text
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0), // Smaller padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16.0), // Pill shape
                            ),
                            textStyle: fontTheme.textSmMedium, // Smaller text
                          ),
                          child: const Text('Max'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Send To Section
              Text(
                'Send to',
                style: fontTheme.textSmRegular
                    ?.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: colors.bgB0, // White background
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _addressController,
                            decoration: InputDecoration(
                              hintText: 'Paste or scan address',
                              hintStyle: fontTheme.textBaseRegular
                                  ?.copyWith(color: colors.textTertiary),
                              border: InputBorder.none,
                              isDense: true, // Reduce vertical space
                              contentPadding: EdgeInsets.all(12),
                            ),
                            style: fontTheme.textBaseRegular,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Paste button
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Paste functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                colors.bgB2, // Light grey background
                            foregroundColor:
                                colors.textPrimary, // Primary text color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0), // Smaller padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                            ),
                            textStyle: fontTheme.textSmMedium, // Smaller text
                          ),
                          child: const Text('Paste'),
                        ),
                        const SizedBox(width: 8),
                        // Scan icon
                        Icon(Icons.qr_code_scanner, color: colors.textPrimary),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Address book link
                    InkWell(
                      onTap: () {
                        // TODO: Navigate to Address Book screen
                        context.pushNamed(RouteConstants.addressBook);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline,
                                color: colors.brandDefault,
                                size: 20), // Address book icon
                            const SizedBox(width: 8),
                            Text('Address book',
                                style: fontTheme.textBaseMedium
                                    ?.copyWith(color: colors.brandDefault)),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: colors.textSecondary,
                                size: 16), // Arrow icon
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(), // Pushes the button to the bottom

              // Continue Button
              SizedBox(
                // Wrap in SizedBox to make the button full width
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedAsset != null &&
                        _selectedNetwork != null &&
                        _amountController.text.isNotEmpty &&
                        _addressController.text.isNotEmpty) {
                      final withdrawDetails = WithdrawDetails(
                        amount: _amountController.text,
                        assetName: _selectedAsset!.name,
                        assetIconPath: _selectedAsset!.iconPath,
                        networkName: _selectedNetwork!.name,
                        networkIconPath: _selectedNetwork!.iconPath,
                        recipientAddress: _addressController.text,
                        fee: '0.0005', // Placeholder fee
                        feeCurrency: 'ETH', // Placeholder fee currency
                      );
                      context.pushNamed(
                        RouteConstants.withdrawPreview,
                        extra: withdrawDetails,
                      );
                    } else {
                      // Optionally show a snackbar or dialog if fields are not filled
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all details'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault, // Purple button color
                    foregroundColor: colors.textWhite, // White text color
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text('Continue',
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

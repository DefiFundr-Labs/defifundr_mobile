import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/finance_screen/finance_home_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/select_network_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/withdraw_details_model.dart';
import 'package:defifundr_mobile/feature/finance_screen/select_asset_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/address_book_screen.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/textfield/app_text_field.dart';
import 'package:defifundr_mobile/feature/finance_screen/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/feature/finance_screen/bloc/withdraw_bloc/withdraw_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _memoController = TextEditingController();

  // Get assets from FinanceHomeScreen
  final List<Asset> _assets = FinanceHomeScreen.dummyAssets;

  // Get networks from SelectNetworkScreen
  final List<Network> _networks = SelectNetworkScreen.dummyNetworks;

  @override
  void initState() {
    super.initState();
    // Check if we received an address from the address book
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedAddress =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (selectedAddress != null) {
        setState(() {
          _addressController.text = selectedAddress;
        });
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _addressController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  // Method to handle address book selection
  Future<void> _selectFromAddressBook() async {
    final selectedAddress = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddressBookScreen()),
    );
    if (selectedAddress != null) {
      setState(() {
        _addressController.text = selectedAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      backgroundColor: colors.bgB0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Asset Selection Field
              SizedBox(height: 16),
              DeFiRaiseAppBar(
                title: 'Withdraw',
                isBack: true,
              ),
              SizedBox(height: 16),
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
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                              style: fontTheme.textSmRegular
                                  ?.copyWith(color: colors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _selectedAsset?.name ?? 'Select Asset',
                              style: fontTheme.textBaseMedium?.copyWith(
                                  color: _selectedAsset == null
                                      ? colors.textSecondary
                                      : colors.textPrimary),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedAsset != null)
                        Image.asset(
                          _selectedAsset!.iconPath,
                          width: 24,
                          height: 24,
                        ),
                      const SizedBox(width: 12.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Network Selection Field

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
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                              style: fontTheme.textSmRegular
                                  ?.copyWith(color: colors.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _selectedNetwork?.name ?? 'Select Network',
                              style: fontTheme.textBaseMedium?.copyWith(
                                  color: _selectedNetwork == null
                                      ? colors.textSecondary
                                      : colors.textPrimary),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedNetwork != null)
                        Image.asset(
                          _selectedNetwork!.iconPath,
                          width: 24,
                          height: 24,
                        ),
                      const SizedBox(width: 12.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Amount Input Field

              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                  color: colors.bgB1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Amount Label
                    Text(
                      'Amount',
                      style: fontTheme.textSmRegular?.copyWith(
                          color: colors.textSecondary), // Small grey text
                    ),
                    const SizedBox(height: 8), // Spacing below label
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              // Handle amount change if needed
                            },
                            style: fontTheme.heading2Bold?.copyWith(
                              color: colors
                                  .textSecondary, // Large grey text using a likely available style
                            ), // Large text for amount
                            decoration: InputDecoration(
                                hintText: '0', // Placeholder text
                                hintStyle: fontTheme.heading2Bold?.copyWith(
                                  color: colors
                                      .textSecondary, // Large grey hint text
                                ), // Use a similar large style for the hint
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(12)),
                          ),
                        ),
                        const SizedBox(
                            width: 32), // Spacing between text field and icon
                        // Switch Icon
                        // Wrapped in a Container similar to the image
                        Container(
                          padding:
                              EdgeInsets.all(8), // Adjust padding as needed
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? colors.bgB1 // Light mode color
                                  : colors
                                      .bgB0, // Background color for icon container
                              borderRadius:
                                  BorderRadius.circular(20) // Rounded shape
                              ),
                          child: Image.asset(
                            'assets/images/switch.png',
                            width: 16, // Adjust size as needed
                            height: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4), // Spacing below amount row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Available Balance
                        Text(
                          'Available: 20 USDC', // Use dummy data for now
                          style: fontTheme.textSmRegular?.copyWith(
                              color: colors.textSecondary), // Small grey text
                        ),
                        // Max Button
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Max button functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                colors.brandFill, // Light background
                            foregroundColor: colors.brandDefault, // Purple text
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            textStyle: fontTheme.textSmMedium, // Small text
                          ),
                          child: const Text('Max'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Send To Section
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
                    const SizedBox(height: 8),
                    // "Send to" label
                    Text(
                      'Send to',
                      style: fontTheme.textSmRegular?.copyWith(
                          color: colors.textSecondary), // Small grey text
                    ),
                    const SizedBox(height: 8), // Spacing below label
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _addressController,
                            onChanged: (value) {
                              // Handle address change if needed
                            },
                            decoration: InputDecoration(
                              hintText:
                                  'Paste or scan address', // Placeholder text
                              hintStyle: fontTheme.textBaseMedium?.copyWith(
                                color: colors.textSecondary, // Grey hint text
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                12), // Spacing between text field and paste button
                        ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Paste functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.bgB2, // Grey background
                            foregroundColor: colors.textPrimary, // Grey text
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0), // Adjust padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Rounded shape
                            ),
                            textStyle:
                                fontTheme.textSmMedium, // Small text style
                          ),
                          child: const Text('Paste'),
                        ),
                        const SizedBox(
                            width:
                                8), // Spacing between paste button and scan icon
                        Container(
                          padding: const EdgeInsets.all(
                              8), // Adjust padding to make it a small circle
                          decoration: BoxDecoration(
                              color: colors.bgB1, // Grey background
                              shape: BoxShape.circle // Circular shape
                              ),
                          child: Icon(Icons.qr_code_scanner,
                              color: colors.textPrimary, // Grey icon color
                              size: 20), // Adjust icon size
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Spacing before the divider
                    Divider(height: 1, color: colors.bgB1), // Separator line
                    const SizedBox(height: 16), // Spacing after the divider
                    InkWell(
                      onTap:
                          _selectFromAddressBook, // Use the address book selection method
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline,
                                color: colors.brandDefault, size: 20),
                            const SizedBox(width: 8),
                            Text('Address book',
                                style: fontTheme.textBaseMedium
                                    ?.copyWith(color: colors.brandDefault)),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: colors.textSecondary, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedAsset != null &&
                        _selectedNetwork != null &&
                        _amountController.text.isNotEmpty &&
                        _addressController.text.isNotEmpty) {
                      final withdrawDetails = WithdrawDetailsModel(
                        amount: double.parse(_amountController.text),
                        assetName: _selectedAsset!.name,
                        assetIconPath: _selectedAsset!.iconPath,
                        networkName: _selectedNetwork!.name,
                        networkIconPath: _selectedNetwork!.iconPath,
                        fee: 0.0001, // TODO: Get actual fee from API
                        feeCurrency: _selectedAsset!.name,
                        address: _addressController.text,
                        recipientAddress: _addressController.text,
                        memo: _memoController.text,
                      );

                      // Set withdraw details in bloc
                      context
                          .read<WithdrawBloc>()
                          .add(SetWithdrawDetails(withdrawDetails));

                      // Navigate to preview screen
                      context.goNamed(RouteConstants.withdrawPreview);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all details'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.brandDefault,
                    foregroundColor: colors.textWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child:
                      Text('Continue', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

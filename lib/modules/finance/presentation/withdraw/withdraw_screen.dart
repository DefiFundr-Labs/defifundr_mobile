import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address/address_book_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_asset_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_network_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_event.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/withdraw_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  NetworkAsset? _selectedAsset;
  Network? _selectedNetwork;

  final _amountController = TextEditingController();
  final _addressController = TextEditingController();
  final _memoController = TextEditingController();

  static const double _containerPadding = 16.0;
  static const double _verticalSpacing = 24.0;
  static const double _borderRadius = 8.0;
  static const double _buttonBorderRadius = 32.0;

  @override
  void initState() {
    super.initState();
    _checkForSelectedAddress();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _addressController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _checkForSelectedAddress() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedAddress =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (selectedAddress != null) {
        _addressController.text = selectedAddress;
      }
    });
  }

  Future<void> _selectFromAddressBook() async {
    final selectedAddress = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddressBookScreen()),
    );
    if (selectedAddress != null) {
      _addressController.text = selectedAddress;
    }
  }

  Future<void> _selectAsset() async {
    final selectedAsset = await Navigator.push<NetworkAsset>(
      context,
      MaterialPageRoute(builder: (context) => const SelectAssetScreen()),
    );
    if (selectedAsset != null) {
      setState(() => _selectedAsset = selectedAsset);
    }
  }

  Future<void> _selectNetwork() async {
    final selectedNetwork = await Navigator.push<Network>(
      context,
      MaterialPageRoute(builder: (context) => const SelectNetworkScreen()),
    );
    if (selectedNetwork != null) {
      setState(() => _selectedNetwork = selectedNetwork);
    }
  }

  void _onContinue() {
    if (_isFormValid()) {
      final withdrawDetails = WithdrawDetailsModel(
        amount: double.parse(_amountController.text),
        assetName: _selectedAsset!.name,
        assetIconPath: _selectedAsset!.iconPath,
        networkName: _selectedNetwork!.name,
        networkIconPath: _selectedNetwork!.iconPath,
        fee: 0.0001,
        feeCurrency: _selectedAsset!.name,
        address: _addressController.text,
        recipientAddress: _addressController.text,
        memo: _memoController.text,
      );

      context.read<WithdrawBloc>().add(SetWithdrawDetails(withdrawDetails));
      context.goNamed(RouteConstants.withdrawPreview);
    } else {
      _showErrorSnackBar();
    }
  }

  bool _isFormValid() {
    return _selectedAsset != null &&
        _selectedNetwork != null &&
        _amountController.text.isNotEmpty &&
        _addressController.text.isNotEmpty;
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill in all details')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: const DeFiRaiseAppBar(
          isBack: true,
          title: 'Withdraw',
          actions: [],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(_containerPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildAssetSelector(colors, fontTheme),
              const SizedBox(height: _verticalSpacing),
              _buildNetworkSelector(colors, fontTheme),
              const SizedBox(height: _verticalSpacing),
              _buildAmountInput(colors, fontTheme),
              const SizedBox(height: _verticalSpacing),
              _buildAddressInput(colors, fontTheme),
              const Spacer(),
              _buildContinueButton(colors, fontTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssetSelector(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return AppTextField(
      labelText: 'Select Asset',
      hintText: 'Select Asset',
      suffixType: _selectedAsset?.iconPath != null
          ? SuffixType.customIcon
          : SuffixType.none,
      suffixIcon: _selectedAsset?.iconPath != null
          ? Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                _selectedAsset!.iconPath,
                width: 24,
                height: 24,
              ),
            )
          : null,
      controller: _amountController,
      onTap: _selectAsset,
      readOnly: true,
    );
  }

  Widget _buildNetworkSelector(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return _buildSelector(
      label: 'Network',
      value: _selectedNetwork?.name ?? 'Select Network',
      icon: _selectedNetwork?.iconPath,
      onTap: _selectNetwork,
      colors: colors,
      fontTheme: fontTheme,
    );
  }

  Widget _buildSelector({
    required String label,
    required String value,
    required String? icon,
    required VoidCallback onTap,
    required AppColorExtension colors,
    required AppFontThemeExtension fontTheme,
  }) {
    final hasSelection = icon != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _containerPadding,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          color: colors.bgB0,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: fontTheme.textSmRegular
                        .copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: fontTheme.textBaseMedium.copyWith(
                      color: hasSelection
                          ? colors.textPrimary
                          : colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (hasSelection) ...[
              Image.asset(icon, width: 24, height: 24),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.keyboard_arrow_down,
              color: colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return Container(
      padding: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        color: colors.bgB1,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style:
                fontTheme.textSmRegular.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: fontTheme.heading2Bold
                      .copyWith(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: fontTheme.heading2Bold
                        .copyWith(color: colors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.bgB0,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/images/switch.png',
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available: 20 USDC',
                style: fontTheme.textSmRegular
                    .copyWith(color: colors.textSecondary),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.brandFill,
                  foregroundColor: colors.brandDefault,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Text('Max', style: fontTheme.textSmMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInput(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return Container(
      padding: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        color: colors.bgB1,
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send to',
            style:
                fontTheme.textSmRegular.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Paste or scan address',
                    hintStyle: fontTheme.textBaseMedium
                        .copyWith(color: colors.textSecondary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                text: 'Paste',
                onPressed: () {},
                colors: colors,
                fontTheme: fontTheme,
              ),
              const SizedBox(width: 8),
              _buildIconButton(
                icon: Icons.qr_code_scanner,
                onPressed: () {},
                colors: colors,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(height: 1, color: colors.bgB2),
          const SizedBox(height: 8),
          InkWell(
            onTap: _selectFromAddressBook,
            borderRadius: BorderRadius.circular(_borderRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Icon(Icons.person_outline,
                      color: colors.brandDefault, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Address book',
                    style: fontTheme.textBaseMedium
                        .copyWith(color: colors.brandDefault),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios,
                      color: colors.textSecondary, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required AppColorExtension colors,
    required AppFontThemeExtension fontTheme,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.bgB2,
        foregroundColor: colors.textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(text, style: fontTheme.textSmMedium),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required AppColorExtension colors,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors.bgB2,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: colors.textPrimary, size: 20),
      ),
    );
  }

  Widget _buildContinueButton(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.brandDefault,
          foregroundColor: colors.textWhite,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_buttonBorderRadius),
          ),
        ),
        child: Text(
          'Continue',
          style: fontTheme.textBaseMedium.copyWith(color: colors.textWhite),
        ),
      ),
    );
  }
}

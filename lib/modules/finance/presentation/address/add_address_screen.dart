import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address/address_book_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_asset_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_network_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  NetworkAsset? _selectedAsset;
  Network? _selectedNetwork;

  final _addressController = TextEditingController();
  final _labelController = TextEditingController();
  final _assetController = TextEditingController();
  final _networkController = TextEditingController();

  static const double _containerPadding = 16.0;
  static const double _verticalSpacing = 24.0;
  static const double _borderRadius = 12.0;

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_updateSaveButtonState);
    _labelController.addListener(_updateSaveButtonState);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _labelController.dispose();
    _assetController.dispose();
    _networkController.dispose();
    super.dispose();
  }

  void _updateSaveButtonState() {
    setState(() {});
  }

  Future<void> _selectAsset() async {
    final selectedAsset = await Navigator.push<NetworkAsset>(
      context,
      MaterialPageRoute(builder: (context) => const SelectAssetScreen()),
    );
    if (selectedAsset != null) {
      _assetController.text = selectedAsset.name;
      setState(() => _selectedAsset = selectedAsset);
    }
  }

  Future<void> _selectNetwork() async {
    final selectedNetwork = await Navigator.push<Network>(
      context,
      MaterialPageRoute(builder: (context) => const SelectNetworkScreen()),
    );
    if (selectedNetwork != null) {
      _networkController.text = selectedNetwork.name;
      setState(() => _selectedNetwork = selectedNetwork);
    }
  }

  Future<void> _pasteFromClipboard() async {
    try {
      final ClipboardData? data = await Clipboard.getData('text/plain');
      if (data != null && data.text != null) {
        _addressController.text = data.text!;
        setState(() {});
      }
    } catch (e) {
      _showErrorSnackBar('Failed to paste from clipboard');
    }
  }

  void _saveAddress() {
    if (_isFormValid()) {
      final newAddress = SavedAddress(
        iconPath: _selectedAsset!.iconPath,
        name: _labelController.text,
        network: _selectedNetwork!.name,
        address: _addressController.text,
      );
      Navigator.pop(context, newAddress);
    } else {
      _showErrorSnackBar();
    }
  }

  bool _isFormValid() {
    return _selectedAsset != null &&
        _selectedNetwork != null &&
        _addressController.text.isNotEmpty &&
        _labelController.text.isNotEmpty;
  }

  void _showErrorSnackBar([String? message]) {
    String errorMessage = message ?? 'Please fill in all details';

    if (_selectedAsset == null) {
      errorMessage = 'Please select an asset';
    } else if (_selectedNetwork == null) {
      errorMessage = 'Please select a network';
    } else if (_addressController.text.isEmpty) {
      errorMessage = 'Please enter an address';
    } else if (_labelController.text.isEmpty) {
      errorMessage = 'Please enter a label';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
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
          title: 'Add address',
          actions: [],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(_containerPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildAssetSelector(),
                    const SizedBox(height: _verticalSpacing),
                    _buildNetworkSelector(),
                    const SizedBox(height: _verticalSpacing),
                    _buildAddressInput(colors, fontTheme),
                    const SizedBox(height: _verticalSpacing),
                    _buildLabelInput(colors, fontTheme),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            // Fixed bottom button
            Container(
              padding: const EdgeInsets.fromLTRB(
                  _containerPadding, 8, _containerPadding, _containerPadding),
              child: _buildSaveButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetSelector() {
    return AppTextField(
      labelText: 'Asset',
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
      controller: _assetController,
      hintText: 'Select Asset',
      onTap: _selectAsset,
      readOnly: true,
    );
  }

  Widget _buildNetworkSelector() {
    return AppTextField(
      labelText: 'Network',
      suffixType: _selectedNetwork?.iconPath != null
          ? SuffixType.customIcon
          : SuffixType.none,
      suffixIcon: _selectedNetwork?.iconPath != null
          ? Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.asset(
                _selectedNetwork!.iconPath,
                width: 24,
                height: 24,
              ),
            )
          : null,
      controller: _networkController,
      hintText: 'Select Network',
      onTap: _selectNetwork,
      readOnly: true,
    );
  }

  Widget _buildAddressInput(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return Container(
      padding: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        color: colors.bgB0,
        border: Border.all(
          color: colors.strokeSecondary.withAlpha(30),
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address',
            style: fontTheme.textSmRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _addressController,
                  style: fontTheme.textMdSemiBold,
                  maxLines: null,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Paste or scan address',
                    hintStyle: fontTheme.textBaseMedium.copyWith(
                      color: colors.textTertiary,
                    ),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (_addressController.text.isEmpty)
                PrimaryButton(
                  onPressed: _pasteFromClipboard,
                  text: 'Paste',
                  color: colors.fillTertiary,
                  fixedSize: Size(55.w, 24.h),
                  enableShine: false,
                  borderColor: Colors.transparent,
                  textSize: 10.sp,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.sp,
                    vertical: 2.sp,
                  ),
                  textColor: colors.textPrimary,
                  borderRadius: BorderRadius.circular(120),
                )
              else
                _buildIconButton(
                  icon: Icons.close,
                  onPressed: () {
                    _addressController.clear();
                    setState(() {});
                  },
                  colors: colors,
                ),
              const SizedBox(width: 8),
              _buildIconButton(
                icon: Icons.qr_code_scanner,
                onPressed: () {
                  // TODO: Implement QR scanner
                },
                colors: colors,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabelInput(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return AppTextField(
      labelText: 'Wallet label',
      controller: _labelController,
      hintText: 'Enter Wallet label',
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
        child: Icon(icon, color: colors.textPrimary, size: 15),
      ),
    );
  }

  Widget _buildSaveButton() {
    return PrimaryButton(
      text: 'Save',
      onPressed: _isFormValid() ? _saveAddress : null,
    );
  }
}

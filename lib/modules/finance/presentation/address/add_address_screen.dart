import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address/address_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';

@RoutePage()
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
    final selectedAsset = await context.router.push<NetworkAsset>(
      SelectAssetRoute(),
    );
    if (selectedAsset != null) {
      _assetController.text = selectedAsset.name;
      setState(() => _selectedAsset = selectedAsset);
    }
  }

  Future<void> _selectNetwork() async {
    final selectedNetwork = await context.router.push<Network>(
      SelectNetworkRoute(),
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
      context.router.maybePop(newAddress);
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

    AppSnackbar.show(context, errorMessage);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorExtension>()!;
    final fontTheme = Theme.of(context).extension<AppFontThemeExtension>()!;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          isBack: true,
          title: context.l10n.addAddress,
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
      labelText: context.l10n.asset,
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
      hintText: context.l10n.selectAsset,
      onTap: _selectAsset,
      readOnly: true,
    );
  }

  Widget _buildNetworkSelector() {
    return AppTextField(
      labelText: context.l10n.network,
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
      hintText: context.l10n.selectNetwork,
      onTap: _selectNetwork,
      readOnly: true,
    );
  }

  Widget _buildAddressInput(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.all(_containerPadding),
      decoration: BoxDecoration(
        color: isLightMode ? colors.bgB0 : colors.bgB1,
        border: Border.all(
          color: colors.strokeSecondary.withAlpha(30),
        ),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.address,
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
                    hintText: context.l10n.pasteOrScanAddress,
                    fillColor: isLightMode ? colors.bgB0 : colors.bgB1,
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
                  text: context.l10n.paste,
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
      labelText: context.l10n.walletLabel,
      controller: _labelController,
      hintText: context.l10n.enterWalletLabel,
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
      text: context.l10n.save,
      onPressed: _isFormValid() ? _saveAddress : null,
    );
  }
}

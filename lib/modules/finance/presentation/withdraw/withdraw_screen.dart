import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/font_extension/font_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/data/model/withdraw_details_model.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_bloc.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/bloc/withdraw_bloc/withdraw_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
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
  final _assetController = TextEditingController();
  final _networkController = TextEditingController();

  static const double _containerPadding = 16.0;
  static const double _verticalSpacing = 24.0;
  static const double _borderRadius = 12.0;
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
    _assetController.dispose();
    _networkController.dispose();

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
    final selectedAddress = await context.router.push<String>(AddressBookRoute());
    if (selectedAddress != null) {
      _addressController.text = selectedAddress;
    }
  }

  Future<void> _selectAsset() async {
    final selectedAsset = await context.router.push<NetworkAsset>(SelectAssetRoute());
    if (selectedAsset != null) {
      _assetController.text = selectedAsset.name;
      setState(() => _selectedAsset = selectedAsset);
    }
  }

  Future<void> _selectNetwork() async {
    final selectedNetwork = await context.router.push<Network>(SelectNetworkRoute());
    if (selectedNetwork != null) {
      _networkController.text = selectedNetwork.name;
      setState(() => _selectedNetwork = selectedNetwork);
    }
  }

  void _onContinue() {
    if (_isFormValid()) {
      String cleanAmount = _amountController.text.replaceAll(',', '');

      final withdrawDetails = WithdrawDetailsModel(
        amount: double.parse(cleanAmount),
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
      context.router.push(WithdrawPreviewRoute());
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
                    _buildNetworkSelector(colors, fontTheme),
                    const SizedBox(height: _verticalSpacing),
                    _buildAmountInput(context),
                    const SizedBox(height: _verticalSpacing),
                    _buildAddressInput(colors, fontTheme),
                    // Add some bottom padding to ensure content doesn't stick to button
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(
                  _containerPadding, 8, _containerPadding, _containerPadding),
              child: _buildContinueButton(colors, fontTheme),
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

  Widget _buildNetworkSelector(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
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

  Widget _buildAmountInput(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
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
            'Amount',
            style: fonts.textSmMedium.copyWith(
              color: colors.textTertiary,
              fontSize: 12.sp,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: fonts.heading2Bold.copyWith(
                    color: colors.textPrimary,
                  ),
                  onChanged: (value) {
                    String cleanValue = value
                        .replaceAll(',', '')
                        .replaceAll(RegExp(r'[^0-9.]'), '');

                    List<String> parts = cleanValue.split('.');
                    if (parts.length > 2) {
                      cleanValue = '${parts[0]}.${parts.sublist(1).join('')}';
                      parts = cleanValue.split('.');
                    }

                    if (parts.length == 2 && parts[1].length > 7) {
                      parts[1] = parts[1].substring(0, 7);
                    }

                    String integerPart = parts[0];
                    if (integerPart.isNotEmpty) {
                      integerPart = integerPart.replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},',
                      );
                    }

                    String formattedValue = integerPart;
                    if (parts.length == 2) {
                      formattedValue += '.${parts[1]}';
                    } else if (cleanValue.endsWith('.')) {
                      formattedValue += '.';
                    }

                    if (formattedValue != value) {
                      int cursorPosition = formattedValue.length;
                      _amountController.value = TextEditingValue(
                        text: formattedValue,
                        selection:
                            TextSelection.collapsed(offset: cursorPosition),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    hintText: '0.00',
                    fillColor: isLightMode ? colors.bgB0 : colors.bgB1,
                    hintStyle: fonts.heading2Bold.copyWith(
                      color: colors.textQuaternary,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.bgB2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  Assets.images.switchPng.path,
                  width: 16,
                  height: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available: 20 USDC',
                style: fonts.textSmRegular.copyWith(
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
              PrimaryButton(
                onPressed: () {},
                text: 'Max',
                color: colors.bgB2,
                fixedSize: Size(50.w, 24.h),
                enableShine: false,
                borderColor: Colors.transparent,
                textSize: 10.sp,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 2.sp,
                ),
                textColor: colors.brandActive,
                borderRadius: BorderRadius.circular(120),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressInput(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(16.0),
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
            'Send to',
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
                    setState(() {}); // Trigger rebuild to update button
                  },
                  decoration: InputDecoration(
                    hintText: 'Paste or scan address',
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
                  onPressed: () {
                    // Implement paste functionality here
                  },
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
                onPressed: () {},
                colors: colors,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Divider(height: 0.5, color: colors.bgB2),
          SizedBox(height: 8.h),
          InkWell(
            onTap: _selectFromAddressBook,
            splashColor: Colors.transparent,
            borderRadius: BorderRadius.circular(_borderRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.userCircleSvg_,
                    height: 16.sp,
                    width: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Address book',
                    style: fontTheme.textSmSemiBold.copyWith(
                      color: colors.brandDefault,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: colors.brandDefault,
                    size: 12.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

  Widget _buildContinueButton(
      AppColorExtension colors, AppFontThemeExtension fontTheme) {
    return PrimaryButton(
      text: 'Continue',
      onPressed: _onContinue,
    );
  }
}

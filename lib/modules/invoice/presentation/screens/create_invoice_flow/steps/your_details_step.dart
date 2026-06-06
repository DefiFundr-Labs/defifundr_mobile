import 'package:country_picker/country_picker.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class YourDetailsStep extends StatelessWidget {
  final bool isRegisteredBusiness;
  final ValueChanged<bool> onBusinessToggled;
  final TextEditingController countryController;
  final TextEditingController firstNameController;
  final TextEditingController businessNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController taxIdController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;
  final String dialCode;
  final String flagEmoji;
  final Function(String, String) onDialCodeChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const YourDetailsStep({
    Key? key,
    required this.isRegisteredBusiness,
    required this.onBusinessToggled,
    required this.countryController,
    required this.firstNameController,
    required this.businessNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.taxIdController,
    required this.streetController,
    required this.cityController,
    required this.postalCodeController,
    required this.onNext,
    required this.onBack,
    required this.dialCode,
    required this.flagEmoji,
    required this.onDialCodeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBusinessToggle(context),
                    SizedBox(height: 20.h),
                    _buildFormFields(context),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.fillTertiary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text('I am registered as a business',
                style: context.theme.fonts.textMdRegular),
          ),
          Switch(
            value: isRegisteredBusiness,
            onChanged: onBusinessToggled,
            activeThumbColor: context.theme.colors.bgB0,
            trackOutlineColor: WidgetStateProperty.all(
              context.theme.colors.strokeSecondary.withAlpha(20),
            ),
            inactiveThumbColor: context.theme.colors.textSecondary,
            activeTrackColor: context.theme.colors.brandDefault,
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        if (isRegisteredBusiness) ...[
          AppTextField(
            controller: businessNameController,
            hintText: 'Business name',
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 20.h),
        ] else ...[
          AppTextField(
            controller: firstNameController,
            hintText: 'First name',
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 20.h),
          AppTextField(
            controller: lastNameController,
            hintText: 'Last name',
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: 20.h),
        ],
        AppTextField(
          controller: emailController,
          hintText: 'Email address',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: phoneController,
          hintText: 'Phone number',
          keyboardType: TextInputType.phone,
          prefixType: PrefixType.customWidget,
          prefixWidget: GestureDetector(
            onTap: () => _showDialCodePicker(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(flagEmoji, style: TextStyle(fontSize: 18.sp)),
                  const SizedBox(width: 4),
                  Text(
                    dialCode,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Iconsax.arrow_down_1,
                      size: 14, color: AppColors.grayTertiary),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: taxIdController,
          hintText: 'Tax ID',
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: countryController,
          labelText: 'Country',
          hintText: 'Country',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: () => _showCountryPicker(context),
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: streetController,
          hintText: 'Street',
          keyboardType: TextInputType.streetAddress,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: cityController,
          hintText: 'City',
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: postalCodeController,
          hintText: 'Postal / zip code',
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        countryController.text = country.name;
      },
      countryListTheme: _countryListTheme(context),
    );
  }

  void _showDialCodePicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        onDialCodeChanged('+' + country.phoneCode, country.flagEmoji);
      },
      countryListTheme: _countryListTheme(context),
    );
  }

  CountryListThemeData _countryListTheme(BuildContext context) {
    return CountryListThemeData(
      backgroundColor: context.theme.colors.bgB1,
      textStyle: context.theme.fonts.textBaseRegular.copyWith(
        color: context.theme.colors.textPrimary,
      ),
      searchTextStyle: context.theme.fonts.textBaseRegular.copyWith(
        color: context.theme.colors.textPrimary,
      ),
      inputDecoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        fillColor: context.theme.colors.bgB0,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

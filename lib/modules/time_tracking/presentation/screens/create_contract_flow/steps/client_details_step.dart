import 'package:country_picker/country_picker.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_pill_bar.dart';

class ClientDetailsStep extends StatefulWidget {
  final bool isNewClient;
  final bool isBusiness;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController businessNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController countryController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController zipController;
  final String dialCode;
  final String flagEmoji;
  final String? selectedClientId;
  final ValueChanged<bool> onNewClientChanged;
  final ValueChanged<bool> onBusinessChanged;
  final Function(String code, String flag) onDialCodeChanged;
  final ValueChanged<String?> onClientSelected;
  final VoidCallback onNext;

  const ClientDetailsStep({
    Key? key,
    required this.isNewClient,
    required this.isBusiness,
    required this.firstNameController,
    required this.lastNameController,
    required this.businessNameController,
    required this.emailController,
    required this.phoneController,
    required this.countryController,
    required this.streetController,
    required this.cityController,
    required this.zipController,
    required this.dialCode,
    required this.flagEmoji,
    required this.selectedClientId,
    required this.onNewClientChanged,
    required this.onBusinessChanged,
    required this.onDialCodeChanged,
    required this.onClientSelected,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ClientDetailsStep> createState() => _ClientDetailsStepState();
}

class _ClientDetailsStepState extends State<ClientDetailsStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectionPillBar(
                  options: const ['New client', 'Saved client'],
                  selectedOption:
                      widget.isNewClient ? 'New client' : 'Saved client',
                  onChanged: (val) =>
                      widget.onNewClientChanged(val == 'New client'),
                ),
                SizedBox(height: 20.h),
                if (widget.isNewClient)
                  _NewClientForm(
                    isBusiness: widget.isBusiness,
                    firstNameController: widget.firstNameController,
                    lastNameController: widget.lastNameController,
                    businessNameController: widget.businessNameController,
                    emailController: widget.emailController,
                    phoneController: widget.phoneController,
                    countryController: widget.countryController,
                    streetController: widget.streetController,
                    cityController: widget.cityController,
                    zipController: widget.zipController,
                    dialCode: widget.dialCode,
                    flagEmoji: widget.flagEmoji,
                    onBusinessChanged: widget.onBusinessChanged,
                    onSelectDialCode: () => _showDialCodePicker(context),
                    onSelectCountry: () => _showCountryPicker(context),
                  )
                else
                  _SavedClientForm(
                    selectedClientId: widget.selectedClientId,
                    onSelectClient: () => _showSavedClientsPicker(context),
                  ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
          child: PrimaryButton(
            text: 'Continue',
            onPressed: widget.onNext,
          ),
        ),
      ],
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        widget.countryController.text = country.name;
      },
      countryListTheme: _countryListTheme(context),
    );
  }

  void _showSavedClientsPicker(BuildContext context) {
    // Placeholder for saved clients picker
  }

  void _showDialCodePicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        widget.onDialCodeChanged('+' + country.phoneCode, country.flagEmoji);
      },
      countryListTheme: _countryListTheme(context),
    );
  }

  CountryListThemeData _countryListTheme(BuildContext context) {
    return CountryListThemeData(
      backgroundColor: context.theme.colors.bgB0,
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

class _NewClientForm extends StatelessWidget {
  final bool isBusiness;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController businessNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController countryController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController zipController;
  final String dialCode;
  final String flagEmoji;
  final ValueChanged<bool> onBusinessChanged;
  final VoidCallback onSelectDialCode;
  final VoidCallback onSelectCountry;

  const _NewClientForm({
    required this.isBusiness,
    required this.firstNameController,
    required this.lastNameController,
    required this.businessNameController,
    required this.emailController,
    required this.phoneController,
    required this.countryController,
    required this.streetController,
    required this.cityController,
    required this.zipController,
    required this.dialCode,
    required this.flagEmoji,
    required this.onBusinessChanged,
    required this.onSelectDialCode,
    required this.onSelectCountry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Client is registered as a business',
                    style: context.theme.fonts.textMdRegular),
              ),
              Switch(
                value: isBusiness,
                onChanged: onBusinessChanged,
                activeThumbColor: Colors.white,
                activeTrackColor: context.theme.colors.brandDefault,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        if (isBusiness)
          AppTextField(
            controller: businessNameController,
            hintText: 'Business name',
            keyboardType: TextInputType.text,
          )
        else ...[
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
        ],
        SizedBox(height: 20.h),
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
            onTap: onSelectDialCode,
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
          controller: countryController,
          labelText: 'Country',
          hintText: 'Country',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: onSelectCountry,
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
          controller: zipController,
          hintText: 'Postal / zip code',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class _SavedClientForm extends StatelessWidget {
  final String? selectedClientId;
  final VoidCallback onSelectClient;

  const _SavedClientForm({
    required this.selectedClientId,
    required this.onSelectClient,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: TextEditingController(text: selectedClientId ?? ''),
      labelText: 'Select client',
      hintText: 'Select client',
      suffixType: SuffixType.defaultt,
      readOnly: true,
      onTap: onSelectClient,
    );
  }
}

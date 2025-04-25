import 'package:country_picker/country_picker.dart';
import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/shared/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/auth_header.dart';
import 'package:defifundr_mobile/core/shared/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/shared/textfield/app_text_field.dart';

class ContractDetailSelectCountryScreen extends StatefulWidget {
  const ContractDetailSelectCountryScreen({super.key});

  @override
  State<ContractDetailSelectCountryScreen> createState() =>
      _ContractDetailSelectCountryScreenState();
}

class _ContractDetailSelectCountryScreenState
    extends State<ContractDetailSelectCountryScreen> {
  Country? _selectedNationality;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.screenWidth(), 60),
          child: DeFiRaiseAppBar(
            isBack: true,
            title: '',
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset(
                  AppIcons.twentyFivePercent,
                  fit: BoxFit.scaleDown,
                ),
              )
            ],
          )),
      backgroundColor: AppColors.activeButtonDark,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AuthHeader(
                    title: AppTexts.createContractDetails,
                    subtitle: AppTexts.kindlyCreateContract,
                  ),
                  VerticalMargin(30),
                  AppTextField(
                    isPassword: false,
                    label: AppTexts.contractName,
                    controller: TextEditingController(),
                    prefixIcon: SvgPicture.asset(
                      AppIcons.userEdit,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  VerticalMargin(10),
                  _buildDropdown(
                    label: AppTexts.contractorsTaxResidence,
                    selectedCountry: _selectedNationality,
                    onSelect: (country) {
                      setState(() {
                        _selectedNationality = country;
                      });
                    },
                  ),
                ],
              ),
              AppButton(
                  text: 'Continue',
                  color: AppColors.primaryColor,
                  textColor: AppColors.white100,
                  onTap: () {})
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildDropdown({
    required String label,
    required Country? selectedCountry,
    required Function(Country) onSelect,
  }) {
    return GestureDetector(
      onTap: () => _showCountryPicker(onSelect: onSelect),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                selectedCountry != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://flagcdn.com/w40/${selectedCountry.countryCode.toLowerCase()}.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SvgPicture.asset('assets/icons/us-flag.svg',
                            width: 24, height: 24),
                      ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_drop_down, color: AppColors.grey500),
              ],
            ),
            Expanded(
              child: Text(
                selectedCountry?.name ?? label,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: selectedCountry != null
                      ? Colors.black
                      : AppColors.grey300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker({required Function(Country) onSelect}) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: onSelect,
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.circular(16),
        backgroundColor: AppColors.white100,
        textStyle: const TextStyle(color: Colors.black),
        searchTextStyle: const TextStyle(color: Colors.black),
        inputDecoration: const InputDecoration(
          labelText: AppTexts.searchCountry,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

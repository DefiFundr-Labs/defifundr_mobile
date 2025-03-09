import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:defifundr_mobile/core/global/constants/app_texts.dart';
import 'package:defifundr_mobile/core/global/constants/color_scheme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectNationalityScreen extends StatefulWidget {
  const SelectNationalityScreen({super.key});

  @override
  _SelectNationalityScreen createState() => _SelectNationalityScreen();
}

class _SelectNationalityScreen extends State<SelectNationalityScreen> {
  Country? _selectedNationality;
  Country? _selectedCountryOfResidency;
  bool _isLivingInCountryOfNationality = false;

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
          labelText: "Search country",
          border: OutlineInputBorder(),
        ),
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Flag and Dropdown Arrow
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
                        child: SvgPicture.asset('assets/icons/us-flag.svg', width: 24, height: 24),
                      ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_drop_down, color: AppColors.grey500),
              ],
            ),

            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  selectedCountry?.name ?? label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: selectedCountry != null ? Colors.black : AppColors.grey300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(''), backgroundColor: const Color(0xFFFAFAFA)),
      body: Container(
        color: const Color(0xFFFAFAFA),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppTexts.selectNationalityHeader, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            const SizedBox(height: 8),
            const Text(AppTexts.selectNationalitySubHeader, style: TextStyle(fontSize: 12, color: AppColors.secondaryTextColor)),
            const SizedBox(height: 24),

            /// Nationality Dropdown
            _buildDropdown(
              label: AppTexts.selectNationalityLabel,
              selectedCountry: _selectedNationality,
              onSelect: (country) {
                setState(() {
                  _selectedNationality = country;
                });
              },
            ),
            const SizedBox(height: 16),

            CheckboxListTile(
              title: const Text(AppTexts.liveInCountryOfNationality, style: TextStyle(fontSize: 12, color: AppColors.secondaryTextColor)),
              value: _isLivingInCountryOfNationality,
              onChanged: (bool? value) {
                setState(() {
                  _isLivingInCountryOfNationality = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: const VisualDensity(horizontal: -4),
            ),

            if (!_isLivingInCountryOfNationality) ...[
              const SizedBox(height: 16),
              _buildDropdown(
                label: AppTexts.selectCountryOfResidencyLabel,
                selectedCountry: _selectedCountryOfResidency,
                onSelect: (country) {
                  setState(() {
                    _selectedCountryOfResidency = country;
                  });
                },
              ),
            ],
            const Spacer(),

            const Text(AppTexts.collectCountryInfo, style: TextStyle(fontSize: 12, color: AppColors.secondaryTextColor)),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue button press
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text(AppTexts.continueButton, style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
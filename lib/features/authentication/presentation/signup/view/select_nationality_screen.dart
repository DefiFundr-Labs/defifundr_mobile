import 'package:defifundr_mobile/core/global/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/global/constants/app_texts.dart';
import 'package:flutter_svg/svg.dart';

class SelectNationalityScreen extends StatefulWidget {
  const SelectNationalityScreen({super.key});

  @override
  _SelectNationalityScreen createState() => _SelectNationalityScreen();
}

class _SelectNationalityScreen extends State<SelectNationalityScreen> {
  String? _selectedNationality;
  String? _selectedCountryOfResidency;
  bool _isLivingInCountryOfNationality = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: Container(
        color: Color(0xFFFAFAFA),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppTexts.selectNationalityHeader,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const SizedBox(height: 8),
            const Text(
              AppTexts.selectNationalitySubHeader,
              style: TextStyle(fontSize: 12, color: AppColors.secondaryTextColor),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: AppTexts.selectNationalityLabel,
                labelStyle: const TextStyle(fontSize: 14, color: AppColors.grey300),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.white100,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/us-flag.svg',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_drop_down, color: AppColors.grey500),
                    ],
                  ),
                ),
              ),
              icon: const SizedBox.shrink(),
              dropdownColor: AppColors.white100,
              items: <String>['USA', 'Canada', 'UK', 'Australia']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: AppColors.grey500),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCountryOfResidency = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text(
                AppTexts.liveInCountryOfNationality,
                style: TextStyle(fontSize: 12, color: AppColors.secondaryTextColor),
              ),
              value: _isLivingInCountryOfNationality,
              onChanged: (bool? value) {
                setState(() {
                  _isLivingInCountryOfNationality = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity(horizontal: -4),
            ),
            if (!_isLivingInCountryOfNationality) ...[
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: AppTexts.selectCountryOfResidencyLabel,
                  labelStyle: const TextStyle(fontSize: 14, color: AppColors.grey300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.white100,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/us-flag.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_drop_down, color: AppColors.grey500),
                      ],
                    ),
                  ),
                ),
                icon: const SizedBox.shrink(),
                dropdownColor: AppColors.white100,
                items: <String>['USA', 'Canada', 'UK', 'Australia']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: AppColors.grey500),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountryOfResidency = newValue;
                  });
                },
              ),
            ],
            const Spacer(),
            const Text(
              AppTexts.collectCountryInfo,
              style: TextStyle(fontSize: 12, color: AppColors.secondaryTextColor),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle continue button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  AppTexts.continueButton,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

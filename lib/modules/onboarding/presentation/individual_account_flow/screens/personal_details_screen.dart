// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  String? selectedCountry;
  final TextEditingController _countryOfCitizenshipController =
      TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  String? selectedCountryCode = '+234';

  @override
  void dispose() {
    _countryOfCitizenshipController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: const DeFiRaiseAppBar(
          isBack: true,
          title: '',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 4,
              width: double.infinity,
              color: Colors.grey[200],
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColorDark.activeButtonDark,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Personal Details',
                      style: context.theme.fonts.headerLarger.copyWith(
                        fontSize: 24.sp,
                        color: context.theme.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Please provide your personal details, this will be used to complete your profile.',
                      style: context.theme.fonts.headerSmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      labelText: 'Country of citizenship',
                      controller: _countryOfCitizenshipController,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Gender',
                      controller: _countryOfCitizenshipController,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Date of birth',
                      controller: _dobController,
                      readOnly: true,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now()
                              .subtract(const Duration(days: 365 * 18)),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: Colors.purple,
                                  onPrimary: Colors.white,
                                  surface: Color(0xFF1E1E1E),
                                  onSurface: Colors.white,
                                ),
                                dialogBackgroundColor: const Color(0xFF121212),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            _dobController.text =
                                "${picked.day}/${picked.month}/${picked.year}";
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Phone number',
                      controller: _phoneController,
                    ),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Continue',
              onPressed: () {
                context.router.push(AddressDetailsRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}

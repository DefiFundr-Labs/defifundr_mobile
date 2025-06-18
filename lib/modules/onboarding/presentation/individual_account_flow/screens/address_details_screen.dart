// ignore_for_file: deprecated_member_use

import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  String? selectedCountryCode = '+234';

  @override
  void dispose() {
    _addressController.dispose();
    _postalCodeController.dispose();
    _cityController.dispose();
    _countryController.dispose();
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
                width: MediaQuery.of(context).size.width * 0.8,
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
                      'Address Details',
                      style: context.theme.fonts.headerLarger.copyWith(
                        fontSize: 24.sp,
                        color: context.theme.colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Please provide your address details, this will be used to complete your profile.',
                      style: context.theme.fonts.headerSmall.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      labelText: 'Country',
                      controller: _countryController,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Street',
                      controller: _addressController,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'City',
                      controller: _cityController,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Postal / zip code',
                      controller: _postalCodeController,
                    ),
                  ],
                ),
              ),
            ),
            PrimaryButton(
              text: 'Finish setup',
              onPressed: () {
                context.pushNamed(RouteConstants.profileCreated);
              },
            ),
          ],
        ),
      ),
    );
  }
}

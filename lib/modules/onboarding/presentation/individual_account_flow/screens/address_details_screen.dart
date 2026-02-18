// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/country_list_view.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
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
                      readOnly: true,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          Assets.icons.arrowDown,
                          colorFilter: ColorFilter.mode(
                            context.theme.colors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      onTap: () {
                        _showCountryBottomSheet(
                          title: 'Country',
                          onSelect: (Country country) {
                            setState(() {
                              _countryController.text =
                                  '${country.flagEmoji}  ${country.name}';
                            });
                          },
                        );
                      },
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
                context.router.push(ProfileCreatedSucessRoute());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryBottomSheet({
    required String title,
    required ValueChanged<Country> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CountryListView(
                  onSelect: (Country country) {
                    onSelect(country);
                  },
                  showPhoneCode: false,
                  countryListTheme: CountryListThemeData(
                    backgroundColor: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    searchTextStyle: const TextStyle(
                      color: Colors.black87,
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    flagSize: 28,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

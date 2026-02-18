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
  String _selectedDialCode = '+234';
  String _selectedFlagEmoji = '🇳🇬';

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
                          title: 'Country of citizenship',
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country.name;
                              _countryOfCitizenshipController.text =
                                  '${country.flagEmoji}  ${country.name}';
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Gender',
                      controller: _genderController,
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
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          builder: (context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...['Male', 'Female', 'Other'].map(
                                    (gender) => ListTile(
                                      title: Text(
                                        gender,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _genderController.text = gender;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      labelText: 'Date of birth',
                      controller: _dobController,
                      readOnly: true,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SvgPicture.asset(
                          Assets.icons.calendar,
                          colorFilter: ColorFilter.mode(
                            context.theme.colors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
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
                    _buildPhoneNumberField(),
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

  Widget _buildPhoneNumberField() {
    return AppTextField(
      labelText: 'Phone number',
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      prefixType: PrefixType.customWidget,
      prefixWidget: GestureDetector(
        onTap: () {
          _showCountryBottomSheet(
            title: 'Dial code',
            showPhoneCode: true,
            onSelect: (Country country) {
              setState(() {
                _selectedDialCode = '+${country.phoneCode}';
                _selectedFlagEmoji = country.flagEmoji;
              });
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedFlagEmoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 6),
              Text(
                _selectedDialCode,
                style: context.theme.fonts.textMdMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                Assets.icons.arrowDown,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryBottomSheet({
    required String title,
    required bool showPhoneCode,
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
                  showPhoneCode: showPhoneCode,
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

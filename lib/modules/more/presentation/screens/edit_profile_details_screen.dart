// ignore_for_file: deprecated_member_use, implementation_imports

import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/country_list_view.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class EditProfileDetailsScreen extends StatefulWidget {
  const EditProfileDetailsScreen({super.key});

  @override
  State<EditProfileDetailsScreen> createState() =>
      _EditProfileDetailsScreenState();
}

class _EditProfileDetailsScreenState extends State<EditProfileDetailsScreen> {
  final TextEditingController _firstNameController =
      TextEditingController(text: 'Oluwagbemiro');
  final TextEditingController _lastNameController =
      TextEditingController(text: 'Adegboyega');
  final TextEditingController _citizenshipController =
      TextEditingController(text: '🇳🇬  Nigeria');
  final TextEditingController _dobController =
      TextEditingController(text: '18 May 2003');
  final TextEditingController _genderController =
      TextEditingController(text: 'Male');
  final TextEditingController _phoneController =
      TextEditingController(text: '801 234 5678');

  String _selectedDialCode = '+234';
  String _selectedFlagEmoji = '🇳🇬';

  static const List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _citizenshipController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.router.maybePop(),
          child: Icon(
            Icons.chevron_left,
            color: colors.textPrimary,
            size: 28.w,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Edit profile details',
                      style: fonts.heading2Bold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Update your personal information to keep your profile accurate and up to date.',
                      style: fonts.textBaseRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      controller: _firstNameController,
                      labelText: 'Legal first name',
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _lastNameController,
                      labelText: 'Legal last name',
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _citizenshipController,
                      labelText: 'Country of citizenship',
                      readOnly: true,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: SvgPicture.asset(
                          Assets.icons.arrowDown,
                          colorFilter: ColorFilter.mode(
                            colors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      onTap: () => _showCountryBottomSheet(
                        title: 'Country of citizenship',
                        showPhoneCode: false,
                        onSelect: (Country country) {
                          setState(() {
                            _citizenshipController.text =
                                '${country.flagEmoji}  ${country.name}';
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _dobController,
                      labelText: 'Date of birth',
                      readOnly: true,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: SvgPicture.asset(
                          Assets.icons.calendar,
                          colorFilter: ColorFilter.mode(
                            colors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2003, 5, 18),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: colors.brandDefault,
                                  onPrimary: colors.contrastWhite,
                                  onSurface: colors.textPrimary,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            _dobController.text =
                                '${picked.day} ${_months[picked.month - 1]} ${picked.year}';
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _genderController,
                      labelText: 'Gender',
                      readOnly: true,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: SvgPicture.asset(
                          Assets.icons.arrowDown,
                          colorFilter: ColorFilter.mode(
                            colors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      onTap: () => _showGenderBottomSheet(),
                    ),
                    SizedBox(height: 16.h),
                    _buildPhoneField(context),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: 'Save changes',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return AppTextField(
      controller: _phoneController,
      labelText: 'Phone number',
      keyboardType: TextInputType.phone,
      prefixType: PrefixType.customWidget,
      prefixWidget: GestureDetector(
        onTap: () => _showCountryBottomSheet(
          title: 'Dial code',
          showPhoneCode: true,
          onSelect: (Country country) {
            setState(() {
              _selectedDialCode = '+${country.phoneCode}';
              _selectedFlagEmoji = country.flagEmoji;
            });
          },
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _selectedFlagEmoji,
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(width: 6.w),
              Text(
                _selectedDialCode,
                style: fonts.textMdMedium.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(width: 4.w),
              SvgPicture.asset(
                Assets.icons.arrowDown,
                width: 12.w,
                colorFilter: ColorFilter.mode(
                  colors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGenderBottomSheet() {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      backgroundColor: isLightMode ? colors.bgB0 : colors.bgB1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.bgB2,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Gender',
                style: fonts.textLgSemiBold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              ...['Male', 'Female', 'Other'].map(
                (gender) => ListTile(
                  title: Text(
                    gender,
                    style: fonts.textBaseMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                  onTap: () {
                    setState(() => _genderController.text = gender);
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  void _showCountryBottomSheet({
    required String title,
    required bool showPhoneCode,
    required ValueChanged<Country> onSelect,
  }) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: isLightMode ? colors.bgB0 : colors.bgB1,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: colors.bgB2,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 12.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: fonts.textLgSemiBold.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CountryListView(
                  onSelect: (Country country) {
                    onSelect(country);
                    Navigator.pop(context);
                  },
                  showPhoneCode: showPhoneCode,
                  countryListTheme: CountryListThemeData(
                    backgroundColor:
                        isLightMode ? colors.bgB0 : colors.bgB1,
                    textStyle: fonts.textBaseMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                    searchTextStyle: fonts.textBaseRegular.copyWith(
                      color: colors.textPrimary,
                    ),
                    inputDecoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: fonts.textBaseRegular.copyWith(
                        color: colors.textTertiary,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: colors.textTertiary,
                      ),
                      filled: true,
                      fillColor: isLightMode ? colors.bgB1 : colors.bgB2,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.h),
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

// ignore_for_file: deprecated_member_use, implementation_imports

import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/country_list_view.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class EditAddressDetailsScreen extends StatefulWidget {
  const EditAddressDetailsScreen({super.key});

  @override
  State<EditAddressDetailsScreen> createState() =>
      _EditAddressDetailsScreenState();
}

class _EditAddressDetailsScreenState extends State<EditAddressDetailsScreen> {
  final TextEditingController _countryController =
      TextEditingController(text: '🇳🇬  Nigeria');
  final TextEditingController _streetController = TextEditingController(
    text: 'No 8 James Robertson Shittu/Ogunlana Drive',
  );
  final TextEditingController _cityController =
      TextEditingController(text: 'Surulere');
  final TextEditingController _postalCodeController =
      TextEditingController(text: '142261');

  @override
  void dispose() {
    _countryController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
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
                      context.l10n.editAddressDetails,
                      style: fonts.heading2Bold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Change or correct your address to ensure accurate records and communication.',
                      style: fonts.textBaseRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    AppTextField(
                      controller: _countryController,
                      labelText: context.l10n.country,
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
                        title: context.l10n.country,
                        onSelect: (Country country) {
                          setState(() {
                            _countryController.text =
                                '${country.flagEmoji}  ${country.name}';
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _streetController,
                      labelText: context.l10n.street,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _cityController,
                      labelText: context.l10n.city,
                      textCapitalization: TextCapitalization.words,
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _postalCodeController,
                      labelText: context.l10n.postalZipCode,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: context.l10n.saveChanges,
                onPressed: () {},
              ),
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
                  showPhoneCode: false,
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
                      hintText: context.l10n.search,
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

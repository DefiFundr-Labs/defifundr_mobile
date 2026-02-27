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
class EditTaxInformationScreen extends StatefulWidget {
  const EditTaxInformationScreen({super.key});

  @override
  State<EditTaxInformationScreen> createState() =>
      _EditTaxInformationScreenState();
}

class _EditTaxInformationScreenState extends State<EditTaxInformationScreen> {
  bool _useProfileAddress = false;

  final TextEditingController _countryController =
      TextEditingController(text: '🇳🇬  Nigeria');
  final TextEditingController _addressController = TextEditingController(
    text: 'No 8 James Robertson Shittu/Ogunlana Drive',
  );
  final TextEditingController _cityController =
      TextEditingController(text: 'Surulere');
  final TextEditingController _postalCodeController =
      TextEditingController(text: '142261');
  final TextEditingController _taxIdController =
      TextEditingController(text: '1234567890');

  @override
  void dispose() {
    _countryController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    _taxIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

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
                      context.l10n.editTaxInformation,
                      style: fonts.heading2Bold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.l10n.editTaxInformationSubtitle,
                      style: fonts.textBaseRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildUseProfileAddressToggle(
                        context, colors, fonts, isLightMode),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _countryController,
                      labelText: context.l10n.countryOfTaxResidence,
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
                        title: context.l10n.countryOfTaxResidence,
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
                      controller: _addressController,
                      labelText: context.l10n.address,
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
                    Text(
                      'Tax identification',
                      style: fonts.textLgSemiBold.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppTextField(
                      controller: _taxIdController,
                      labelText: context.l10n.taxId,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
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

  Widget _buildUseProfileAddressToggle(
    BuildContext context,
    dynamic colors,
    dynamic fonts,
    bool isLightMode,
  ) {
    return GestureDetector(
      onTap: () => setState(() => _useProfileAddress = !_useProfileAddress),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isLightMode ? colors.bgB1 : colors.bgB2,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Use my profile address',
                style: fonts.textBaseMedium.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            SizedBox(
              width: 22.w,
              height: 22.w,
              child: Checkbox(
                value: _useProfileAddress,
                onChanged: (value) =>
                    setState(() => _useProfileAddress = value ?? false),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                side: BorderSide(
                  color: colors.textTertiary,
                  width: 1.5,
                ),
                activeColor: colors.brandDefault,
                checkColor: colors.contrastWhite,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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

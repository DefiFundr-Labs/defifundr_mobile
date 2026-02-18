import 'package:auto_route/auto_route.dart';
import 'package:country_picker/country_picker.dart';
import 'package:country_picker/src/country_list_view.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/custom_checkbox.dart';

@RoutePage()
class TaxInformationScreen extends StatefulWidget {
  const TaxInformationScreen({super.key});

  @override
  State<TaxInformationScreen> createState() => _TaxInformationScreenState();
}

class _TaxInformationScreenState extends State<TaxInformationScreen> {
  bool useProfileAddress = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final countryController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final postalCodeController = TextEditingController();
    final taxIdController = TextEditingController();
    return Scaffold(
      appBar: DeFiRaiseAppBar(
        leading: CustomBackButton(),
      ),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tax Information',
                      style: context.theme.fonts.heading2Bold.copyWith(
                          color: context.theme.colors.textPrimary,
                          fontFamily: 'HankenGrotesk')),
                  const SizedBox(height: 4),
                  Text(
                      'To stay compliant, we need your tax details. This helps us fulfill regulatory obligations.',
                      style: context.theme.fonts.textMdRegular
                          .copyWith(color: colors.textSecondary)),
                  const SizedBox(height: 24),
                  CustomCheckboxTile(
                      label: 'Use my profile address',
                      value: useProfileAddress,
                      onChanged: (value) {
                        setState(() {
                          useProfileAddress = value ?? false;
                        });
                      }),
                  AppTextField(
                    labelText: 'Country of tax residence',
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
                    controller: countryController,
                    readOnly: true,
                    onTap: () {
                      _showCountryBottomSheet(
                        title: 'Country of tax residence',
                        onSelect: (Country country) {
                          countryController.text =
                              '${country.flagEmoji}  ${country.name}';
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    controller: addressController,
                    labelText: 'Address',
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    controller: cityController,
                    labelText: 'City',
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                      keyboardType: TextInputType.number,
                      controller: postalCodeController,
                      labelText: 'Postal / zip code'),
                  SizedBox(height: 24),
                  Text("Tax identification",
                      style: fonts.textBaseMedium
                          .copyWith(color: context.theme.colors.textPrimary)),
                  SizedBox(height: 12),
                  AppTextField(
                    controller: taxIdController,
                    labelText: 'Tax ID',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.h),
          PrimaryButton(
              text: "Save details",
              onPressed: () => context.router.push(const MainShellRoute())),
          SizedBox(height: 20.h),
        ],
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

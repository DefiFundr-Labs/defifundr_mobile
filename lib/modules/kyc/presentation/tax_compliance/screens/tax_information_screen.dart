import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/bottom_sheet/selection_bottom_sheet.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/tax_compliance/widgets/countries_list.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_checkbox.dart';
import 'package:auto_route/auto_route.dart';

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
                    suffixType: SuffixType.defaultt,
                    controller: countryController,
                    readOnly: true,
                    onTap: () async {
                      final selected = await showModalBottomSheet<String>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => SelectionBottomSheet<String>(
                          title: 'Country of tax residence',
                          items: countries,
                          itemBuilder: (context, item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              item,
                              style: fonts.textMdRegular,
                            ),
                          ),
                        ),
                      );

                      if (selected != null) {
                        countryController.text = selected;
                      }
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
              onPressed: () =>
                  context.router.push(const OnboardingChecklistRoute())),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

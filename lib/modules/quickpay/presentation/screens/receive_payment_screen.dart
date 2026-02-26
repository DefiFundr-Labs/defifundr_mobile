import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/receive_params.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/select_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class ReceivePaymentScreen extends StatefulWidget {
  const ReceivePaymentScreen({super.key});

  @override
  State<ReceivePaymentScreen> createState() => _ReceivePaymentScreenState();
}

class _ReceivePaymentScreenState extends State<ReceivePaymentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  ValueNotifier<Network?> selectedNetwork = ValueNotifier<Network?>(null);
  ValueNotifier<NetworkAsset?> selectedAsset =
      ValueNotifier<NetworkAsset?>(null);

  void _selectNetwork(BuildContext context) async {
    final result = await context.router.push<Network>(SelectNetworkRoute());
    if (result != null) {
      selectedNetwork.value = result;
      selectedAsset.value = null;
    }
  }

  void _selectAsset(BuildContext context) async {
    final result = await context.router.push<NetworkAsset>(SelectAssetRoute());
    if (result != null) {
      selectedAsset.value = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: resolveColor(
        context: context,
        lightColor: AppColors.bgB0Base,
        darkColor: AppColorDark.bgB0Base,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.contrastBlack,
                          darkColor: AppColorDark.contrastBlack,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.questionSvg,
                          colorFilter: ColorFilter.mode(
                            resolveColor(
                              context: context,
                              lightColor: AppColors.textPrimary,
                              darkColor: AppColorDark.textPrimary,
                            ),
                            BlendMode.srcIn,
                          ),
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Need Help?',
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            color: resolveColor(
                              context: context,
                              lightColor: AppColors.textPrimary,
                              darkColor: AppColorDark.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24 / 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Receive Payment',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'HankenGrotesk',
                          fontWeight: FontWeight.w700,
                          color: resolveColor(
                            context: context,
                            lightColor: AppColors.textPrimary,
                            darkColor: AppColorDark.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Receive crypto payments instantly via address, QR code, or payment link.',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: resolveColor(
                            context: context,
                            lightColor: AppColors.textSecondary,
                            darkColor: AppColorDark.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8 * 3),
                    AppTextField(
                      labelText: 'Title',
                      controller: titleController,
                    ),
                    const SizedBox(height: 8 * 3),
                    ValueListenableBuilder(
                        valueListenable: selectedAsset,
                        builder: (ctx, _, __) {
                          return ValueListenableBuilder(
                              valueListenable: selectedNetwork,
                              builder: (ctx, _, __) {
                                return Column(
                                  children: [
                                    SelectPayment(
                                      label: selectedNetwork.value != null
                                          ? 'Network'
                                          : null,
                                      title: selectedNetwork.value != null
                                          ? selectedNetwork.value!.name
                                          : 'Network',
                                      trailingImagePath:
                                          selectedNetwork.value?.iconPath,
                                      titleStyle: selectedNetwork.value != null
                                          ? TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: resolveColor(
                                                context: context,
                                                lightColor:
                                                    AppColors.textPrimary,
                                                darkColor:
                                                    AppColorDark.textPrimary,
                                              ),
                                              fontFamily: 'Inter',
                                            )
                                          : null,
                                      onTap: () {
                                        _selectNetwork(context);
                                      },
                                    ),
                                    const SizedBox(height: 8 * 3),
                                    SelectPayment(
                                      label: selectedAsset.value != null
                                          ? 'Asset'
                                          : null,
                                      title: selectedAsset.value != null
                                          ? selectedAsset.value!.name
                                          : 'Asset',
                                      trailingImagePath:
                                          selectedAsset.value?.iconPath,
                                      titleStyle: selectedAsset.value != null
                                          ? TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: resolveColor(
                                                context: context,
                                                lightColor:
                                                    AppColors.textPrimary,
                                                darkColor:
                                                    AppColorDark.textPrimary,
                                              ),
                                              fontFamily: 'Inter',
                                            )
                                          : null,
                                      onTap: () {
                                        _selectAsset(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        }),
                    const SizedBox(height: 8 * 3),
                    AppTextField(
                      labelText: 'Amount',
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: amountController,
                      suffixType: SuffixType.customIcon,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          'USDT',
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '≈ \$500',
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.textPrimary,
                          darkColor: AppColorDark.textPrimary,
                        ),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: BrandButton(
                text: "Continue",
                onPressed: () {
                  if (selectedNetwork.value == null ||
                      selectedAsset.value == null ||
                      titleController.text.isEmpty ||
                      amountController.text.isEmpty) {
                    AppSnackbar.show(context, 'Please fill in all fields.');
                    return;
                  }
                  context.router.push(
                    ReceivePaymentDoneRoute(
                      args: ReceiveParams(
                        amount: amountController.text,
                        title: titleController.text,
                        coinName: selectedNetwork.value!.name,
                        assetName: selectedAsset.value!.name,
                        imageUrl: selectedNetwork.value!.iconPath,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

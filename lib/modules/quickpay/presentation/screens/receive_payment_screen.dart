import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/coin_assets.dart';
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
  final ethereumAssets = CoinAssets(
    coinName: 'Ethereum',
    logoUrl: AppAssets.ethereumLogo,
    assets: [Asset(decimals: 6, logoUrl: AppAssets.usdtLogo, symbol: 'USDT')],
  );

  ValueNotifier<CoinAssets?> selectedCoin = ValueNotifier<CoinAssets?>(null);
  ValueNotifier<Asset?> selectedAsset = ValueNotifier<Asset?>(null);

  List<CoinAssets> allCoinAssets = [];

  @override
  void initState() {
    super.initState();

    if (allCoinAssets.isEmpty) {
      allCoinAssets = [ethereumAssets];
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
                              valueListenable: selectedCoin,
                              builder: (ctx, _, __) {
                                return Column(
                                  children: [
                                    SelectPayment(
                                      title: selectedCoin.value != null
                                          ? selectedCoin.value!.coinName
                                          : 'Network',
                                      iconUrl: selectedCoin.value?.logoUrl,
                                      titleStyle: selectedCoin.value != null
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
                                    ),
                                    const SizedBox(height: 8 * 3),
                                    SelectPayment(
                                      title: selectedAsset.value != null
                                          ? selectedAsset.value!.symbol
                                          : 'Asset',
                                      iconUrl: selectedAsset.value?.logoUrl,
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
                        padding: const EdgeInsets.only(right: 0),
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
                  if (selectedAsset.value == null ||
                      selectedCoin.value == null) {
                    selectedAsset.value = allCoinAssets.first.assets.first;
                    selectedCoin.value = allCoinAssets.first;
                    return;
                  }
                  if (titleController.text.isEmpty ||
                      amountController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please fill in all fields.',
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.redActive,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    );
                    return;
                  }
                  context.router.push(
                    ReceivePaymentDoneRoute(
                      args: ReceiveParams(
                        amount: amountController.text,
                        title: titleController.text,
                        coinName: selectedCoin.value!.coinName,
                        assetName: selectedAsset.value!.symbol,
                        imageUrl: selectedCoin.value!.logoUrl,
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

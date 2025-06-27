import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/models/selection_item.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/bottom_sheet/selection_bottom_sheet.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/coin_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReceivePaymentScreen extends StatefulWidget {
  const ReceivePaymentScreen({super.key});

  @override
  State<ReceivePaymentScreen> createState() => _ReceivePaymentScreenState();
}

class _ReceivePaymentScreenState extends State<ReceivePaymentScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController networkController = TextEditingController();
  TextEditingController assetController = TextEditingController();
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
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: DeFiRaiseAppBar(
        leading: CustomBackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Receive Payment',
                      style: context.theme.fonts.heading2Bold.copyWith(
                          fontFamily: 'HankenGrotesk',
                          color: context.theme.colors.textPrimary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Receive crypto payments instantly via address, QR code, or payment link.',
                        style: context.theme.fonts.textMdRegular.copyWith(
                            color: context.theme.colors.textSecondary)),
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                    labelText: 'Title',
                    controller: titleController,
                  ),
                  const SizedBox(height: 20),
                  // ValueListenableBuilder(
                  //     valueListenable: selectedAsset,
                  //     builder: (ctx, _, __) {
                  //       return ValueListenableBuilder(
                  //           valueListenable: selectedCoin,
                  //           builder: (ctx, _, __) {
                  //             return Column(
                  //               children: [
                  //                 SelectPayment(
                  //                   title: selectedCoin.value != null
                  //                       ? selectedCoin.value!.coinName
                  //                       : 'Network',
                  //                   iconUrl: selectedCoin.value?.logoUrl,
                  //                   titleStyle: selectedCoin.value != null
                  //                       ? context.theme.fonts.textMdRegular
                  //                           .copyWith(
                  //                               color: context
                  //                                   .theme.colors.textTertiary)
                  //                       : null,
                  //                 ),
                  //                 const SizedBox(height: 8 * 3),
                  //                 SelectPayment(
                  //                   title: selectedAsset.value != null
                  //                       ? selectedAsset.value!.symbol
                  //                       : 'Asset',
                  //                   iconUrl: selectedAsset.value?.logoUrl,
                  //                   titleStyle: selectedAsset.value != null
                  //                       ? TextStyle(
                  //                           fontSize: 14,
                  //                           fontWeight: FontWeight.w400,
                  //                           color: resolveColor(
                  //                             context: context,
                  //                             lightColor: AppColors.textPrimary,
                  //                             darkColor: AppColorDark.textPrimary,
                  //                           ),
                  //                           fontFamily: 'Inter',
                  //                         )
                  //                       : null,
                  //                 ),
                  //               ],
                  //             );
                  //           });
                  //     }),

                  AppTextField(
                    labelText: 'Network',
                    suffixType: SuffixType.defaultt,
                    controller: networkController,
                    readOnly: true,
                    onTap: () async {
                      final selected =
                          await showModalBottomSheet<SelectionItem>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (_) => SelectionBottomSheet<SelectionItem>(
                          controller: networkController,
                          title: 'Network',
                          items: [
                            SelectionItem(
                                title: 'Ethereum', iconPath: AppAssets.ethPng),
                            SelectionItem(
                                title: 'Starknet',
                                iconPath: AppAssets.starknetPng),
                            SelectionItem(
                                title: 'Base', iconPath: AppAssets.basePng),
                            SelectionItem(
                                title: 'Polygon', iconPath: AppAssets.maticPng),
                            SelectionItem(
                                title: 'BNB Chain', iconPath: AppAssets.bnbPng),
                            SelectionItem(
                                title: 'Arbitrum One',
                                iconPath: AppAssets.arbitrumPng),
                            SelectionItem(
                                title: 'Optimism',
                                iconPath: AppAssets.optimismPng),
                            SelectionItem(
                                title: 'Gnosis Chain',
                                iconPath: AppAssets.gnosisPng),
                            SelectionItem(
                                title: 'zkSync Era',
                                iconPath: AppAssets.zksyncPng),
                          ],
                          itemBuilder: (context, item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(item.iconPath),
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.title,
                                  style: context.theme.fonts.textMdRegular
                                      .copyWith(
                                    color: context.theme.colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                      if (selected != null) {
                        networkController.text = selected.title;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextField(
                    labelText: 'Asset',
                    suffixType: SuffixType.defaultt,
                    controller: assetController,
                    readOnly: true,
                    onTap: () async {
                      final selected =
                          await showModalBottomSheet<SelectionItem>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (_) => SelectionBottomSheet<SelectionItem>(
                          controller: networkController,
                          title: 'Asset',
                          items: [
                            SelectionItem(
                                title: 'Tether USD (USDT)',
                                iconPath: AppAssets.usdtPng),
                            SelectionItem(
                                title: 'USD Coin (USDC)',
                                iconPath: AppAssets.usdcPng),
                            SelectionItem(
                                title: 'Dai Stablecoin (DAI)',
                                iconPath: AppAssets.daiPng),
                            SelectionItem(
                                title: 'Decentralized USD (USDD)',
                                iconPath: AppAssets.usddPng),
                            SelectionItem(
                                title: 'Liquity USD (LUSD)',
                                iconPath: AppAssets.lusdPng),
                            SelectionItem(
                                title: 'Euro Tether (EURt)',
                                iconPath: AppAssets.arbitrumPng),
                            SelectionItem(
                                title: 'Starknet (STRK)',
                                iconPath: AppAssets.starknetPng),
                          ],
                          itemBuilder: (context, item) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(item.iconPath),
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.title,
                                  style: context.theme.fonts.textMdRegular
                                      .copyWith(
                                    color: context.theme.colors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                      if (selected != null) {
                        networkController.text = selected.title;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    labelText: 'Amount',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: amountController,
                    suffixType: SuffixType.customIcon,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text('USDT',
                          style: context.theme.fonts.textMdRegular.copyWith(
                              color: context.theme.colors.textTertiary)),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('≈ \$500',
                      style: context.theme.fonts.textSmRegular
                          .copyWith(color: context.theme.colors.textPrimary)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: BrandButton(
              text: "Continue",
              onPressed: () {
                context.pushNamed(
                  RouteConstants.receivePaymentDoneScreen,
                  // extra: ReceiveParams(
                  //   amount: amountController.text,
                  //   title: titleController.text,
                  //   coinName: selectedCoin.value!.coinName,
                  //   assetName: selectedAsset.value!.symbol,
                  //   imageUrl: selectedCoin.value!.logoUrl,
                  // ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

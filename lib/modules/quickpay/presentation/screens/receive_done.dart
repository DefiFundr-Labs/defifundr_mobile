import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

import '../widgets/build_details_row.dart';

class ReceivePaymentDoneScreen extends StatefulWidget {
  // final ReceiveParams args;

  const ReceivePaymentDoneScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceivePaymentDoneScreen> createState() =>
      _ReceivePaymentDoneScreenState();
}

class _ReceivePaymentDoneScreenState extends State<ReceivePaymentDoneScreen> {
  final String userAddress = '0xfEBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  SizedBox(height: 16),
                  Card(
                    color: context.theme.colors.bgB1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        SizedBox(height: 24),
                        SizedBox(
                          height: height * 0.2,
                          child: Align(
                            alignment: Alignment.center,
                            child: QrImageView(
                              data: '',
                              version: QrVersions.auto,
                              dataModuleStyle: QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.square,
                                color: context.theme.colors.contrastBlack,
                              ),
                              eyeStyle: QrEyeStyle(
                                eyeShape: QrEyeShape.square,
                                color: context.theme.colors.contrastBlack,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        buildDetailsRow(
                          context,
                          'Title',
                          Text(
                            ellipsify(
                                word:
                                    'MintForge Bug fixes and performance updates',
                                maxLength: 20),
                            style: context.theme.fonts.textMdMedium.copyWith(
                                color: context.theme.colors.textPrimary),
                          ),
                        ),
                        buildDetailsRow(
                            context,
                            'Network',
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppAssets.ethereumLogo,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  ellipsify(
                                    word: 'Etherum',
                                    maxLength: 20,
                                  ),
                                  style: context.theme.fonts.textMdMedium
                                      .copyWith(
                                          color:
                                              context.theme.colors.textPrimary),
                                ),
                              ],
                            )),
                        buildDetailsRow(
                            context,
                            'Amount',
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '581 USDT',
                                  style: context.theme.fonts.textMdMedium
                                      .copyWith(
                                          color:
                                              context.theme.colors.textPrimary),
                                ),
                                Text('\$200.00',
                                    style: context.theme.fonts.textXsMedium
                                        .copyWith(
                                            color: context
                                                .theme.colors.textSecondary)),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address',
                                  style: context.theme.fonts.textMdRegular
                                      .copyWith(
                                          color: context
                                              .theme.colors.textPrimary)),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        userAddress,
                                        style: context.theme.fonts.textMdMedium
                                            .copyWith(
                                                color: context
                                                    .theme.colors.textPrimary),
                                        softWrap: true,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: userAddress,
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        AppAssets.copySvg,
                                        color: resolveColor(
                                          context: context,
                                          lightColor: context
                                              .theme.colors.contrastBlack,
                                          darkColor: context
                                              .theme.colors.contrastBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PrimaryButton(
                    color: context.theme.colors.fillTertiary.withOpacity(0.08),
                    icon: AppAssets.qrCodeSvg,
                    textColor: context.theme.colors.textPrimary,
                    text: "Share QR code",
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    textColor: AppColors.white,
                    iconColor: AppColors.white,
                    icon: AppAssets.linkSvg,
                    text: "Share pay link",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

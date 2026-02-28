import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/receive_params.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/filter_buttons.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class ReceivePaymentDoneScreen extends StatefulWidget {
  final ReceiveParams args;

  const ReceivePaymentDoneScreen({Key? key, required this.args})
      : super(key: key);

  @override
  State<ReceivePaymentDoneScreen> createState() =>
      _ReceivePaymentDoneScreenState();
}

class _ReceivePaymentDoneScreenState extends State<ReceivePaymentDoneScreen> {
  final String userAddress = '0xfEBA3E0dEca2Ad4CE3Bc4fb0f56A1970ae3837f3';
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
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            resolveColor(
                              context: context,
                              lightColor: AppColors.textPrimary,
                              darkColor: AppColorDark.textPrimary,
                            ),
                            BlendMode.srcIn,
                          ),
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
                    SizedBox(
                      height: 24,
                    ),
                    Card(
                      color: resolveColor(
                        context: context,
                        lightColor: AppColors.bgB1Base,
                        darkColor: AppColorDark.bgB1Base,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 270,
                            child: Align(
                              alignment: Alignment.center,
                              child: QrImageView(
                                padding: const EdgeInsets.all(12),
                                data: '',
                                version: QrVersions.auto,
                                dataModuleStyle: QrDataModuleStyle(
                                  dataModuleShape: QrDataModuleShape.square,
                                  color: resolveColor(
                                    context: context,
                                    lightColor: AppColors.textPrimary,
                                    darkColor: AppColorDark.textPrimary,
                                  ),
                                ),
                                eyeStyle: QrEyeStyle(
                                  eyeShape: QrEyeShape.square,
                                  color: resolveColor(
                                    context: context,
                                    lightColor: AppColors.textPrimary,
                                    darkColor: AppColorDark.textPrimary,
                                  ),
                                ),
                                size: 250,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0 * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Title',
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
                                Text(
                                  ellipsify(
                                    word: widget.args.title,
                                    maxLength: 20,
                                  ),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0 * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Network',
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
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      widget.args.imageUrl,
                                      width: 20,
                                      height: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      ellipsify(
                                        word: widget.args.coinName,
                                        maxLength: 20,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: resolveColor(
                                          context: context,
                                          lightColor: AppColors.textPrimary,
                                          darkColor: AppColorDark.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0 * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Amount',
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${widget.args.amount} ${widget.args.assetName}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: resolveColor(
                                          context: context,
                                          lightColor: AppColors.textPrimary,
                                          darkColor: AppColorDark.textPrimary,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$200.00',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: resolveColor(
                                          context: context,
                                          lightColor: AppColors.textSecondary,
                                          darkColor: AppColorDark.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0 * 2,
                              right: 8 * 2,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Address',
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0 * 2,
                              right: 8.0 * 2,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    userAddress,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      color: resolveColor(
                                        context: context,
                                        lightColor: AppColors.textPrimary,
                                        darkColor: AppColorDark.textPrimary,
                                      ),
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text: userAddress,
                                      ),
                                    );
                                    if (!context.mounted) return;
                                    AppSnackbar.show(
                                        context, 'Copied to clipboard');
                                  },
                                  child: SvgPicture.asset(
                                    AppAssets.copySvg,
                                    colorFilter: ColorFilter.mode(
                                      resolveColor(
                                        context: context,
                                        lightColor: AppColors.textPrimary,
                                        darkColor: AppColorDark.textPrimary,
                                      ),
                                      BlendMode.srcIn,
                                    ),
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton(
                    backgroundColor: resolveColor(
                      context: context,
                      lightColor: AppColors.strokeSecondary.withValues(
                        alpha: 0.08,
                      ),
                      darkColor: AppColorDark.strokeSecondary.withValues(
                        alpha: 0.8,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.qrCodeSvg,
                      colorFilter: ColorFilter.mode(
                        resolveColor(
                          context: context,
                          lightColor: AppColors.textPrimary,
                          darkColor: AppColorDark.textPrimary,
                        ),
                        BlendMode.srcIn,
                      ),
                      width: 16,
                      height: 16,
                    ),
                    fontSize: 14,
                    textColor: resolveColor(
                      context: context,
                      lightColor: AppColors.textPrimary,
                      darkColor: AppColorDark.textPrimary,
                    ),
                    text: "Share QR code",
                    onPressed: () {},
                  ),
                  SmallButton(
                    fontSize: 14,
                    icon: SvgPicture.asset(
                      AppAssets.linkSvg,
                      colorFilter: ColorFilter.mode(
                        resolveColor(
                          context: context,
                          lightColor: AppColors.contrastWhite,
                          darkColor: AppColorDark.contrastBlack,
                        ),
                        BlendMode.srcIn,
                      ),
                      width: 16,
                      height: 16,
                    ),
                    text: "Share pay link",
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

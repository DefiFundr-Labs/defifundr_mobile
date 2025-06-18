import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/filter_buttons.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  final QuickPayment args;

  const TransactionScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const CustomBackButton(),
                  ),
                  Center(
                    child: Text(
                      'Quickpay',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.textPrimary,
                          darkColor: AppColorDark.textPrimary,
                        ),
                      ),
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
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: resolveColor(
                          context: context,
                          lightColor: AppColors.bgB1Base,
                          darkColor: AppColorDark.bgB1Base,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 8 * 2,
                            ),
                            SvgPicture.asset(
                              AppAssets.depositIconSvg,
                              width: 60,
                              height: 60,
                            ),
                            SizedBox(
                              height: 8 * 2,
                            ),
                            Text(
                              '${widget.args.paymentType == QuickPaymentsType.deposit ? '+' : '-'} ${widget.args.amount} ${widget.args.currency}',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'HankenGrotesk',
                                fontWeight: FontWeight.w700,
                                color: widget.args.paymentType ==
                                        QuickPaymentsType.deposit
                                    ? AppColors.greenDefault
                                    : AppColors.redDefault,
                              ),
                            ),
                            Text(
                              '≈ \$476.19',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: resolveColor(
                                  context: context,
                                  lightColor: AppColors.textSecondary,
                                  darkColor: AppColorDark.textSecondary,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8 * 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8 * 2,
                    ),
                    Card(
                      color: resolveColor(
                        context: context,
                        lightColor: AppColors.bgB1Base,
                        darkColor: AppColorDark.bgB1Base,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0 * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status',
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
                                Container(
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color:
                                        widget.args.status.fillColor(context),
                                    border: Border.all(
                                      color: widget.args.status
                                          .borderColor(context),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.args.status.titleCase,
                                        style: TextStyle(
                                          color: widget.args.status
                                              .textColor(context),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
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
                                    word: widget.args.description,
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
                                        word: widget.args.network,
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
                          if (widget.args.from != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0 * 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'From',
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
                                    ellipsifyAddress(
                                      word: widget.args.from!,
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
                          if (widget.args.to != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0 * 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'To',
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
                                    ellipsifyAddress(
                                      word: widget.args.to!,
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
                                  'Transaction ID',
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
                                  ellipsifyAddress(
                                    word: widget.args.transactionHash,
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
                                  'Date',
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
                                  DateFormat('d MMMM yyyy, hh:mm a')
                                      .format(widget.args.date),
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
                      darkColor: AppColors.strokeSecondary.withValues(
                        alpha: 0.8,
                      ),
                    ),
                    icon: SvgPicture.asset(
                      AppAssets.headsetSvg,
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
                    fontSize: 14,
                    textColor: resolveColor(
                      context: context,
                      lightColor: AppColors.textPrimary,
                      darkColor: AppColorDark.textPrimary,
                    ),
                    text: "Help centre",
                    onPressed: () {},
                  ),
                  SmallButton(
                    fontSize: 14,
                    icon: SvgPicture.asset(
                      AppAssets.shareNetworkSvg,
                      width: 20,
                      height: 20,
                    ),
                    text: "Share receipt",
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

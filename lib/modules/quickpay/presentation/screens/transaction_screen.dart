import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/build_details_row.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        centerTitle: true,
        leading: CustomBackButton(),
        title: Text(
          'Quickpay',
          style: context.theme.fonts.heading3SemiBold
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.theme.colors.bgB0,
                          boxShadow: [
                            BoxShadow(
                                color: context.theme.colors.contrastBlack,
                                spreadRadius: -5,
                                offset: Offset(0, 1),
                                blurRadius: 1)
                          ]),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppAssets.depositIconSvg,
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(height: 16),
                          Text(
                              '${widget.args.paymentType == QuickPaymentsType.deposit ? '+' : '-'} ${widget.args.amount} ${widget.args.currency}',
                              style: context.theme.fonts.heading1Bold.copyWith(
                                  fontFamily: 'HankenGrotesk',
                                  color: context.theme.colors.greenDefault)),
                          Text('≈ \$476.19',
                              style: context.theme.fonts.textBaseRegular
                                  .copyWith(
                                      color:
                                          context.theme.colors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: context.theme.colors.bgB0,
                      boxShadow: [
                        BoxShadow(
                            color: context.theme.colors.contrastBlack,
                            spreadRadius: -5,
                            offset: Offset(0, 1),
                            blurRadius: 1)
                      ],
                    ),
                    child: Column(
                      children: [
                        buildDetailsRow(
                          context,
                          'Status',
                          Container(
                            decoration: BoxDecoration(
                              color: widget.args.status.fillColor(context),
                              border: Border.all(
                                color: widget.args.status.borderColor(context),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: Text(
                              widget.args.status.titleCase,
                              style:
                                  context.theme.fonts.textXsSemiBold.copyWith(
                                color: widget.args.status.textColor(context),
                              ),
                            ),
                          ),
                        ),
                        buildDetailsRow(
                          context,
                          'Title',
                          Text(
                            ellipsify(
                                word: widget.args.description, maxLength: 20),
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
                                widget.args.imageUrl,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                ellipsify(
                                  word: widget.args.network,
                                  maxLength: 20,
                                ),
                                style: context.theme.fonts.textMdMedium
                                    .copyWith(
                                        color:
                                            context.theme.colors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                        if (widget.args.from != null)
                          buildDetailsRow(
                            context,
                            'From',
                            Text(
                              ellipsifyAddress(
                                word: widget.args.from!,
                                maxLength: 14,
                              ),
                            ),
                          ),
                        if (widget.args.to != null)
                          buildDetailsRow(
                            context,
                            'To',
                            Text(
                              ellipsifyAddress(
                                word: widget.args.to!,
                                maxLength: 14,
                              ),
                            ),
                          ),
                        buildDetailsRow(
                          context,
                          'Transaction ID',
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  ellipsifyAddress(
                                    word: widget.args.transactionHash,
                                    maxLength: 10,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                      ClipboardData(
                                        text: widget.args.transactionHash,
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    AppAssets.copySvg,
                                    color: resolveColor(
                                      context: context,
                                      lightColor:
                                          context.theme.colors.contrastWhite,
                                      darkColor:
                                          context.theme.colors.contrastBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        buildDetailsRow(
                          context,
                          'Date',
                          Text(
                            DateFormat('d MMMM yyyy, hh:mm a')
                                .format(widget.args.date),
                          ),
                        ),
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
                    icon: Assets.icons.questionSvg,
                    textColor: context.theme.colors.textPrimary,
                    text: "Help centre",
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    icon: AppAssets.shareNetworkSvg,
                    textColor: AppColors.white,
                    iconColor: AppColors.white,
                    text: "Share receipt",
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

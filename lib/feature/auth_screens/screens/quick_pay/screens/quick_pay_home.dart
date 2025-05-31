import 'dart:ui';

import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/class/quick_payments.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/checkbox_status.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/filled_quickPay.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/filter_buttons.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/time_filter_radio.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/slide_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuickPayHomeScreen extends StatefulWidget {
  const QuickPayHomeScreen({super.key});

  @override
  State<QuickPayHomeScreen> createState() => _QuickPayHomeScreenState();
}

class _QuickPayHomeScreenState extends State<QuickPayHomeScreen> {
  List<QuickPayment> quickPays = [];

  @override
  void initState() {
    super.initState();
    demoPayment();
  }

  void demoPayment() {
    quickPays.addAll([
      QuickPayment(
        id: '1',
        status: QuickPaymentsStatus.processing,
        date: DateTime.now(),
        amount: BigInt.from(101),
        currency: 'DAI',
        description: 'Neurolytix Initial consultation session',
        paymentType: QuickPaymentsType.deposit,
      ),
      QuickPayment(
        id: '2',
        status: QuickPaymentsStatus.successful,
        date: DateTime.now().subtract(const Duration(days: 2)),
        amount: BigInt.from(21),
        currency: 'USDC',
        description: 'MintForge Bug fixes and performance updates',
        paymentType: QuickPaymentsType.withdrawal,
      ),
      QuickPayment(
        id: '3',
        status: QuickPaymentsStatus.failed,
        date: DateTime.now().subtract(const Duration(days: 2)),
        amount: BigInt.from(200),
        currency: 'LUSD',
        description: 'ShopLink Pro UX Audit feedback & report',
        paymentType: QuickPaymentsType.deposit,
      ),
      QuickPayment(
        id: '4',
        status: QuickPaymentsStatus.successful,
        date: DateTime.now().subtract(const Duration(days: 2)),
        amount: BigInt.from(101),
        currency: 'DAI',
        description: 'Brightfolk Payment for consulting services',
        paymentType: QuickPaymentsType.deposit,
      ),
      QuickPayment(
        id: '5',
        status: QuickPaymentsStatus.successful,
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: BigInt.from(581),
        currency: 'USDT',
        description: 'LoopLabs Transfer for content creation',
        paymentType: QuickPaymentsType.deposit,
      ),
      QuickPayment(
        id: '6',
        status: QuickPaymentsStatus.successful,
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: BigInt.from(50),
        currency: 'EURt',
        description: 'Paylite Payment for project management',
        paymentType: QuickPaymentsType.deposit,
      ),
      QuickPayment(
        id: '7',
        status: QuickPaymentsStatus.successful,
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: BigInt.from(581),
        currency: 'STARK',
        description: 'Quikdash Reimbursement for software tools',
        paymentType: QuickPaymentsType.deposit,
      ),
    ]);
  }

  ValueNotifier<bool> isPanelVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgB0Base,
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomBackButton(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.contrastBlack),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.questionSvg,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Need Help?',
                                style: context.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: AppColors.textPrimary,
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
                              'Quickpay',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'HankenGrotesk',
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
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
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8 * 1.5),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  width: 283,
                                  child: TextField(
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      height: 1.5,
                                      letterSpacing: 0.0,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search',
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 1.5,
                                        letterSpacing: 0.0,
                                        color: AppColors.textTertiary,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.bgB1Base,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 8),
                                        child: SvgPicture.asset(
                                          AppAssets.magnifyingGlass,
                                        ),
                                      ),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 0,
                                        minHeight: 0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: AppColors.strokeSecondary,
                                          width: 0.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: AppColors.strokeSecondary,
                                          width: 0.5,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color: AppColors.strokeSecondary,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () async {
                                  isPanelVisible.value = true;
                                  await slideUpPanel(
                                    context,
                                    SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 25,
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: SvgPicture.asset(
                                                AppAssets.rectangelSvg,
                                                width: 48,
                                                height: 5,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Filter by',
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: 'HankenGrotesk',
                                                  fontWeight: FontWeight.w700,
                                                  height: 32 / 24,
                                                  letterSpacing: 0,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent,
                                              ),
                                              child: ExpansionTile(
                                                title: Text(
                                                  'Status',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ),
                                                tilePadding: EdgeInsets.zero,
                                                childrenPadding:
                                                    EdgeInsets.zero,
                                                children: [
                                                  CheckBoxStatus(
                                                    onChanged: (value) {
                                                      print(value);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.strokeSecondary
                                                  .withValues(alpha: 0.06),
                                              height: 1,
                                            ),
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                dividerColor:
                                                    Colors.transparent,
                                              ),
                                              child: ExpansionTile(
                                                title: Text(
                                                  'Date',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ),
                                                tilePadding: EdgeInsets.zero,
                                                childrenPadding:
                                                    EdgeInsets.zero,
                                                children: [
                                                  TimeFilterRadio(
                                                    onChanged: (selected) {
                                                      print(selected);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FilterButton(
                                                  backgroundColor: AppColors
                                                      .strokeSecondary
                                                      .withValues(
                                                    alpha: 0.08,
                                                  ),
                                                  textColor:
                                                      AppColors.textPrimary,
                                                  text: "Clear all",
                                                  onPressed: () {},
                                                ),
                                                FilterButton(
                                                  text: "Show results",
                                                  onPressed: () {},
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    canDismiss: true,
                                    onDismiss: () {
                                      isPanelVisible.value = false;
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.bgB1Base,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.strokeSecondary,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.filterIcon,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (quickPays.isEmpty)
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.emptyQuickpayIcon,
                                          width: 200,
                                          height: 200,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Text(
                                            'No quickpay activity yet.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Text(
                                        'Your quickpay activity will show up here once you receive one.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else ...[
                            SizedBox(
                              height: 8 * 2.5,
                            ),
                            FilledQuickpay(quickPays: quickPays),
                          ]
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: BrandButton(
                      text: "Receive payment",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isPanelVisible,
            builder: (context, value, _) {
              if (!value) return Container();
              return Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

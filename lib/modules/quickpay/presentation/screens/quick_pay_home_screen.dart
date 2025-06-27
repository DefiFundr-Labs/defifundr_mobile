import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/widgets/custom_back_button.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/filled_quickpay.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/search_and_filter.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/time_filter_radio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickPayHomeScreen extends StatefulWidget {
  const QuickPayHomeScreen({super.key});

  @override
  State<QuickPayHomeScreen> createState() => _QuickPayHomeScreenState();
}

class _QuickPayHomeScreenState extends State<QuickPayHomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<QuickPayment> quickPays = [];

  ValueNotifier<TimeRange?> selectedTimeRange = ValueNotifier<TimeRange?>(null);

  ValueNotifier<Map<QuickPaymentsStatus, bool?>?> statusFilter =
      ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    demoPayment();
  }

  void demoPayment() {
    quickPays.addAll(
      [
        QuickPayment(
          id: '1',
          status: QuickPaymentsStatus.processing,
          date: DateTime.now(),
          amount: BigInt.from(101),
          currency: 'DAI',
          description: 'Neurolytix Initial consultation session',
          paymentType: QuickPaymentsType.deposit,
          network: 'Ethereum',
          imageUrl: AppAssets.ethereumLogo,
          from: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
        QuickPayment(
          id: '2',
          status: QuickPaymentsStatus.successful,
          date: DateTime.now().subtract(const Duration(days: 2)),
          amount: BigInt.from(21),
          currency: 'USDC',
          description: 'MintForge Bug fixes and performance updates',
          paymentType: QuickPaymentsType.withdrawal,
          network: 'Ethereum',
          imageUrl: AppAssets.ethereumLogo,
          to: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
        QuickPayment(
          id: '3',
          status: QuickPaymentsStatus.failed,
          date: DateTime.now().subtract(const Duration(days: 2)),
          amount: BigInt.from(200),
          currency: 'LUSD',
          description: 'ShopLink Pro UX Audit feedback & report',
          paymentType: QuickPaymentsType.deposit,
          network: 'Ethereum',
          imageUrl: AppAssets.ethereumLogo,
          from: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
        QuickPayment(
          id: '4',
          status: QuickPaymentsStatus.successful,
          date: DateTime.now().subtract(const Duration(days: 2)),
          amount: BigInt.from(101),
          currency: 'DAI',
          description: 'Brightfolk Payment for consulting services',
          paymentType: QuickPaymentsType.deposit,
          network: 'Ethereum',
          imageUrl: AppAssets.ethereumLogo,
          from: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
        QuickPayment(
          id: '5',
          status: QuickPaymentsStatus.successful,
          date: DateTime.now().subtract(const Duration(days: 1)),
          amount: BigInt.from(581),
          currency: 'USDT',
          description: 'LoopLabs Transfer for content creation',
          paymentType: QuickPaymentsType.deposit,
          network: 'Ethereum',
          from: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          imageUrl: AppAssets.ethereumLogo,
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
        QuickPayment(
          id: '6',
          status: QuickPaymentsStatus.successful,
          date: DateTime.now().subtract(const Duration(days: 1)),
          amount: BigInt.from(50),
          currency: 'EURt',
          description: 'Paylite Payment for project management',
          paymentType: QuickPaymentsType.deposit,
          network: 'Ethereum',
          imageUrl: AppAssets.ethereumLogo,
          from: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
        QuickPayment(
          id: '7',
          status: QuickPaymentsStatus.successful,
          date: DateTime.now().subtract(const Duration(days: 1)),
          amount: BigInt.from(581),
          currency: 'STARK',
          description: 'Quikdash Reimbursement for software tools',
          paymentType: QuickPaymentsType.deposit,
          from: '0x673D2d7Af5ccd60BA0D72ca222FaE71Ee51D981f',
          network: 'Ethereum',
          imageUrl: AppAssets.ethereumLogo,
          transactionHash:
              '0x969b0164ea9b8d63a71c976607e1e43edf8bc82c59055dc7d9f8e93ab49f239d',
        ),
      ],
    );
  }

  ValueNotifier<bool> isPanelVisible = ValueNotifier(false);

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
                      'Quickpay',
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
                  const SizedBox(height: 12),
                  SearchAndFilterBar(
                      searchController: searchController,
                      isPanelVisible: isPanelVisible,
                      selectedTimeRange: selectedTimeRange,
                      statusFilter: statusFilter),
                  if (quickPays.isEmpty)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                resolveSvg(
                                  context: context,
                                  lightSvg: AppAssets.emptyQuickpayIcon,
                                  darkSvg: AppAssets.emptyQuickpayIconDark,
                                  width: 200,
                                  height: 200,
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Text(
                                    'No quickpay activity yet.',
                                    textAlign: TextAlign.center,
                                    style: context.theme.fonts.textMdSemiBold
                                        .copyWith(
                                            color: context
                                                .theme.colors.textPrimary),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'Your quickpay activity will show up here once you receive one.',
                                textAlign: TextAlign.center,
                                style: context.theme.fonts.textMdRegular
                                    .copyWith(
                                        color:
                                            context.theme.colors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else ...[
                    ValueListenableBuilder(
                      valueListenable: selectedTimeRange,
                      builder: (ctx, selectedTime, __) {
                        return ValueListenableBuilder(
                          valueListenable: statusFilter,
                          builder: (__, filterSelect, _) {
                            final filteredQuickPays =
                                quickPays.where((payment) {
                              final now = DateTime.now();

                              bool passesTimeFilter = true;
                              if (selectedTime != null) {
                                switch (selectedTime) {
                                  case TimeRange.last7Days:
                                    passesTimeFilter = payment.date.isAfter(
                                            now.subtract(
                                                const Duration(days: 7))) &&
                                        payment.date.isBefore(now);
                                    break;
                                  case TimeRange.last30Days:
                                    passesTimeFilter = payment.date.isAfter(
                                            now.subtract(
                                                const Duration(days: 30))) &&
                                        payment.date.isBefore(now);
                                    break;
                                  default:
                                    passesTimeFilter = true;
                                }
                              }

                              bool passesStatusFilter = true;
                              if (filterSelect != null) {
                                passesStatusFilter = filterSelect.entries
                                    .where((entry) => entry.value == true)
                                    .any(
                                        (entry) => payment.status == entry.key);
                              }

                              return passesTimeFilter && passesStatusFilter;
                            }).toList();
                            return FilledQuickpay(
                              quickPays: filteredQuickPays,
                            );
                          },
                        );
                      },
                    ),
                  ]
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: BrandButton(
              text: "Receive payment",
              onPressed: () {
                context.pushNamed(RouteConstants.receivePaymentScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}

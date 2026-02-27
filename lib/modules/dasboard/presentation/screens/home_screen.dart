import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/account_setup_banner.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_balance_card.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_contracts_section.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_header.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_payment_section.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_quick_actions.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/upcoming_payment_item_card.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String _userName = 'Adebisi Adeyemi';
  static const bool _isOnboardingComplete = false;
  static const double _onboardingProgress = 0.20;
  static const double _totalBalance = 5050.00;
  static const double _changePercent = -0.0051;
  static const double _changeAmount = 0.99;
  List<ContractItem> get _contracts => const [

        ContractItem(
          initials: 'QM',
          title: 'Quikdash Mobile & Web App Redesign',
          subtitle: 'Milestone Contract',
          amount: '581 STRK',
          status: 'Pending',
        ),
        ContractItem(
          initials: 'DM',
          title: 'DefiFundr Mobile & Web App Redesign',
          subtitle: 'Fixed Rate Contract',
          amount: '581 USDT',
          status: 'Active',
        ),
      ];
  List<Payment> _getTransactions(AppColorExtension colors) => [
        Payment(
          title: 'Withdrawal',
          paymentType: PaymentType.contract,
          estimatedDate: DateTime(2025, 5, 21, 18, 30),
          amount: 581,
          paymentNetwork: PaymentNetwork.ethereum,
          currency: 'USDT',
          status: PaymentStatus.successful,
          icon: Assets.icons.invoice,
          iconBackgroundColor: colors.orangeDefault,
        ),
        Payment(
          title: 'MintForge Bug fixes and performance updates',
          paymentType: PaymentType.invoice,
          estimatedDate: DateTime(2025, 5, 21, 13, 22),
          amount: 21,
          paymentNetwork: PaymentNetwork.starknet,
          currency: 'USDC',
          status: PaymentStatus.failed,
          icon: Assets.icons.money,
          iconBackgroundColor: colors.brandDefault,
        ),
      ];
  List<Payment> _getUpcomingPayments(AppColorExtension colors) => [
        Payment(
          title: 'Brightfolk Payment for consulting',
          paymentType: PaymentType.invoice,
          estimatedDate: DateTime(2025, 4, 20),
          amount: 50,
          paymentNetwork: PaymentNetwork.ethereum,
          currency: 'EURt',
          status: PaymentStatus.overdue,
          icon: Assets.icons.money,
          iconBackgroundColor: const Color(0xFFE53E3E),
        ),
        Payment(
          title: 'MintForge Bug fixes and updates',
          paymentType: PaymentType.invoice,
          estimatedDate: DateTime(2025, 4, 20),
          amount: 581,
          paymentNetwork: PaymentNetwork.solana,
          currency: 'USDT',
          status: PaymentStatus.overdue,
          icon: Assets.icons.money,
          iconBackgroundColor: const Color(0xFFE53E3E),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final transactions = _getTransactions(colors);
    final upcomingPayments = _getUpcomingPayments(colors);

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(userName: _userName),
              SizedBox(height: 16.h),
              HomeBalanceCard(
                totalBalance: _totalBalance,
                changePercent: _changePercent,
                changeAmount: _changeAmount,
                onTap: () => context.tabsRouter.setActiveIndex(2),
              ),
              if (!_isOnboardingComplete) ...[
                SizedBox(height: 24.h),
                const AccountSetupBanner(progress: _onboardingProgress),
              ],
              SizedBox(height: 24.h),
              const HomeQuickActions(),
              SizedBox(height: 24.h),
              HomeContractsSection(
                contracts: _contracts,
                hasData: _contracts.isNotEmpty,
              ),
              SizedBox(height: 24.h),
              HomePaymentSection(
                title: 'Transactions',
                emptyMessage: 'Transactions will appear here',
                payments: transactions,
                hasData: transactions.isNotEmpty,
              ),
              SizedBox(height: 24.h),
              HomePaymentSection(
                title: 'Upcoming payments',
                emptyMessage: 'Upcoming payments will appear here',
                payments: upcomingPayments,
                hasData: upcomingPayments.isNotEmpty,
                itemBuilder: (context, payment) =>
                    UpcomingPaymentItemCard(payment: payment),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

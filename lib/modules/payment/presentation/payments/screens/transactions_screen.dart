import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';

@RoutePage()
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  static final List<Payment> mockTransactions = [
    Payment(
      title: 'Withdrawal',
      paymentType: PaymentType.invoice,
      estimatedDate: DateTime(2025, 4, 21, 18, 30),
      amount: -581,
      paymentNetwork: PaymentNetwork.ethereum,
      currency: 'USDT',
      status: PaymentStatus.processing,
      icon: Assets.icons.wallet,
      iconBackgroundColor: const Color(0xFF2B6CB0), // Blue
    ),
    Payment(
      title: 'ShopLink Pro UX Audit...',
      paymentType: PaymentType.contract,
      estimatedDate: DateTime(2025, 4, 21, 13, 22),
      amount: 581,
      paymentNetwork: PaymentNetwork.starknet,
      currency: 'USDT',
      status: PaymentStatus.successful,
      icon: Assets.icons.money,
      iconBackgroundColor: const Color(0xFFD53F8C), // Pink
    ),
    Payment(
      title: 'Neurolytix Initial cons...',
      paymentType: PaymentType.contract,
      estimatedDate: DateTime(2025, 4, 21, 9, 5),
      amount: 581,
      paymentNetwork: PaymentNetwork.solana,
      currency: 'USDT',
      status: PaymentStatus.successful,
      icon: Assets.icons.invoice,
      iconBackgroundColor: const Color(0xFFDD6B20), // Orange
    ),
    Payment(
      title: 'MintForge Bug fixes a...',
      paymentType: PaymentType.contract,
      estimatedDate: DateTime(2025, 4, 21, 17, 55),
      amount: 581,
      paymentNetwork: PaymentNetwork.ethereum,
      currency: 'USDT',
      status: PaymentStatus.successful,
      icon: Assets.icons.moneyCopy,
      iconBackgroundColor: const Color(0xFF805AD5), // Purple
    ),
    Payment(
      title: 'Brightfolk Payment fo...',
      paymentType: PaymentType.invoice,
      estimatedDate: DateTime(2025, 4, 21, 12, 10),
      amount: 581,
      paymentNetwork: PaymentNetwork.solana,
      currency: 'USDT',
      status: PaymentStatus.failed,
      icon: Assets.icons.receipt,
      iconBackgroundColor: const Color(0xFFD53F8C), // Pink
    ),
    Payment(
      title: 'LoopLabs Transfer fo...',
      paymentType: PaymentType.contract,
      estimatedDate: DateTime(2025, 4, 21, 8, 15),
      amount: 581,
      paymentNetwork: PaymentNetwork.starknet,
      currency: 'USDT',
      status: PaymentStatus.processing,
      icon: Assets.icons.invoiceCopy,
      iconBackgroundColor: const Color(0xFFDD6B20), // Orange
    ),
    Payment(
      title: 'Quikdash Reimburse...',
      paymentType: PaymentType.invoice,
      estimatedDate: DateTime(2025, 4, 19, 18, 30),
      amount: 581,
      paymentNetwork: PaymentNetwork.ethereum,
      currency: 'USDT',
      status: PaymentStatus.successful,
      icon: Assets.icons.money,
      iconBackgroundColor: const Color(0xFF805AD5), // Purple
    ),
    Payment(
      title: 'Paylite Payment for pr...',
      paymentType: PaymentType.invoice,
      estimatedDate: DateTime(2025, 4, 19, 13, 22),
      amount: 581,
      paymentNetwork: PaymentNetwork.solana,
      currency: 'USDT',
      status: PaymentStatus.failed,
      icon: Assets.icons.files,
      iconBackgroundColor: const Color(0xFFD53F8C), // Pink
    ),
    Payment(
      title: 'NovaWorks UI/UX De...',
      paymentType: PaymentType.contract,
      estimatedDate: DateTime(2025, 4, 19, 9, 5),
      amount: 581,
      paymentNetwork: PaymentNetwork.starknet,
      currency: 'USDT',
      status: PaymentStatus.processing,
      icon: Assets.icons.invoice,
      iconBackgroundColor: const Color(0xFFDD6B20), // Orange
    ),
  ];

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Map<String, List<Payment>> _groupTransactionsByDate(List<Payment> payments) {
    final Map<String, List<Payment>> grouped = {};
    for (var payment in payments) {
      final dateStr = DateFormat('dd MMMM yyyy').format(payment.estimatedDate);
      if (!grouped.containsKey(dateStr)) {
        grouped[dateStr] = [];
      }
      grouped[dateStr]!.add(payment);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: DeFiRaiseAppBar(
        title: 'Transactions',
        textStyle: context.theme.fonts.heading3SemiBold.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
        isBack: true,
        actions: [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: SearchAndFilterBar(
                searchController: _searchController,
                onFilterTap: () {
                  // TO DO: Implement actual filter sheet if applicable
                },
              ),
            ),
            Expanded(
              child: TransactionsScreen.mockTransactions.isNotEmpty
                  ? _buildFilledState(context)
                  : _buildEmptyState(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.icons.emptyState,
                    width: 200,
                    height: 200,
                  ),
                  Text(
                    'No transactions yet',
                    style: fonts.textMdSemiBold.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    'Transactions will appear here as you use the platform.',
                    textAlign: TextAlign.center,
                    style: fonts.textMdRegular.copyWith(
                      color: colors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilledState(BuildContext context) {
    final groupedTransactions =
        _groupTransactionsByDate(TransactionsScreen.mockTransactions);

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12),
      itemCount: groupedTransactions.length,
      itemBuilder: (context, index) {
        final dateStr = groupedTransactions.keys.elementAt(index);
        final payments = groupedTransactions[dateStr]!;

        return _buildDateGroup(dateStr, payments, context);
      },
    );
  }

  Widget _buildDateGroup(
      String dateStr, List<Payment> payments, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0 * 1.5),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: resolveColor(
                    context: context,
                    lightColor:
                        AppColors.strokeSecondary.withValues(alpha: 0.12),
                    darkColor:
                        AppColorDark.strokeSecondary.withValues(alpha: 0.32),
                  ),
                ),
              ),
              Text(dateStr,
                  style: context.theme.fonts.textSmMedium
                      .copyWith(color: context.theme.colors.textTertiary)),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: resolveColor(
                    context: context,
                    lightColor:
                        AppColors.strokeSecondary.withValues(alpha: 0.12),
                    darkColor:
                        AppColorDark.strokeSecondary.withValues(alpha: 0.32),
                  ),
                ),
              ),
            ],
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: resolveColor(
            context: context,
            lightColor: AppColors.bgB1Base,
            darkColor: AppColorDark.bgB1Base,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: payments
                  .map((payment) => _buildTransactionItem(payment, context))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(Payment payment, BuildContext context) {
    Color statusColor;
    String statusLabel;
    switch (payment.status) {
      case PaymentStatus.processing:
        statusColor = resolveColor(
            context: context,
            lightColor: AppColors.orangeDefault,
            darkColor: AppColorDark.orangeDefault);
        statusLabel = 'Processing';
        break;
      case PaymentStatus.successful:
        statusColor = resolveColor(
            context: context,
            lightColor: AppColors.greenActive,
            darkColor: AppColorDark.greenActive);
        statusLabel = 'Successful';
        break;
      case PaymentStatus.failed:
        statusColor = resolveColor(
            context: context,
            lightColor: AppColors.redActive,
            darkColor: AppColorDark.redActive);
        statusLabel = 'Failed';
        break;
      default:
        statusColor = resolveColor(
            context: context,
            lightColor: AppColors.textSecondary,
            darkColor: AppColorDark.textSecondary);
        statusLabel = payment.status.name;
    }

    Color badgeColor;
    String badgeIcon;
    switch (payment.status) {
      case PaymentStatus.upcoming:
        badgeColor = resolveColor(
            context: context,
            lightColor: AppColors.greenDefault,
            darkColor: AppColorDark.greenDefault);
        badgeIcon = Assets.icons.arrowDownLeft;
        break;
      case PaymentStatus.overdue:
        badgeColor = resolveColor(
            context: context,
            lightColor: AppColors.redDefault,
            darkColor: AppColorDark.redDefault);
        badgeIcon = Assets.icons.arrowUp;
        break;
      case PaymentStatus.pending:
      case PaymentStatus.processing:
        badgeColor = resolveColor(
            context: context,
            lightColor: AppColors.orangeDefault,
            darkColor: AppColorDark.orangeDefault);
        badgeIcon = Assets.icons.arrowClockwise;
        break;
      case PaymentStatus.successful:
        badgeColor = resolveColor(
            context: context,
            lightColor: AppColors.greenActive,
            darkColor: AppColorDark.greenActive);
        badgeIcon = Assets.icons.arrowDownLeft;
        break;
      case PaymentStatus.failed:
        badgeColor = resolveColor(
            context: context,
            lightColor: AppColors.redActive,
            darkColor: AppColorDark.redActive);
        badgeIcon = Assets.icons.arrowUp;
        break;
    }

    final formattedAmount =
        '${payment.amount < 0 ? '-' : '+'}${payment.amount.abs().toStringAsFixed(0)} ${payment.currency}';

    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          context.router.push(
            TransactionRoute(args: payment.toQuickPayment()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: payment.iconBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          payment.icon,
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          border: Border.all(
                            color: resolveColor(
                              context: context,
                              lightColor: AppColors.bgB0Base,
                              darkColor: AppColorDark.bgB0Base,
                            ),
                            width: 1.0,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          badgeIcon,
                          width: 8,
                          height: 8,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ellipsify(word: payment.title, maxLength: 18),
                      style: context.theme.fonts.textMdSemiBold,
                    ),
                    const SizedBox(height: 4),
                    Text(DateFormat('h:mm a').format(payment.estimatedDate),
                        style: context.theme.fonts.textSmRegular.copyWith(
                            color: context.theme.colors.textSecondary)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(formattedAmount,
                    style: context.theme.fonts.textMdSemiBold),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 6,
                      color: statusColor,
                    ),
                    const SizedBox(width: 4),
                    Text(statusLabel,
                        style: context.theme.fonts.textSmMedium
                            .copyWith(color: statusColor)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

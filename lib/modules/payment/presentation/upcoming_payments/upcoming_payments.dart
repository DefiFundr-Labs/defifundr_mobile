import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:defifundr_mobile/core/shared/components/search_and_filter_bar.dart';
import 'package:defifundr_mobile/modules/payment/presentation/upcoming_payments/invoice.dart';

@RoutePage()
class UpcomingPaymentsScreen extends StatefulWidget {
  const UpcomingPaymentsScreen({Key? key}) : super(key: key);

  @override
  _UpcomingPaymentsScreenState createState() => _UpcomingPaymentsScreenState();
}

class _UpcomingPaymentsScreenState extends State<UpcomingPaymentsScreen> {
  List<Payment> _allPayments = [];
  List<Payment> _filteredPayments = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _applyFilters();
    });
  }

  List<Payment> _createDummyPayments(BuildContext context) {
    final colors = context.theme.colors;
    return [
      Payment(
        title: 'Neurolytix Initial consul...',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2026, 4, 30),
        amount: 256,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: Assets.icons.invoice,
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'MintForge Bug fixes an...',
        paymentType: PaymentType.invoice,
        paymentNetwork: PaymentNetwork.starknet,
        estimatedDate: DateTime(2026, 4, 25),
        amount: 65,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: Assets.icons.money,
        iconBackgroundColor: colors.blueDefault,
      ),
      Payment(
        title: 'ShopLink Pro UX Audit f...',
        paymentType: PaymentType.contract,
        paymentNetwork: PaymentNetwork.solana,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 72,
        currency: 'USDT',
        status: PaymentStatus.overdue,
        icon: Assets.icons.invoiceCopy,
        iconBackgroundColor: colors.orangeDefault,
      ),
      Payment(
        title: 'Brightfolk Payment for c...',
        paymentType: PaymentType.invoice,
        paymentNetwork: PaymentNetwork.ethereum,
        estimatedDate: DateTime(2025, 4, 20),
        amount: 50,
        currency: 'EURt',
        status: PaymentStatus.overdue,
        icon: Assets.icons.receipt,
        iconBackgroundColor: colors.pinkDefault,
      ),
      Payment(
        title: 'Quikdash Reimbursement',
        paymentType: PaymentType.invoice,
        estimatedDate: DateTime(2026, 3, 15),
        amount: 120,
        paymentNetwork: PaymentNetwork.ethereum,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: Assets.icons.wallet,
        iconBackgroundColor: colors.blueDefault,
      ),
      Payment(
        title: 'LoopLabs Transfer for design',
        paymentType: PaymentType.contract,
        estimatedDate: DateTime(2025, 4, 15),
        amount: 450,
        paymentNetwork: PaymentNetwork.starknet,
        currency: 'USDT',
        status: PaymentStatus.upcoming,
        icon: Assets.icons.invoiceCopy,
        iconBackgroundColor: colors.brandDefault,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_allPayments.isEmpty) {
      _allPayments = _createDummyPayments(context);
      _applyFilters();
    }

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: DeFiRaiseAppBar(
        title: 'Upcoming payments',
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
                onFilterTap: () {},
              ),
            ),
            Expanded(
              child: _filteredPayments.isNotEmpty
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
                    'No upcoming payments',
                    style: fonts.textMdSemiBold.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    'Once payments are scheduled, you’ll see them here.',
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
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12),
      itemCount: _filteredPayments.length,
      itemBuilder: (context, index) {
        return _buildPaymentItem(_filteredPayments[index], context);
      },
    );
  }

  Widget _buildPaymentItem(Payment payment, BuildContext context) {
    final colors = context.theme.colors;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final estDate = DateTime(
      payment.estimatedDate.year,
      payment.estimatedDate.month,
      payment.estimatedDate.day,
    );
    final daysUntil = estDate.difference(today).inDays;

    final bool isOverdue =
        payment.status == PaymentStatus.overdue || daysUntil < 0;

    Color statusColor;
    String statusLabel;
    if (isOverdue) {
      statusColor = colors.orangeDefault;
      statusLabel = 'Overdue';
    } else {
      statusColor = colors.blueHover;
      statusLabel = 'In $daysUntil day${daysUntil == 1 ? '' : 's'}';
    }

    Color badgeColor;
    String badgeIcon;
    if (isOverdue) {
      badgeColor = colors.orangeDefault;
      badgeIcon = Assets.icons.arrowUp;
    } else {
      badgeColor = colors.blueHover;
      badgeIcon = Assets.icons.arrowClockwise;
    }

    final formattedAmount =
        '${payment.amount.abs().toStringAsFixed(0)} ${payment.currency}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => InvoiceScreen(payment: payment),
            ),
          );
        },
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: colors.bgB0,
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                                color: colors.bgB0,
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
                        Text(
                          'Est. date: ${DateFormat('dd MMMM yyyy').format(payment.estimatedDate)}',
                          style: context.theme.fonts.textSmRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
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
        ),
      ),
    );
  }

  void _applyFilters() {
    final searchQuery = _searchController.text.toLowerCase();
    _filteredPayments = _allPayments.where((payment) {
      final titleMatch = payment.title.toLowerCase().contains(searchQuery);
      final typeMatch =
          payment.paymentType.name.toLowerCase().contains(searchQuery);
      final networkMatch =
          payment.paymentNetwork.name.toLowerCase().contains(searchQuery);
      final currencyMatch =
          payment.currency.toLowerCase().contains(searchQuery);
      final statusSearchMatch =
          payment.status.name.toLowerCase().contains(searchQuery);

      final searchMatch = titleMatch ||
          typeMatch ||
          networkMatch ||
          currencyMatch ||
          statusSearchMatch;

      return searchMatch;
    }).toList();
  }
}

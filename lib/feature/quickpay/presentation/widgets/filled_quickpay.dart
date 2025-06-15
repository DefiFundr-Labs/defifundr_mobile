import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/feature/quickpay/presentation/class/quick_payments.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class FilledQuickpay extends StatefulWidget {
  final List<QuickPayment> quickPays;
  const FilledQuickpay({super.key, this.quickPays = const []});

  @override
  State<FilledQuickpay> createState() => _FilledQuickpayState();
}

class _FilledQuickpayState extends State<FilledQuickpay> {
  Map<String, List<QuickPayment>> groupPaymentsByDate(
      List<QuickPayment> payments) {
    payments.sort((a, b) => b.date.compareTo(a.date)); // Sort descending

    Map<String, List<QuickPayment>> grouped = {};

    for (var payment in payments) {
      final dayKey =
          DateUtils.dateOnly(payment.date).toIso8601String(); // "YYYY-MM-DD"
      grouped.putIfAbsent(dayKey, () => []).add(payment);
    }

    return grouped;
  }

  String formatDayLabel(DateTime date) {
    final now = DateTime.now();
    const allowString = false;
    final today = DateUtils.dateOnly(now);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateUtils.dateOnly(date);

    // ignore: dead_code
    if (dateOnly == today && allowString) return 'Today';
    // ignore: dead_code
    if (dateOnly == yesterday && allowString) return 'Yesterday';

    return DateFormat('d MMMM y').format(date); // e.g. 21 April 2025
  }

  @override
  Widget build(BuildContext context) {
    final groupedPayments = groupPaymentsByDate(widget.quickPays);
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: groupedPayments.entries.map((entry) {
        final date = DateTime.parse(entry.key);
        final label = formatDayLabel(date);

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
                        darkColor: AppColorDark.strokeSecondary
                            .withValues(alpha: 0.32),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: resolveColor(
                        context: context,
                        lightColor:
                            AppColors.strokeSecondary.withValues(alpha: 0.12),
                        darkColor: AppColorDark.strokeSecondary
                            .withValues(alpha: 0.32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PaymentTile(entry.value),
          ],
        );
      }).toList(),
    );
  }
}

class PaymentTile extends StatelessWidget {
  final List<QuickPayment> payments;

  const PaymentTile(this.payments, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
          children: payments.map((payment) {
            return Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(
                    RouteConstants.transactionScreen,
                    extra: payment,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppAssets.depositIconSvg),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ellipsify(
                                  word: payment.description, maxLength: 18),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: resolveColor(
                                  context: context,
                                  lightColor: AppColors.textPrimary,
                                  darkColor: AppColorDark.textPrimary,
                                ),
                                fontFamily: 'Inter',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('h:mm a').format(payment.date),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: resolveColor(
                                  context: context,
                                  lightColor: AppColors.textSecondary,
                                  darkColor: AppColorDark.textSecondary,
                                ),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Right side: Amount + Status
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${payment.paymentType == QuickPaymentsType.deposit ? '+' : '-'}${payment.amount} ${payment.currency}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: resolveColor(
                              context: context,
                              lightColor: AppColors.textPrimary,
                              darkColor: AppColorDark.textPrimary,
                            ),
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 6,
                              color: payment.status.textColor(context),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              payment.status.titleCase,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: payment.status.textColor(context),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

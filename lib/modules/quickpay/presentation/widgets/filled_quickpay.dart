import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    if (dateOnly == today && allowString) return 'Today';

    if (dateOnly == yesterday && allowString) return 'Yesterday';

    return DateFormat('d MMMM y').format(date);
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
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                        thickness: 1,
                        color: context.theme.colors.strokeSecondary
                            .withOpacity(0.12)),
                  ),
                  const SizedBox(width: 8),
                  Text(label,
                      style: context.theme.fonts.textSmMedium
                          .copyWith(color: context.theme.colors.textTertiary)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Divider(
                        thickness: 1,
                        color: context.theme.colors.strokeSecondary
                            .withOpacity(0.12)),
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

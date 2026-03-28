import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import '../../../data/models/contract.dart';
import '../widgets/status_chip.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class PayoutDetailScreen extends StatelessWidget {
  final Payout payout;

  const PayoutDetailScreen({
    Key? key,
    required this.payout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.bgB0,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Payout details',
          actions: const [],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB1,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                        context,
                        'Status',
                        Align(
                            alignment: Alignment.centerRight,
                            child: StatusChip(status: payout.status))),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Time period',
                      _buildValueText(context,
                          'For ${payout.startDate.dayMonth} - ${payout.endDate.dayMonthYear}'),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Type',
                      _buildValueText(context, 'Monthly Payment'),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Submission date',
                      _buildValueText(
                          context, payout.submissionDate.dayMonthYear),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Due date',
                      _buildValueText(context, payout.dueDate.dayMonthYear),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Amount',
                      Text(
                        '${payout.amount.toInt()} ${payout.currency}',
                        textAlign: TextAlign.right,
                        style: context.theme.fonts.textMdSemiBold.copyWith(
                          color: context.theme.colors.textPrimary,
                        ),
                      ),
                    ),
                    if (payout.invoiceNumber.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildDetailRow(
                        context,
                        'Invoice',
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              payout.invoiceNumber,
                              style: context.theme.fonts.textMdMedium
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.open_in_new,
                              size: 16,
                              color: context.theme.colors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB1,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      context,
                      'Contract',
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              ellipsify(
                                  word: payout.contractTitle, maxLength: 19),
                              textAlign: TextAlign.right,
                              style: context.theme.fonts.textMdMedium.copyWith(
                                color: context.theme.colors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: context.theme.colors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Contract Type',
                      _buildValueText(context, 'Fixed Rate'),
                    ),
                    const SizedBox(height: 24),
                    _buildDetailRow(
                      context,
                      'Client',
                      _buildValueText(context, payout.clientName),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueText(BuildContext context, String text) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: context.theme.fonts.textMdMedium.copyWith(
        color: context.theme.colors.textPrimary,
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, Widget value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: value,
        ),
      ],
    );
  }
}

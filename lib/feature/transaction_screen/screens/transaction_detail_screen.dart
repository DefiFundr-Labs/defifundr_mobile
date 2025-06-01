import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/feature/transaction_screen/models/transaction_model.dart';
import 'package:defifundr_mobile/feature/transaction_screen/widgets/transaction_detail_sheet.dart';
import 'package:defifundr_mobile/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/design_system/app_colors/app_colors.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for invoice breakdown and timeline

    final timeline = [
      TimelineStep(
        title: 'Invoice created and sent to client',
        time: DateTime(2025, 4, 20, 16, 40),
        completed: true,
      ),
      TimelineStep(
        title: 'Client payment confirmed',
        time: DateTime(2025, 4, 20, 20, 40),
        completed: true,
      ),
      TimelineStep(
        title: 'Client payment processed',
        time: DateTime(2025, 4, 20, 20, 45),
        completed: true,
      ),
      TimelineStep(
        title: 'Funds received in your account',
        time: DateTime(2025, 4, 20, 20, 45),
        completed: true,
      ),
    ];

    Widget? detailsChild;
    Widget? contractChild;
    Widget? timelineChild;

    switch (transaction.type) {
      case TransactionType.invoice:
        detailsChild = _buildInvoiceDetails(context);
        timelineChild = _timelineBreakdown(context, timeline);
        break;
      case TransactionType.contract:
        detailsChild = _buildContractDetails(context);
        contractChild = _buildContractContent(context);
        timelineChild = _timelineBreakdown(context, timeline);
        break;
      case TransactionType.withdrawal:
        detailsChild = _buildWithdrawalDetails(context);
        break;
      case TransactionType.quickpay:
        detailsChild = _buildQuickpayDetails(context);
        break;
    }

    return TransactionDetailSheet(
      transaction: transaction,
      transactionIcon: _getTransactionIcon(transaction.type),
      fiatValue: 476.19,
      onHelp: () {},
      onShareReceipt: () {},
      contractContent: contractChild,
      timelineContent: timelineChild,
      child: detailsChild,
    );
  }

  String _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.withdrawal:
        return AppIcons.currencyCircleDollar;
      case TransactionType.contract:
        return AppIcons.money;
      case TransactionType.invoice:
        return AppIcons.invoice;
      case TransactionType.quickpay:
        return AppIcons.handCoin;
    }
  }

  Widget _buildInvoiceDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow('Status', _statusChip(context, transaction.status), context),
        SizedBox(height: 16),
        _detailRow('Network', _networkRow(context), context),
        SizedBox(height: 16),
        _detailRow(
            'From',
            Text(transaction.fromAddress ?? '',
                style: Theme.of(context).textTheme.bodySmall),
            context),
        SizedBox(height: 16),
        _detailRow(
            'Transaction ID',
            _transactionIdRow(context, transaction.transactionId ?? ''),
            context),
        SizedBox(height: 16),
        _detailRow(
            'Date',
            Text(
                DateFormat('d MMMM y, HH:mm')
                    .format(transaction.date ?? transaction.timestamp),
                style: Theme.of(context).textTheme.bodySmall),
            context),
      ],
    );
  }

  Widget _buildContractDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow('Status', _statusChip(context, transaction.status), context),
        SizedBox(height: 16),
        _detailRow(
          'Network',
          Row(
            children: [
              Icon(Icons.language,
                  color: context.theme.colors.blueDefault, size: 20),
              SizedBox(width: 8),
              Text(transaction.network ?? '',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'From',
          Text(transaction.fromAddress ?? '',
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Transaction ID',
          Row(
            children: [
              Text(transaction.transactionId ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.underline)),
              SizedBox(width: 8),
              Icon(Icons.copy, size: 18),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Date',
          Text(
              DateFormat('d MMMM y, HH:mm')
                  .format(transaction.date ?? transaction.timestamp),
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
      ],
    );
  }

  Widget _buildWithdrawalDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow('Status', _statusChip(context, transaction.status), context),
        SizedBox(height: 16),
        _detailRow(
          'Network',
          Row(
            children: [
              Icon(Icons.language,
                  color: context.theme.colors.blueDefault, size: 20),
              SizedBox(width: 8),
              Text(transaction.network ?? '',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'To',
          Text(transaction.withdrawalAddress ?? '',
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Transaction ID',
          Row(
            children: [
              Text(transaction.transactionId ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.underline)),
              SizedBox(width: 8),
              Icon(Icons.copy, size: 18),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Date',
          Text(
              DateFormat('d MMMM y, HH:mm')
                  .format(transaction.date ?? transaction.timestamp),
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
      ],
    );
  }

  Widget _buildQuickpayDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow('Status', _statusChip(context, transaction.status), context),
        SizedBox(height: 16),
        _detailRow(
          'Network',
          Row(
            children: [
              Icon(Icons.language,
                  color: context.theme.colors.blueDefault, size: 20),
              SizedBox(width: 8),
              Text(transaction.network ?? '',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'To',
          Text(transaction.recipient ?? '',
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Transaction ID',
          Row(
            children: [
              Text(transaction.transactionId ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(decoration: TextDecoration.underline)),
              SizedBox(width: 8),
              Icon(Icons.copy, size: 18),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Date',
          Text(
              DateFormat('d MMMM y, HH:mm')
                  .format(transaction.date ?? transaction.timestamp),
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
      ],
    );
  }

  Widget _buildContractContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailRow(
          'Contract',
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .4,
                child: Text(transaction.contractName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              SizedBox(width: 4),
              Icon(Icons.open_in_new,
                  size: 16, color: context.theme.colors.grayTertiary),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Contract type',
          Text(transaction.contractType ?? '',
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Invoice',
          Row(
            children: [
              Text(transaction.invoiceNumber ?? '',
                  style: Theme.of(context).textTheme.bodySmall),
              SizedBox(width: 4),
              Icon(Icons.open_in_new,
                  size: 16, color: context.theme.colors.grayTertiary),
            ],
          ),
          context,
        ),
        SizedBox(height: 16),
        _detailRow(
          'Client',
          Text(transaction.client ?? '',
              style: Theme.of(context).textTheme.bodySmall),
          context,
        ),
      ],
    );
  }

  Widget _detailRow(String label, Widget value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 110,
          child: Text(label, style: context.textTheme.bodySmall),
        ),
        SizedBox(child: value),
      ],
    );
  }

  Widget _statusChip(BuildContext context, TransactionStatus status) {
    Color color;
    String text;
    switch (status) {
      case TransactionStatus.processing:
        color = AppColors.orangeActive;
        text = 'Processing';
        break;
      case TransactionStatus.successful:
        color = AppColors.greenActive;
        text = 'Successful';
        break;
      case TransactionStatus.failed:
        color = AppColors.redActive;
        text = 'Failed';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(12)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _networkRow(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.language, color: Colors.blue, size: 20),
        SizedBox(width: 8),
        Text(transaction.network ?? '',
            style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _transactionIdRow(BuildContext context, String id) {
    return Row(
      children: [
        Text(id,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(decoration: TextDecoration.underline)),
        SizedBox(width: 8),
        Icon(Icons.copy, size: 18),
      ],
    );
  }

  Widget _timelineBreakdown(BuildContext context, List<TimelineStep> steps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.map((step) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(Icons.check_circle,
                      color: context.theme.colors.greenActive, size: 20),
                  if (step != steps.last)
                    Container(
                      width: 2,
                      height: 32,
                      color: context.theme.colors.greenActive,
                    ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(step.title,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(DateFormat('d MMMM y, HH:mm').format(step.time),
                        style: Theme.of(context).textTheme.labelMedium),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class InvoiceItem {
  final String name;
  final String amount;
  final String details;
  InvoiceItem(
      {required this.name, required this.amount, required this.details});
}

class TimelineStep {
  final String title;
  final DateTime time;
  final bool completed;
  TimelineStep(
      {required this.title, required this.time, this.completed = false});
}

class _InvoiceAmountExpansion extends StatefulWidget {
  final String amount;
  final List<InvoiceItem> items;
  const _InvoiceAmountExpansion({required this.amount, required this.items});

  @override
  State<_InvoiceAmountExpansion> createState() =>
      _InvoiceAmountExpansionState();
}

class _InvoiceAmountExpansionState extends State<_InvoiceAmountExpansion> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => expanded = !expanded),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total amount',
                style: context.textTheme.bodySmall,
              ),
              Row(
                children: [
                  Text(widget.amount,
                      style: Theme.of(context).textTheme.bodySmall),
                  Icon(expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                ],
              ),
            ],
          ),
        ),
        if (expanded)
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.grayTertiary.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.name,
                                style: Theme.of(context).textTheme.titleMedium),
                            Column(
                              children: [
                                Text(item.amount,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text(item.details,
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}

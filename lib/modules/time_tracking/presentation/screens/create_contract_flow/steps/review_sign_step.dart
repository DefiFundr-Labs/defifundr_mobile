import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/milestone.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/agreement_file_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_row.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/work_scope_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewSignStep extends StatefulWidget {
  final Map<String, dynamic> data;
  final Function(int) onEdit;
  final VoidCallback onNext;

  const ReviewSignStep({
    Key? key,
    required this.data,
    required this.onEdit,
    required this.onNext,
  }) : super(key: key);

  @override
  State<ReviewSignStep> createState() => _ReviewSignStepState();
}

class _ReviewSignStepState extends State<ReviewSignStep> {
  bool _workScopeExpanded = false;

  Map<String, dynamic> get _data => widget.data;

  @override
  Widget build(BuildContext context) {
    final String contractType = _data['type'] ?? '';
    final bool isMilestone = contractType == 'Milestone';
    final bool isPayAsYouGo = contractType == 'Pay As You Go';

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                ReviewCard(
                  title: 'Contract details',
                  onEdit: () => widget.onEdit(1),
                  child: Column(
                    children: [
                      ReviewRow(label: 'Title', value: _data['title'] ?? '-'),
                      ReviewRow(label: 'Type', value: _data['type'] ?? '-'),
                      ReviewRow(
                          label: 'Job Role', value: _data['jobRole'] ?? '-'),
                      WorkScopeRow(
                        value: _data['workScope'] ?? '-',
                        expanded: _workScopeExpanded,
                        onToggle: () => setState(
                            () => _workScopeExpanded = !_workScopeExpanded),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                ReviewCard(
                  title: 'Client details',
                  onEdit: () => widget.onEdit(2),
                  child: Column(
                    children: [
                      ReviewRow(
                          label: 'Name', value: _data['clientName'] ?? '-'),
                      ReviewRow(
                          label: 'Email', value: _data['clientEmail'] ?? '-'),
                      ReviewRow(
                          label: 'Phone no',
                          value: _data['clientPhone'] ?? '-'),
                      ReviewRow(
                          label: 'Country',
                          value: _data['clientCountry'] ?? '-',
                          icon: _data['clientCountryIcon']),
                      ReviewRow(
                          label: 'Address',
                          value: _data['clientAddress'] ?? '-'),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                ReviewCard(
                  title: 'Contract dates',
                  onEdit: () => widget.onEdit(3),
                  child: Column(
                    children: [
                      ReviewRow(
                          label: 'Creation Date',
                          value: _data['creationDate'] ?? '-'),
                      ReviewRow(
                          label: 'Start Date',
                          value: _data['startDate'] ?? '-'),
                      ReviewRow(
                          label: 'End Date', value: _data['endDate'] ?? '-'),
                      ReviewRow(
                          label: 'Termination notice period',
                          value: '${_data['noticePeriod'] ?? '-'} days'),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                if (isMilestone)
                  _MilestonePaymentCard(data: _data, onEdit: widget.onEdit)
                else if (isPayAsYouGo)
                  _PayAsYouGoPaymentCard(data: _data, onEdit: widget.onEdit)
                else
                  _FixedRatePaymentCard(data: _data, onEdit: widget.onEdit),
                SizedBox(height: 16.h),
                ReviewCard(
                  title: 'Compliance',
                  onEdit: () => widget.onEdit(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReviewRow(
                          label: 'Agreement',
                          value: '${_data['agreementType']} agreement'),
                      SizedBox(height: 12.h),
                      const AgreementFileCard(),
                      SizedBox(height: 16.h),
                      Text('Additional terms',
                          style: context.theme.fonts.textMdRegular.copyWith(
                              color: context.theme.colors.textSecondary)),
                      SizedBox(height: 6.h),
                      Text(
                        _data['additionalTerms']?.isEmpty ?? true
                            ? 'None'
                            : _data['additionalTerms'],
                        style: context.theme.fonts.textMdMedium.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
          child: PrimaryButton(
            text: 'Continue',
            onPressed: widget.onNext,
          ),
        ),
      ],
    );
  }
}

class _FixedRatePaymentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(int) onEdit;

  const _FixedRatePaymentCard({required this.data, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      title: 'Payment & invoice',
      onEdit: () => onEdit(4),
      child: Column(
        children: [
          ReviewRow(
            label: 'Network',
            value: data['networkName'] ?? '-',
            icon: data['networkIcon'],
          ),
          ReviewRow(
            label: 'Asset',
            value: data['assetName'] ?? '-',
            icon: data['assetIcon'],
          ),
          ReviewRow(
            label: 'Payment Rate',
            value: '${data["amount"]} ${data["assetName"]}',
            subtitle: data['amountUsd'] ?? '\$0.00',
          ),
          ReviewRow(
              label: 'Invoice Frequency', value: data['frequency'] ?? '-'),
          ReviewRow(label: 'Issue Invoice On', value: data['issueOn'] ?? '-'),
          ReviewRow(label: 'Payment Due', value: data['due'] ?? '-'),
          ReviewRow(
              label: 'First Invoice Date',
              value: data['firstInvoiceDate'] ?? '-'),
          ReviewRow(
            label: 'Amount',
            value:
                '${data["firstInvoiceType"]} • ${data["amount"]} ${data["assetName"]}',
          ),
          ReviewRow(
              label: 'Inclusive Tax',
              value: data['includeTax'] == true ? 'Yes' : 'No'),
        ],
      ),
    );
  }
}

class _PayAsYouGoPaymentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(int) onEdit;

  const _PayAsYouGoPaymentCard({required this.data, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      title: 'Payment & invoice',
      onEdit: () => onEdit(4),
      child: Column(
        children: [
          ReviewRow(
            label: 'Network',
            value: data['networkName'] ?? '-',
            icon: data['networkIcon'],
          ),
          ReviewRow(
            label: 'Asset',
            value: data['assetName'] ?? '-',
            icon: data['assetIcon'],
          ),
          ReviewRow(label: 'Unit Type', value: data['rateUnit'] ?? '-'),
          ReviewRow(
            label: 'Payment Rate',
            value: '${data["amount"]} ${data["assetName"]}',
            subtitle: data['amountUsd'] ?? '\$0.00',
          ),
          ReviewRow(
              label: 'Invoice Frequency', value: data['frequency'] ?? '-'),
          ReviewRow(label: 'Issue Invoice On', value: data['issueOn'] ?? '-'),
          ReviewRow(label: 'Payment Due', value: data['due'] ?? '-'),
          ReviewRow(
              label: 'First Invoice Date',
              value: data['firstInvoiceDate'] ?? '-'),
          ReviewRow(
              label: 'Inclusive Tax',
              value: data['includeTax'] == true ? 'Yes' : 'No'),
        ],
      ),
    );
  }
}

class _MilestonePaymentCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function(int) onEdit;

  const _MilestonePaymentCard({required this.data, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final List<Milestone> milestones =
        (data['milestones'] as List<Milestone>?) ?? [];
    final bool requireDeposit = data['requireDeposit'] == true;

    return ReviewCard(
      title: 'Payment & milestone',
      onEdit: () => onEdit(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewRow(
            label: 'Network',
            value: data['networkName'] ?? '-',
            icon: data['networkIcon'],
          ),
          ReviewRow(
            label: 'Asset',
            value: data['assetName'] ?? '-',
            icon: data['assetIcon'],
          ),
          ReviewRow(
            label: 'Require a Deposit',
            value: requireDeposit ? 'Yes' : 'No',
          ),
          if (milestones.isNotEmpty) ...[
            Divider(
              height: 24,
              thickness: 1,
              color: context.theme.colors.strokeSecondary,
            ),
            ...milestones.map(
              (m) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ellipsify(word: m.name),
                            style: context.theme.fonts.textMdSemiBold,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Due by: ${m.dueDate}',
                            style: context.theme.fonts.textSmRegular.copyWith(
                              color: context.theme.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${m.amount} ${data['assetName'] ?? 'USDT'}',
                      style: context.theme.fonts.textMdSemiBold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

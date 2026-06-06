import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/review_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/agreement_file_card.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/work_scope_row.dart';

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

  static const _dummy = {
    'title': 'DefiFundr Mobile & Web App Redesign',
    'type': 'Fixed Rate',
    'jobRole': 'Senior DevOps Engineer',
    'workScope':
        'Infrastructure Management: Manage and optimize cloud-based infrastructure, ensuring scalability and reliability across all environments.',
    'clientName': 'Adegboyega Oluwagbemiro',
    'clientEmail': 'adeshinaadegboyega@icloud.com',
    'clientPhone': '+234 (801) 234 5678',
    'clientCountry': 'Nigeria',
    'clientAddress':
        'No 8 James Robertson Shittu/ Ogunlana Drive, Surulere | 142261',
    'creationDate': '15 April 2025',
    'startDate': '18 April 2025',
    'endDate': '30 September 2025',
    'noticePeriod': '30',
    'networkName': 'Ethereum',
    'assetName': 'USDT',
    'amount': '581',
    'amountUsd': '\$560.89',
    'frequency': 'Weekly',
    'issueOn': 'Monday',
    'due': 'Same day',
    'firstInvoiceDate': '15 September 2024',
    'firstInvoiceType': 'Full amount',
    'includeTax': false,
    'agreementType': 'Standard',
    'additionalTerms':
        'In the event that any payment due under this Agreement is not received by the Contractor within fifteen (15) days after the due date, the Client agrees to pay a late fee of 1.5% per month on any overdue amount, or the maximum amount permitted by law, whichever is lower.',
  };

  Map<String, dynamic> get _data => _dummy;

  @override
  Widget build(BuildContext context) {
    final isPayAsYouGo = _data['type'] == 'Pay as You Go';

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
                          value: '${_data['noticePeriod']} days'),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                ReviewCard(
                  title: 'Payment & invoice',
                  onEdit: () => widget.onEdit(4),
                  child: Column(
                    children: [
                      ReviewRow(
                        label: 'Network',
                        value: _data['networkName'] ?? '-',
                        icon: _data['networkIcon'],
                      ),
                      ReviewRow(
                        label: 'Asset',
                        value: _data['assetName'] ?? '-',
                        icon: _data['assetIcon'],
                      ),
                      ReviewRow(
                        label: 'Payment Rate',
                        value: '${_data["amount"]} ${_data["assetName"]}',
                        subtitle: _data['amountUsd'] ?? '\$0.00',
                      ),
                      if (isPayAsYouGo)
                        ReviewRow(
                            label: 'Rate Unit',
                            value: _data['rateUnit'] ?? '-'),
                      ReviewRow(
                          label: 'Invoice Frequency',
                          value: _data['frequency'] ?? '-'),
                      ReviewRow(
                          label: 'Issue Invoice On',
                          value: _data['issueOn'] ?? '-'),
                      ReviewRow(
                          label: 'Payment Due', value: _data['due'] ?? '-'),
                      ReviewRow(
                          label: 'First Invoice Date',
                          value: _data['firstInvoiceDate'] ?? '-'),
                      if (!isPayAsYouGo)
                        ReviewRow(
                            label: 'Amount',
                            value:
                                '${_data["firstInvoiceType"]} • ${_data["amount"]} ${_data["assetName"]}'),
                      ReviewRow(
                          label: 'Inclusive Tax',
                          value: _data['includeTax'] == true ? 'Yes' : 'No'),
                    ],
                  ),
                ),
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
                      const AgreementFileCard(isSmall: true),
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

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import '../widgets/milestone_action_bottom_sheet.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/contract.dart';
import '../widgets/status_chip.dart';

@RoutePage()
class MilestoneDetailScreen extends StatelessWidget {
  final Milestone milestone;
  final String contractTitle;
  final String? clientName;

  const MilestoneDetailScreen({
    Key? key,
    required this.milestone,
    required this.contractTitle,
    this.clientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.bgB1,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Milestone details',
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: context.theme.colors.bgB0,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(
                          context,
                          'Status',
                          Align(
                            alignment: Alignment.centerRight,
                            child: StatusChip(status: milestone.status),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailRow(
                          context,
                          'Name',
                          _buildValueText(context, milestone.title),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailRow(
                          context,
                          'Submission date',
                          _buildValueText(
                            context,
                            milestone.submissionDate != null
                                ? milestone.submissionDate!.dayMonthYear
                                : '--',
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailRow(
                          context,
                          'Estimated due date',
                          _buildValueText(
                            context,
                            milestone.dueDate != null
                                ? milestone.dueDate!.dayMonthYear
                                : '--',
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailRow(
                          context,
                          'Amount',
                          Text(
                            '${milestone.amount.toInt()} ${milestone.currency}',
                            textAlign: TextAlign.right,
                            style: context.theme.fonts.textMdSemiBold.copyWith(
                              color: context.theme.colors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Description',
                          style: context.theme.fonts.textMdRegular.copyWith(
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          milestone.description ?? 'No description provided.',
                          style: context.theme.fonts.textMdMedium.copyWith(
                            color: context.theme.colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailRow(
                          context,
                          'Attachment',
                          milestone.attachmentPath != null
                              ? Align(
                            alignment: Alignment.centerRight,
                                child: _buildAttachment(
                                    context, milestone.attachmentPath!),
                              )
                              : _buildValueText(context, '--'),
                        ),
                        if (milestone.invoiceNumber.isNotEmpty &&
                            (milestone.status ==
                                    PaymentStatus.awaitingPayment ||
                                milestone.status == PaymentStatus.paid)) ...[
                          const SizedBox(height: 24),
                          _buildDetailRow(
                            context,
                            'Invoice',
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  milestone.invoiceNumber,
                                  style: context.theme.fonts.textMdMedium,
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
                      color: context.theme.colors.bgB0,
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
                                  ellipsify(word: contractTitle, maxLength: 19),
                                  textAlign: TextAlign.right,
                                  style:
                                      context.theme.fonts.textMdMedium.copyWith(
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
                          _buildValueText(context, 'Milestone'),
                        ),
                        const SizedBox(height: 24),
                        _buildDetailRow(
                          context,
                          'Client',
                          _buildValueText(context, clientName ?? 'Client'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (milestone.status == PaymentStatus.pendingSubmission) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: 'Delete milestone',
                onPressed: () => _showActionModal(context, MilestoneActionType.delete),
                textColor: context.theme.colors.redDefault,
                borderColor: context.theme.colors.redStroke,
                color: Colors.transparent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                text: 'Submit milestone',
                onPressed: () => _showActionModal(context, MilestoneActionType.submit),
              ),
            ),
          ],
        ),
      );
    } else if (milestone.status == PaymentStatus.pendingApproval) {
      return PrimaryButton(
        text: 'Delete milestone',
        onPressed: () => _showActionModal(context, MilestoneActionType.delete),
        textColor: context.theme.colors.redDefault,
        borderColor: context.theme.colors.redStroke,
        color: Colors.transparent,
      );
    }
    return const SizedBox.shrink();
  }

  void _showActionModal(BuildContext context, MilestoneActionType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MilestoneActionBottomSheet(
        milestone: milestone,
        actionType: type,
      ),
    );
  }

  Widget _buildAttachment(BuildContext context, String fileName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colors.strokePrimary),
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.insert_drive_file_outlined,
              size: 16, color: context.theme.colors.textSecondary),
          const SizedBox(width: 4),
          Text(fileName, style: context.theme.fonts.textSmMedium),
        ],
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

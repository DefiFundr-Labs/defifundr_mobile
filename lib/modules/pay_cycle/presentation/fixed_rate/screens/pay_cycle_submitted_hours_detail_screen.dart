import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import '../../../data/models/contract.dart';
import '../widgets/status_chip.dart';
import '../widgets/work_submission_action_bottom_sheet.dart';

@RoutePage()
class PayCycleSubmittedHoursDetailScreen extends StatefulWidget {
  final WorkSubmission submission;
  final PayCycleContract contract;

  const PayCycleSubmittedHoursDetailScreen({
    Key? key,
    required this.submission,
    required this.contract,
  }) : super(key: key);

  @override
  State<PayCycleSubmittedHoursDetailScreen> createState() =>
      _PayCycleSubmittedHoursDetailScreenState();
}

class _PayCycleSubmittedHoursDetailScreenState
    extends State<PayCycleSubmittedHoursDetailScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isDeliverable = widget.contract.frequency == PayCycleFrequency.perDeliverable;
    final isDay = widget.contract.frequency == PayCycleFrequency.perDay;
    final isWeek = widget.contract.frequency == PayCycleFrequency.perWeek;

    return Scaffold(
      backgroundColor: context.theme.colors.bgB0,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: isDeliverable
              ? 'Deliverable details'
              : (isDay || isWeek ? 'Submission details' : 'Hours worked details'),
          actions: const [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: context.theme.colors.bgB1,
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
                              child:
                                  StatusChip(status: widget.submission.status),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (isDeliverable) ...[
                            _buildDetailRow(
                              context,
                              'Name',
                              Text(
                                  ellipsify(
                                      word:
                                          widget.submission.description ?? '--',
                                      maxLength: 20),
                                  textAlign: TextAlign.right,
                                  style: context.theme.fonts.textMdMedium),
                            ),
                          ] else ...[
                            _buildDetailRow(
                              context,
                              'Date',
                              _buildValueText(context,
                                  widget.submission.workDate.dayMonthYear),
                            ),
                          ],
                          const SizedBox(height: 24),
                          _buildDetailRow(
                            context,
                            'Submission date',
                            _buildValueText(context,
                                widget.submission.submissionDate.dayMonthYear),
                          ),
                          const SizedBox(height: 24),
                          if (!isDeliverable) ...[
                            isWeek
                                ? _buildDetailRow(
                                    context,
                                    'No of weeks worked',
                                    _buildValueText(context,
                                        '${widget.submission.quantity.toInt()} weeks'),
                                  )
                                : GestureDetector(
                                    onTap: () => setState(
                                        () => _isExpanded = !_isExpanded),
                                    child: _buildDetailRow(
                                      context,
                                      isDay
                                          ? 'No of workdays'
                                          : 'Total hours worked',
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          _buildValueText(
                                              context,
                                              isDay
                                                  ? '${widget.submission.quantity.toInt()} days'
                                                  : _formatHours(widget
                                                      .submission.quantity)),
                                          const SizedBox(width: 4),
                                          Icon(
                                              _isExpanded
                                                  ? Icons.keyboard_arrow_up
                                                  : Icons.keyboard_arrow_down,
                                              size: 20,
                                              color: context.theme.colors
                                                  .textSecondary),
                                        ],
                                      ),
                                    ),
                                  ),
                            if (_isExpanded &&
                                widget.submission.breakdown != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: context.theme.colors.bgB1,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    for (int i = 0;
                                        i < widget.submission.breakdown!.length;
                                        i++) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.submission.breakdown![i].label,
                                            style: context
                                                .theme.fonts.textMdRegular
                                                .copyWith(
                                              color: context
                                                  .theme.colors.textSecondary,
                                            ),
                                          ),
                                          Text(
                                            (isDay || isWeek)
                                                ? widget.submission.breakdown![i].duration
                                                : '${widget.submission.breakdown![i].timeRange} (${widget.submission.breakdown![i].duration})',
                                            style: context
                                                .theme.fonts.textMdMedium
                                                .copyWith(
                                              color: context
                                                  .theme.colors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (i !=
                                          widget.submission.breakdown!.length -
                                              1)
                                        const SizedBox(height: 16),
                                    ],
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                            _buildDetailRow(
                              context,
                              isDay
                                  ? 'Daily rate'
                                  : (isWeek ? 'Weekly rate' : 'Hourly rate'),
                              _buildValueText(context, widget.contract.rate),
                            ),
                            const SizedBox(height: 24),
                          ],
                          _buildDetailRow(
                            context,
                            isDeliverable ? 'Amount' : 'Calculated amount',
                            Text(
                                '${widget.submission.amount.toInt()} ${widget.submission.currency}',
                                textAlign: TextAlign.right,
                                style: context.theme.fonts.textMdMedium),
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
                            isDeliverable
                                ? 'Created a Python script to automate content uploads via the CMS API, reducing manual errors and saving time.'
                                : widget.submission.description ??
                                    'No description provided.',
                            style: context.theme.fonts.textMdMedium.copyWith(
                              color: context.theme.colors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildDetailRow(
                            context,
                            'Attachment',
                            widget.submission.attachmentPath != null
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: _buildAttachment(context,
                                        widget.submission.attachmentPath!),
                                  )
                                : _buildValueText(context, '--'),
                          ),
                          if (widget.submission.status ==
                                  PaymentStatus.rejected &&
                              widget.submission.rejectionReason != null) ...[
                            const SizedBox(height: 24),
                            Text(
                              'Reason for rejection',
                              style: context.theme.fonts.textMdRegular.copyWith(
                                color: context.theme.colors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.submission.rejectionReason!,
                              style: context.theme.fonts.textMdMedium.copyWith(
                                color: context.theme.colors.redDefault,
                              ),
                            ),
                          ],
                          if (widget.submission.invoiceNumber != null &&
                              widget.submission.invoiceNumber!.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            _buildDetailRow(
                              context,
                              'Invoice',
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.submission.invoiceNumber!,
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
                                        word: widget.contract.title,
                                        maxLength: 12),
                                    textAlign: TextAlign.right,
                                    style: context.theme.fonts.textMdMedium
                                        .copyWith(
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
                            _buildValueText(context, 'Pay As You Go'),
                          ),
                          const SizedBox(height: 24),
                          _buildDetailRow(
                            context,
                            'Client',
                            _buildValueText(context,
                                widget.contract.clientName ?? 'Client'),
                          ),
                        ],
                      ),
                    ),
                    if (widget.submission.status ==
                        PaymentStatus.pendingApproval) ...[
                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (widget.submission.status != PaymentStatus.approved)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      color: Colors.transparent,
                      text: 'Delete',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => WorkSubmissionActionBottomSheet(
                            submission: widget.submission,
                            actionType: WorkSubmissionActionType.delete,
                          ),
                        );
                      },
                      borderColor: context.theme.colors.redDefault,
                      textColor: context.theme.colors.redDefault,
                      fixedSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: widget.submission.status == PaymentStatus.rejected
                          ? 'Edit & resubmit'
                          : 'Edit',
                      onPressed: () {
                        context.router.push(
                          PayCycleSubmitHoursRoute(
                            contract: widget.contract,
                            initialSubmission: widget.submission,
                          ),
                        );
                      },
                      color: context.theme.colors.grayTertiary.withAlpha(50),
                      borderColor: Colors.transparent,
                      textColor: context.theme.colors.textPrimary,
                      fixedSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatHours(double quantity) {
    final int hours = quantity.floor();
    final int minutes = ((quantity - hours) * 60).round();
    return '${hours}h ${minutes}m';
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
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: value,
        ),
      ],
    );
  }
}

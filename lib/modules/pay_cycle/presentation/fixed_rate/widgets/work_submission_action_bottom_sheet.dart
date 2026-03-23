import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/secondary_buttons.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

import '../../../data/models/contract.dart';
import 'success_bottom_sheet.dart';

enum WorkSubmissionActionType { delete, submit }

class WorkSubmissionActionBottomSheet extends StatefulWidget {
  final WorkSubmission submission;
  final WorkSubmissionActionType actionType;

  const WorkSubmissionActionBottomSheet({
    Key? key,
    required this.submission,
    required this.actionType,
  }) : super(key: key);

  @override
  State<WorkSubmissionActionBottomSheet> createState() =>
      _WorkSubmissionActionBottomSheetState();
}

class _WorkSubmissionActionBottomSheetState
    extends State<WorkSubmissionActionBottomSheet> {
  final _reasonController = TextEditingController();

  bool get isDelete => widget.actionType == WorkSubmissionActionType.delete;
  bool get isDeliverable => widget.submission.unit.toLowerCase().contains('deliverable');
  bool get isDay => widget.submission.unit.toLowerCase().contains('day');
  bool get isWeek => widget.submission.unit.toLowerCase().contains('week');

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 32.h),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: context.theme.colors.grayTertiary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isDelete
                ? (isDeliverable
                    ? 'Delete deliverable?'
                    : (isDay
                        ? 'Delete workdays?'
                        : (isWeek ? 'Delete weeks worked?' : 'Delete submission?')))
                : (isDeliverable
                    ? 'Submit deliverable?'
                    : (isDay
                        ? 'Submit workdays?'
                        : (isWeek
                            ? 'Submit weeks worked?'
                            : 'Submit worked hours?'))),
            style: context.theme.fonts.heading3Bold,
          ),
          const SizedBox(height: 8),
          Text(
            isDelete
                ? (isDeliverable
                    ? 'Are you sure you want to delete this deliverable?'
                    : (isDay
                        ? 'Are you sure you want to delete these workdays?'
                        : (isWeek
                            ? 'Are you sure you want to delete these weeks worked?'
                            : 'Are you sure you want to delete this submission?')))
                : (isDeliverable
                    ? 'Are you sure you want to submit this deliverable?'
                    : (isDay
                        ? 'Are you sure you want to submit these workdays?'
                        : (isWeek
                            ? 'Are you sure you want to submit these weeks worked?'
                            : 'Are you sure you want to submit these worked hours?'))),
            textAlign: TextAlign.center,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.theme.colors.fillTertiary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        isDeliverable
                            ? ellipsify(
                                word: widget.submission.description ?? '--',
                                maxLength: 22)
                            : '${widget.submission.quantity.toInt()} ${isDay ? 'days' : (isWeek ? 'weeks' : 'hours')} worked',
                        style: context.theme.fonts.textMdSemiBold,
                      ),
                    ),
                    Text(
                      '${widget.submission.amount.toInt()} ${widget.submission.currency}',
                      style: context.theme.fonts.textMdSemiBold,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Submitted: ${widget.submission.submissionDate.dayMonthYear}',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            widget.submission.status == PaymentStatus.rejected
                                ? context.theme.colors.redDefault
                                : context.theme.colors.orangeActive,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ellipsify(
                        word: widget.submission.status == PaymentStatus.rejected
                            ? 'Rejected'
                            : 'Pending approval',
                      ),
                      style: context.theme.fonts.textSmMedium.copyWith(
                        color:
                            widget.submission.status == PaymentStatus.rejected
                                ? context.theme.colors.redDefault
                                : context.theme.colors.orangeActive,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isDelete) ...[
            const SizedBox(height: 24),
            AppTextField(
              hintText: 'Provide a reason *',
              controller: _reasonController,
              maxLine: 5,
            ),
          ],
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: 'Go back',
                  onPressed: () => context.router.maybePop(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  text: isDelete ? 'Delete' : 'Submit',
                  color: isDelete
                      ? context.theme.colors.redDefault
                      : context.theme.colors.brandDefault,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      builder: (context) => SuccessBottomSheet(
                        actionType: isDelete
                            ? (isDeliverable
                                ? SuccessActionType.deliverableDeleted
                                : (isDay
                                    ? SuccessActionType.workdayDeleted
                                    : (isWeek
                                        ? SuccessActionType.weeksDeleted
                                        : SuccessActionType.workSubmissionDeleted)))
                            : (isDeliverable
                                ? SuccessActionType.deliverableSubmitted
                                : (isDay
                                    ? SuccessActionType.workdaySubmitted
                                    : (isWeek
                                        ? SuccessActionType.weeksSubmitted
                                        : SuccessActionType.workSubmissionSubmitted))),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

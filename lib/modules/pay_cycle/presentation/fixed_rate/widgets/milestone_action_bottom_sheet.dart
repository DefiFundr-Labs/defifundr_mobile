import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

import '../../../data/models/contract.dart';
import 'success_bottom_sheet.dart';

enum MilestoneActionType { delete, submit }

class MilestoneActionBottomSheet extends StatefulWidget {
  final Milestone milestone;
  final MilestoneActionType actionType;

  const MilestoneActionBottomSheet({
    Key? key,
    required this.milestone,
    required this.actionType,
  }) : super(key: key);

  @override
  State<MilestoneActionBottomSheet> createState() =>
      _MilestoneActionBottomSheetState();
}

class _MilestoneActionBottomSheetState
    extends State<MilestoneActionBottomSheet> {
  final _reasonController = TextEditingController();

  bool get isDelete => widget.actionType == MilestoneActionType.delete;

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
            isDelete ? 'Delete milestone?' : 'Submit milestone?',
            style: context.theme.fonts.heading3Bold,
          ),
          const SizedBox(height: 8),
          Text(
            isDelete
                ? 'Are you sure you want to delete this milestone? Deleting it will remove it from your billed invoice.'
                : 'Are you sure you want to submit this milestone? Submitting this milestone will send it for approval.',
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
                        widget.milestone.title,
                        style: context.theme.fonts.textMdSemiBold,
                      ),
                    ),
                    Text(
                      '${widget.milestone.amount.toInt()} ${widget.milestone.currency}',
                      style: context.theme.fonts.textMdSemiBold,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Due by: ${widget.milestone.dueDate?.dayMonthYear ?? '--'}',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: context.theme.colors.orangeActive,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ellipsify(
                          word: widget.milestone.status ==
                                  PaymentStatus.pendingSubmission
                              ? 'Pending submission'
                              : 'Pending approval'),
                      style: context.theme.fonts.textSmMedium
                          .copyWith(color: context.theme.colors.orangeActive),
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
                child: PrimaryButton(
                  textColor: context.theme.colors.textPrimary,
                  color: context.theme.colors.grayTertiary.withAlpha(50),
                  text: 'Go back',
                  onPressed: () => context.router.maybePop(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  text: isDelete ? 'Delete milestone' : 'Submit',
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
                            ? SuccessActionType.milestoneDeleted
                            : SuccessActionType.milestoneSubmitted,
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

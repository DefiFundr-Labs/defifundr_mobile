import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/snackbar/app_snackbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/submitted_timesheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

import '../../../time_off/presentation/widgets/status_chip.dart';

class DeleteSubmissionBottomSheet extends StatefulWidget {
  final SubmittedTimesheet timesheet;
  final VoidCallback onConfirmDelete;

  const DeleteSubmissionBottomSheet({
    Key? key,
    required this.timesheet,
    required this.onConfirmDelete,
  }) : super(key: key);

  @override
  _DeleteSubmissionBottomSheetState createState() =>
      _DeleteSubmissionBottomSheetState();
}

class _DeleteSubmissionBottomSheetState
    extends State<DeleteSubmissionBottomSheet> {
  TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.0),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.theme.colors.fillTertiary,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Delete submission?',
                        textAlign: TextAlign.center,
                        style: context.theme.fonts.heading3Bold.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: context.theme.colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Are you sure you want to delete this submission?',
                          style: context.theme.fonts.textMdRegular.copyWith(
                            fontSize: 14.sp,
                            color: context.theme.colors.textSecondary,
                          ),
                        ),
                      ]),
                  SizedBox(height: 24.0),

                  // Submission Details
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: context.theme.colors.fillTertiary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.timesheet.formattedTotalHours} hours worked',
                              style:
                                  context.theme.fonts.textMdSemiBold.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colors.textPrimary,
                              ),
                            ),
                            Text(
                              '${widget.timesheet.calculatedAmount.toInt()} ${widget.timesheet.currency}',
                              style:
                                  context.theme.fonts.textMdSemiBold.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Submitted: ${_formatDate(widget.timesheet.submissionDate)}',
                              style: context.theme.fonts.textSmRegular.copyWith(
                                fontSize: 12.sp,
                                color: context.theme.colors.textSecondary,
                              ),
                            ),
                            StatusChip(
                              status: widget.timesheet.status,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.0),

                  // Reason Text Field
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: TextField(
                      controller: reasonController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Provide a reason *',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.0),

                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: 'Go back',
                          enableShine: false,
                          color: context.theme.colors.fillTertiary,
                          textColor: context.theme.colors.textSecondary,
                          onPressed: () => context.router.maybePop(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: PrimaryButton(
                          text: 'Delete',
                          color: context.theme.colors.redDefault,
                          enableShine: false,
                          onPressed: () {
                            if (reasonController.text.trim().isEmpty) {
                              AppSnackbar.showError(context,
                                  'Please provide a reason for deletion');
                              return;
                            }
                            widget.onConfirmDelete();
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

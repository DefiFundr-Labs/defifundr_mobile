import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/constants/size.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/shared/common_ui/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/submitted_timesheet.dart';
import '../widgets/delete_submission_bottom_sheet.dart';

@RoutePage()
class SubmittedHoursDetailScreen extends StatelessWidget {
  final SubmittedTimesheet timesheet;

  const SubmittedHoursDetailScreen({Key? key, required this.timesheet})
      : super(key: key);

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

  void _showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DeleteSubmissionBottomSheet(
        timesheet: timesheet,
        onConfirmDelete: () {
          context.router.maybePop();
          context.router.maybePop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Submission deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
      ),
    );
  }

  void _handleEditResubmit(BuildContext context) {
    if (timesheet.status == TimeOffStatus.rejected) {
      context.router.push(ResubmitHoursRoute(timesheet: timesheet));
    } else {
      // Handle edit for pending submissions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Edit functionality not implemented yet'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.screenWidth(), 60),
        child: DeFiRaiseAppBar(
          centerTitle: true,
          textStyle: context.theme.fonts.heading3SemiBold,
          isBack: true,
          title: 'Submitted hours',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status and Date Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: context.theme.colors.bgB0,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: context.theme.colors.strokeSecondary,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                            'Status',
                            StatusChip(
                              status: timesheet.status,
                            ),
                            context),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Date', _formatDate(timesheet.date), context),
                        SizedBox(height: 16.0),
                        _buildDetailRow('Submission date',
                            _formatDate(timesheet.submissionDate), context),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Total hours worked',
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  timesheet.formattedTotalHours,
                                  style:
                                      context.theme.fonts.textMdMedium.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: context.theme.colors.textPrimary,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: context.theme.colors.textSecondary,
                                  size: 20,
                                ),
                              ],
                            ),
                            context),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Hourly rate',
                            '${timesheet.hourlyRate.toInt()} ${timesheet.currency}',
                            context),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Calculated amount',
                            '${timesheet.calculatedAmount.toInt()} ${timesheet.currency}',
                            context),
                        SizedBox(height: 28.0),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: context.theme.fonts.textMdRegular
                                        .copyWith(
                                      fontSize: 14.sp,
                                      color: context.theme.colors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 12.0),
                                  Text(
                                    timesheet.description,
                                    style: context.theme.fonts.textMdMedium
                                        .copyWith(
                                      fontSize: 14.sp,
                                      color: context.theme.colors.textPrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (timesheet.attachmentName != null) ...[
                          SizedBox(height: 28.0),
                          _buildDetailRow(
                              'Attachment',
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: context.theme.colors.fillTertiary,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: context.theme.colors.strokePrimary,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.icons.file,
                                      color: context.theme.colors.textSecondary,
                                      height: 16.sp,
                                      width: 16.sp,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      timesheet.attachmentName!,
                                      style: context.theme.fonts.textMdMedium
                                          .copyWith(
                                        fontSize: 14.sp,
                                        color: context.theme.colors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              context),
                        ],
                        if (timesheet.status == TimeOffStatus.rejected &&
                            timesheet.rejectionReason != null) ...[
                          SizedBox(height: 28.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reason for rejection',
                                style:
                                    context.theme.fonts.textMdRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: context.theme.colors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 12.0),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: context.theme.colors.redDefault,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: context.theme.colors.redStroke,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  timesheet.rejectionReason!,
                                  style:
                                      context.theme.fonts.textMdMedium.copyWith(
                                    fontSize: 14.sp,
                                    color: context.theme.colors.redDefault,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),

                  SizedBox(height: 24.0),

                  // Contract Information
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: context.theme.colors.bgB0,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: context.theme.colors.strokeSecondary,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                            'Contract',
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    timesheet.contractName,
                                    style: context.theme.fonts.textMdMedium
                                        .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: context.theme.colors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  Icons.open_in_new,
                                  color: context.theme.colors.textSecondary,
                                  size: 16,
                                ),
                              ],
                            ),
                            context),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Contract Type', timesheet.contractType, context),
                        SizedBox(height: 16.0),
                        _buildDetailRow(
                            'Client', timesheet.clientName, context),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
          _buildBottomActions(context),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.theme.fonts.textMdRegular.copyWith(
              fontSize: 14.sp,
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          flex: 3,
          child: value is Widget
              ? Align(
                  alignment: Alignment.centerRight,
                  child: value,
                )
              : Text(
                  value.toString(),
                  style: context.theme.fonts.textMdMedium.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.theme.colors.textPrimary,
                  ),
                  textAlign: TextAlign.right,
                ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    if (timesheet.status == TimeOffStatus.approved) {
      return Container();
    } else {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _showDeleteConfirmation(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                        color: context.theme.colors.redDefault, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Text(
                    'Delete',
                    style: context.theme.fonts.textMdMedium.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: context.theme.colors.redDefault,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: PrimaryButton(
                  text: timesheet.status == TimeOffStatus.rejected
                      ? 'Edit & resubmit'
                      : 'Edit',
                  color: context.theme.colors.fillTertiary,
                  onPressed: () => _handleEditResubmit(context),
                  textColor: context.theme.colors.textPrimary,
                ),
              ),
            ],
          ));
    }
  }
}

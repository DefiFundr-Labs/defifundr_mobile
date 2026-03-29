import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off_detail.dart';
import 'package:flutter/material.dart';

import '../widgets/status_chip.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/routers/routers.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class TimeOffDetailScreen extends StatelessWidget {
  final TimeOffDetail timeOffDetail;

  const TimeOffDetailScreen({
    Key? key,
    required this.timeOffDetail,
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
          title: 'Time off details',
          actions: [],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildGeneralDetailsContainer(context),
                  const SizedBox(height: 32),
                  _buildContractDetailsContainer(context),
                  const SizedBox(height: 32),
                  _buildTimelineContainer(context),
                ],
              ),
            ),
          ),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget _buildGeneralDetailsContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(context, 'Status',
              widget: StatusChip(status: timeOffDetail.status, isPill: true)),
          const SizedBox(height: 24),
          _buildRow(context, 'Type', value: timeOffDetail.type),
          const SizedBox(height: 24),
          _buildRow(context, 'Reason', value: timeOffDetail.reason),
          const SizedBox(height: 24),
          _buildRow(context, 'Dates', value: timeOffDetail.dateRange),
          const SizedBox(height: 24),
          _buildRow(context, 'Submission date',
              value: timeOffDetail.formatDate(timeOffDetail.submissionDate)),
          const SizedBox(height: 24),
          if (timeOffDetail.status == TimeOffStatus.rejected)
            _buildRow(context, 'Rejection date',
                value: timeOffDetail.rejectionDate != null
                    ? timeOffDetail.formatDate(timeOffDetail.rejectionDate!)
                    : '--')
          else
            _buildRow(context, 'Approval date',
                value: timeOffDetail.status == TimeOffStatus.pending
                    ? '--'
                    : (timeOffDetail.approvalDate != null
                        ? timeOffDetail.formatDate(timeOffDetail.approvalDate!)
                        : '--')),
          const SizedBox(height: 24),
          _buildRow(context, 'Total time off',
              value: '${timeOffDetail.totalDays} days'),
          const SizedBox(height: 24),
          Text(
            'Description',
            style: context.theme.fonts.textSmRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            timeOffDetail.description,
            style: context.theme.fonts.textMdMedium.copyWith(
              color: context.theme.colors.textPrimary,
              height: 1.4,
            ),
          ),
          if (timeOffDetail.attachmentFileName != null) ...[
            const SizedBox(height: 24),
            _buildRow(
              context,
              'Attachment',
              widget: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: context.theme.colors.bgB1,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.description_outlined,
                        size: 16, color: context.theme.colors.textTertiary),
                    const SizedBox(width: 6),
                    Text(
                      timeOffDetail.attachmentFileName!,
                      style: context.theme.fonts.textSmMedium.copyWith(
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (timeOffDetail.status == TimeOffStatus.rejected && timeOffDetail.rejectionReason != null) ...[
            const SizedBox(height: 24),
            Text(
              'Reason for rejection',
              style: context.theme.fonts.textSmRegular.copyWith(
                color: context.theme.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              timeOffDetail.rejectionReason!,
              style: context.theme.fonts.textMdMedium.copyWith(
                color: context.theme.colors.redDefault,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContractDetailsContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildRow(context, 'Contract',
              value: ellipsify(word: timeOffDetail.contractName, maxLength: 20),
              showLink: true),
          const SizedBox(height: 24),
          _buildRow(context, 'Contract Type',
              value: timeOffDetail.contractType),
          const SizedBox(height: 24),
          _buildRow(context, 'Client', value: timeOffDetail.clientName),
        ],
      ),
    );
  }

  Widget _buildTimelineContainer(BuildContext context) {
    if (timeOffDetail.statusUpdates.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: timeOffDetail.statusUpdates.asMap().entries.map((entry) {
          final isLast = entry.key == timeOffDetail.statusUpdates.length - 1;
          final update = entry.value;

          bool nextIsCompleted = false;
          if (!isLast) {
            final next = timeOffDetail.statusUpdates[entry.key + 1];
            if (next.type == TimeOffStatusUpdateType.created ||
                next.type == TimeOffStatusUpdateType.approved ||
                next.type == TimeOffStatusUpdateType.completed ||
                next.type == TimeOffStatusUpdateType.inProgress ||
                next.type == TimeOffStatusUpdateType.rejected) {
              nextIsCompleted = true;
            }
          }

          return _buildTrackerItem(context, update,
              isLast: isLast, nextIsCompleted: nextIsCompleted);
        }).toList(),
      ),
    );
  }

  Widget _buildTrackerItem(BuildContext context, TimeOffStatusUpdate update,
      {required bool isLast, required bool nextIsCompleted}) {
    Color? lineColor;
    late Widget customIcon;
    bool isGreyedOut = false;

    switch (update.type) {
      case TimeOffStatusUpdateType.created:
      case TimeOffStatusUpdateType.approved:
      case TimeOffStatusUpdateType.inProgress:
      case TimeOffStatusUpdateType.completed:
        customIcon = SvgPicture.asset(
          Assets.icons.checkCircle,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            context.theme.colors.greenDefault,
            BlendMode.srcIn,
          ),
        );
        if (nextIsCompleted) {
          lineColor = context.theme.colors.greenDefault;
        }
        break;
      case TimeOffStatusUpdateType.awaiting:
        customIcon = SvgPicture.asset(
          Assets.icons.clockCountdown,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            context.theme.colors.orangeDefault,
            BlendMode.srcIn,
          ),
        );
        break;
      case TimeOffStatusUpdateType.scheduledStart:
      case TimeOffStatusUpdateType.scheduledEnd:
        customIcon = DashedCircleIcon(
            color: context.theme.colors.textSecondary.withValues(alpha: 0.5));
        isGreyedOut = true;
        break;
      case TimeOffStatusUpdateType.rejected:
        customIcon = SvgPicture.asset(
          Assets.icons.prohibit,
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            context.theme.colors.redDefault,
            BlendMode.srcIn,
          ),
        );
        lineColor = context.theme.colors.redDefault;
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              customIcon,
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: lineColor ??
                        context.theme.colors.strokeSecondary
                            .withValues(alpha: 0.3),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    update.title,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      fontSize: 13,
                      color: isGreyedOut
                          ? context.theme.colors.textSecondary
                              .withValues(alpha: 0.5)
                          : context.theme.colors.textPrimary,
                    ),
                  ),
                ),
                if (update.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    update.description,
                    style: context.theme.fonts.textMdRegular.copyWith(
                      fontSize: 12,
                      color: isGreyedOut
                          ? context.theme.colors.textSecondary
                              .withValues(alpha: 0.5)
                          : context.theme.colors.textSecondary,
                    ),
                  ),
                ],
                if (!isLast) const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label,
      {String? value, Widget? widget, bool showLink = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Text(
            label,
            style: context.theme.fonts.textMdRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (value != null)
                Flexible(
                  child: Text(
                    value,
                    style: context.theme.fonts.textMdMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              if (widget != null) widget,
              if (showLink) ...[
                const SizedBox(width: 6),
                Icon(Icons.open_in_new,
                    size: 16, color: context.theme.colors.textPrimary),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    if (timeOffDetail.status == TimeOffStatus.used || timeOffDetail.status == TimeOffStatus.rejected) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 16,
          bottom: MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              onPressed: () {
                context.router.push(CancelTimeOffRequestRoute(timeOffDetail: timeOffDetail));
              },
              text: 'Cancel request',
              color: context.theme.colors.fillTertiary,
              textColor: context.theme.colors.textPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PrimaryButton(
              onPressed: () {
                if (timeOffDetail.status == TimeOffStatus.pending) {
                  context.router.push(EditTimeOffRequestRoute(timeOffDetail: timeOffDetail));
                } else if (timeOffDetail.status == TimeOffStatus.approved) {
                  context.router.push(RequestChangeRoute(timeOffDetail: timeOffDetail));
                }
              },
              text: _getActionButtonText(),
            ),
          ),
        ],
      ),
    );
  }

  String _getActionButtonText() {
    switch (timeOffDetail.status) {
      case TimeOffStatus.pending:
        return 'Edit request';
      case TimeOffStatus.approved:
        return 'Request change';
      case TimeOffStatus.rejected:
      case TimeOffStatus.used:
        return 'Edit request';
    }
  }
}

class DashedCircleIcon extends StatelessWidget {
  final Color color;
  const DashedCircleIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CustomPaint(
            painter: DashedCirclePainter(color: color),
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;

  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.width / 2) - 1);

    const int dashCount = 8;
    const double dashLength = (2 * 3.141592653589793) / (dashCount * 2);

    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(rect, i * 2 * dashLength, dashLength, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Sample data factory for testing
class TimeOffDetailFactory {
  static TimeOffDetail createPendingRequest() {
    return TimeOffDetail(
      id: '1',
      status: TimeOffStatus.pending,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 6, 3),
      endDate: DateTime(2025, 6, 7),
      submissionDate: DateTime(2025, 5, 21),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Awaiting client approval',
          description: 'Leave is linked to the approval of your submission',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.awaiting,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should start on 20 December 2024.',
          description: '',
          timestamp: DateTime(2024, 12, 20),
          type: TimeOffStatusUpdateType.scheduledStart,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should end on 02 January 2025',
          description: '',
          timestamp: DateTime(2025, 1, 2),
          type: TimeOffStatusUpdateType.scheduledEnd,
        ),
      ],
    );
  }

  static TimeOffDetail createRejectedRequest() {
    return TimeOffDetail(
      id: '2',
      status: TimeOffStatus.rejected,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 3, 6),
      endDate: DateTime(2025, 3, 10),
      submissionDate: DateTime(2025, 2, 20),
      rejectionDate: DateTime(2025, 2, 24),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      rejectionReason:
          'Leave request overlaps with critical end-of-year operations and staffing requirements.',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Time off request rejected by client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.rejected,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should start on 20 December 2024.',
          description: '',
          timestamp: DateTime(2024, 12, 20),
          type: TimeOffStatusUpdateType.scheduledStart,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should end on 02 January 2025',
          description: '',
          timestamp: DateTime(2025, 1, 2),
          type: TimeOffStatusUpdateType.scheduledEnd,
        ),
      ],
    );
  }

  static TimeOffDetail createApprovedRequest() {
    return TimeOffDetail(
      id: '3',
      status: TimeOffStatus.approved,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 5, 22),
      submissionDate: DateTime(2025, 5, 16),
      approvalDate: DateTime(2025, 5, 18),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Time off request approved & scheduled',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.approved,
        ),
        TimeOffStatusUpdate(
          title: 'Awaiting time off start date',
          description:
              'According to your time off request, your leave should start on 20 December 2024.',
          timestamp: DateTime(2024, 12, 20),
          type: TimeOffStatusUpdateType.awaiting,
        ),
        TimeOffStatusUpdate(
          title:
              'According to your time off request, your leave should end on 02 January 2025',
          description: '',
          timestamp: DateTime(2025, 1, 2),
          type: TimeOffStatusUpdateType.scheduledEnd,
        ),
      ],
    );
  }

  static TimeOffDetail createUsedRequest() {
    return TimeOffDetail(
      id: '4',
      status: TimeOffStatus.used,
      type: 'Paid time off',
      reason: 'Annual leave',
      startDate: DateTime(2025, 3, 31),
      endDate: DateTime(2025, 4, 6),
      submissionDate: DateTime(2025, 3, 21),
      approvalDate: DateTime(2025, 3, 24),
      totalDays: 14,
      description:
          'Utilizing accrued annual leave to spend the festive season with family and recharge for the new year.',
      attachmentFileName: 'File name.pdf',
      contractName: 'Brightfolk Payment for c...',
      contractType: 'Fixed Rate',
      clientName: 'Adegboyega Oluwagbemiro',
      statusUpdates: [
        TimeOffStatusUpdate(
          title: 'Time off request created & sent to client',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.created,
        ),
        TimeOffStatusUpdate(
          title: 'Time off request approved & scheduled',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.approved,
        ),
        TimeOffStatusUpdate(
          title: 'Time off in progress',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.inProgress,
        ),
        TimeOffStatusUpdate(
          title: 'Time off completed',
          description: '20th April 2025, 04:40 PM',
          timestamp: DateTime(2025, 4, 20, 16, 40),
          type: TimeOffStatusUpdateType.completed,
        ),
      ],
    );
  }
}

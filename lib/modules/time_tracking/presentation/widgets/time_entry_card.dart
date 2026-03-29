import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../time_off/presentation/widgets/status_chip.dart';

class TimeEntryCard extends StatelessWidget {
  final TimeEntry timeEntry;
  final TimeTrackingContract contract;

  const TimeEntryCard({
    Key? key,
    required this.timeEntry,
    required this.contract,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: EdgeInsets.only(bottom: 16.r),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time period',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _formatTimeRange(timeEntry.startTime, timeEntry.endTime),
                      style: context.theme.fonts.textBaseMedium.copyWith(
                        color: context.theme.colors.brandDefault,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total hours worked',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _formatDuration(timeEntry.duration),
                      style: context.theme.fonts.textBaseMedium.copyWith(
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Calculated amount',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '${timeEntry.amount.toInt()} ${timeEntry.currency}',
                      style: context.theme.fonts.textBaseMedium.copyWith(
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: context.theme.fonts.textSmRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: StatusChip(
                        status: timeEntry.status,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    String formatTime(DateTime time) {
      String hour = time.hour.toString().padLeft(2, '0');
      String minute = time.minute.toString().padLeft(2, '0');
      return '$hour:${minute}pm';
    }

    return '${formatTime(start)} - ${formatTime(end)}';
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '$hours h $minutes m';
  }
}

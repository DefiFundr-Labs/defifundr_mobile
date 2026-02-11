import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TimeRecordCard extends StatelessWidget {
  final TimeRecord timeRecord;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TimeRecordCard({
    Key? key,
    required this.timeRecord,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  String _formatTime(DateTime time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_formatTime(timeRecord.startTime)} - ${_formatTime(timeRecord.endTime)}',
                  style: context.theme.fonts.textMdSemiBold.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.theme.colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  timeRecord.type,
                  style: context.theme.fonts.textSmRegular.copyWith(
                    fontSize: 12.sp,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatDuration(timeRecord.duration),
            style: context.theme.fonts.textSmRegular.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.theme.colors.textPrimary,
            ),
          ),
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: onEdit,
            child: SvgPicture.asset(
              Assets.icons.notePencil,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../data/models/work_record.dart';

class WorkRecordCard extends StatelessWidget {
  final WorkRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final bool isDay;

  const WorkRecordCard({
    Key? key,
    required this.record,
    required this.onEdit,
    required this.onDelete,
    this.isDay = false,
  }) : super(key: key);

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isDay
                    ? DateFormat('d MMM yyyy').format(record.startTime)
                    : '${_formatTime(record.startTime)} – ${_formatTime(record.endTime)}',
                style: context.theme.fonts.textMdSemiBold,
              ),
              SizedBox(height: 4.h),
              Text(
                record.type,
                style: context.theme.fonts.textSmRegular.copyWith(
                  color: context.theme.colors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (!isDay)
                Text(
                  _formatDuration(record.duration),
                  style: context.theme.fonts.textMdSemiBold,
                ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: onEdit,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    Assets.icons.notePencil,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmissionSummary extends StatelessWidget {
  final Duration totalHours;
  final double hourlyRate;
  final String currency;

  const SubmissionSummary({
    Key? key,
    required this.totalHours,
    required this.hourlyRate,
    required this.currency,
  }) : super(key: key);

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '--';
    }
  }

  double _calculateAmount() {
    if (totalHours.inMinutes == 0) return 0.0;
    double hours = totalHours.inMinutes / 60.0;
    return hours * hourlyRate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total Hours Worked
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total hours worked',
                style: context.theme.fonts.textBaseSemiBold.copyWith(
                  color: context.theme.colors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
              Text(
                _formatDuration(totalHours),
                style: context.theme.fonts.textBaseMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),

        // Hourly Rate

        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hourly rate',
                style: context.theme.fonts.textBaseSemiBold.copyWith(
                  color: context.theme.colors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
              Text(
                '${hourlyRate.toInt()} $currency',
                style: context.theme.fonts.textBaseMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.0),

        // Calculated Amount
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calculated amount',
                style: context.theme.fonts.textBaseSemiBold.copyWith(
                  color: context.theme.colors.textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
              Text(
                totalHours.inMinutes > 0
                    ? '${_calculateAmount().toInt()} $currency'
                    : '--',
                style: context.theme.fonts.textBaseMedium.copyWith(
                  color: context.theme.colors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

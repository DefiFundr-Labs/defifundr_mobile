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
        SummaryItemContainer(
          label: 'Total hours worked',
          value: _formatDuration(totalHours),
        ),
        SummaryItemContainer(
          label: 'Hourly rate',
          value: '${hourlyRate.toInt()} $currency',
        ),
        SummaryItemContainer(
          label: 'Calculated amount',
          value: totalHours.inMinutes > 0
              ? '${_calculateAmount().toInt()} $currency'
              : '--',
        ),
      ],
    );
  }
}

class SummaryItemContainer extends StatelessWidget {
  final String label;
  final String value;

  const SummaryItemContainer({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                label,
                style: context.theme.fonts.textMdRegular
                    .copyWith(color: context.theme.colors.textSecondary),
              ),
              Text(
                value,
                style: context.theme.fonts.textMdMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

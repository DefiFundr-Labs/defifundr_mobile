import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/time_tracking_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TimeTrackingSummaryCard extends StatelessWidget {
  final TimeTrackingSummary summary;

  const TimeTrackingSummaryCard({Key? key, required this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.3,
        children: [
          _buildSummaryItem(
            icon: Assets.icons.clock,
            label: 'Total hours logged',
            value: '${summary.totalHours} h',
            context: context,
          ),
          _buildSummaryItem(
            icon: Assets.icons.checkCircle,
            label: 'Approved hours',
            value: '${summary.approvedHours} h',
            context: context,
          ),
          _buildSummaryItem(
            icon: Assets.icons.clockCountdown,
            label: 'Pending hours',
            value: '${summary.pendingHours} h',
            context: context,
          ),
          _buildSummaryItem(
            icon: Assets.icons.prohibit,
            label: 'Denied hours',
            value: '${summary.deniedHours} h',
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: ShapeDecoration(
        color: context.theme.colors.bgB1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: context.theme.colors.textSecondary,
            blurRadius: 1,
            offset: Offset(0, 1),
            spreadRadius: -5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 20.sp,
            width: 20.sp,
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: context.theme.fonts.textMdRegular
                .copyWith(color: context.theme.colors.textSecondary),
          ),
          SizedBox(height: 4.0),
          Text(value, style: context.theme.fonts.heading3SemiBold),
        ],
      ),
    );
  }
}

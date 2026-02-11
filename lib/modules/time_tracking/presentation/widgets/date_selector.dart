import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onDateSelected;

  const DateSelector({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

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
    return GestureDetector(
      onTap: onDateSelected,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: context.theme.colors.bgB0,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select date',
                  style: context.theme.fonts.textMdRegular.copyWith(
                    fontSize: 12.sp,
                    color: context.theme.colors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  _formatDate(selectedDate),
                  style: context.theme.fonts.textMdRegular.copyWith(
                    fontSize: 16.sp,
                    color: context.theme.colors.textPrimary,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              Assets.icons.calendar,
            ),
          ],
        ),
      ),
    );
  }
}

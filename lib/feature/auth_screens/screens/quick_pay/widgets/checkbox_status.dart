import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CheckBoxStatus extends StatelessWidget {
  const CheckBoxStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.brandFill,
                border: Border.all(
                  color: AppColors.brandStroke,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'All',
                    style: TextStyle(
                      color: AppColors.brandDefault,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: null,
                tristate: true,
                onChanged: (value) {},
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.brandDefault;
                  }
                  return Colors.transparent;
                }),
                side: BorderSide(
                  color: AppColors.strokeSecondary,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            )
          ],
        ),
        SizedBox(height: 8 * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.orangeFill,
                border: Border.all(
                  color: AppColors.orangeStroke,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Processing',
                    style: TextStyle(
                      color: AppColors.orangeDefault,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: false,
                tristate: true,
                onChanged: (value) {},
                side: BorderSide(
                  color: AppColors.strokeSecondary,
                  width: 1,
                ),
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.brandDefault;
                  }
                  return Colors.transparent;
                }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            )
          ],
        ),
        SizedBox(height: 8 * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.greenFill,
                border: Border.all(
                  color: AppColors.greenStroke,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Successful',
                    style: TextStyle(
                      color: AppColors.greenDefault,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: null,
                tristate: true,
                onChanged: (value) {},
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.brandDefault;
                  }
                  return Colors.transparent;
                }),
                side: BorderSide(
                  color: AppColors.strokeSecondary,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            )
          ],
        ),
        SizedBox(height: 8 * 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.redFill,
                border: Border.all(
                  color: AppColors.redStroke,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Failed',
                    style: TextStyle(
                      color: AppColors.redDefault,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                value: null,
                tristate: true,
                onChanged: (value) {},
                fillColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.brandDefault;
                  }
                  return Colors.transparent;
                }),
                side: BorderSide(
                  color: AppColors.strokeSecondary,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            )
          ],
        )
      ],
    );
  }
}

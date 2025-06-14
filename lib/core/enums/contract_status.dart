import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:flutter/widgets.dart';

enum ContractStatus {
  active(
    label: 'Active',
    bgColor: AppColors.greenFill,
    borderColor: AppColors.greenStroke,
    textColor: AppColors.greenDefault,
  ),
  pending(
      label: 'Pending',
      bgColor: AppColors.orangeFill,
      borderColor: AppColors.orangeStroke,
      textColor: AppColors.orangeDefault),
  rejected(
    label: 'Rejected',
    bgColor: AppColors.pinkFill,
    borderColor: AppColors.pinkStroke,
    textColor: AppColors.pinkDefault,
  ),
  completed(
    label: 'Completed',
    bgColor: AppColors.blueFill,
    borderColor: AppColors.blueStroke,
    textColor: AppColors.blueDefault,
  ),
  cancelled(
    label: 'Cancelled',
    bgColor: AppColors.redFill,
    borderColor: AppColors.redStroke,
    textColor: AppColors.redDefault,
  );

  final String label;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  const ContractStatus(
      {required this.label,
      required this.bgColor,
      required this.borderColor,
      required this.textColor});
}

import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/contract_status.dart';
import 'package:flutter/material.dart';

class buildContractCard extends StatelessWidget {
  const buildContractCard({
    super.key,
    required this.label,
    this.status,
    this.trailingText,
    required this.amount,
    required this.duration,
    required this.contractType,
  });
  final String label;
  final String amount;
  final ContractStatus? status;
  final String? trailingText;
  final String duration;
  final String contractType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.bgB0,
          boxShadow: [
            BoxShadow(
              color: AppColors.constantDefault.withOpacity(0.3),
              blurRadius: 1,
              spreadRadius: -5,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          buildRowWidget(
            leading: label,
            leadingStyle: context.theme.fonts.textMdSemiBold,
            status: status,
          ),
          SizedBox(height: 16),
          buildRowWidget(
            leading: 'Type',
            leadingStyle: context.theme.fonts.textSmRegular,
            trailing: amount,
            trailingStyle: context.theme.fonts.textMdSemiBold,
          ),
          buildRowWidget(
            leading: contractType,
            leadingStyle: context.theme.fonts.textMdSemiBold,
            trailing: duration,
            trailingStyle: context.theme.fonts.textSmRegular,
          ),
        ],
      ),
    );
  }
}

class buildRowWidget extends StatelessWidget {
  const buildRowWidget({
    super.key,
    required this.leading,
    required this.leadingStyle,
    this.trailingStyle,
    this.trailing,
    this.status,
  });
  final String leading;
  final String? trailing;
  final TextStyle leadingStyle;
  final TextStyle? trailingStyle;
  final ContractStatus? status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            leading,
            overflow: TextOverflow.ellipsis,
            style: leadingStyle,
          ),
        ),
        status != null
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: status!.bgColor,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: status!.borderColor),
                ),
                child: Text(
                  status!.label,
                  style: context.theme.fonts.textXsSemiBold
                      .copyWith(color: status!.textColor),
                ),
              )
            : Text(
                trailing!,
                style: trailingStyle,
              ),
      ],
    );
  }
}

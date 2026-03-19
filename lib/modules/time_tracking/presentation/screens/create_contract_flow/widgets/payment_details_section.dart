import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDetailsSection extends StatelessWidget {
  final ContractType? contractType;
  final Network? selectedNetwork;
  final NetworkAsset? selectedAsset;
  final String? rateUnit;
  final TextEditingController paymentAmountController;
  final VoidCallback onSelectNetwork;
  final VoidCallback onSelectAsset;
  final VoidCallback onSelectRateUnit;

  const PaymentDetailsSection({
    super.key,
    required this.contractType,
    required this.selectedNetwork,
    required this.selectedAsset,
    required this.rateUnit,
    required this.paymentAmountController,
    required this.onSelectNetwork,
    required this.onSelectAsset,
    required this.onSelectRateUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment details', style: context.theme.fonts.textBaseMedium),
        SizedBox(height: 20.h),
        AppTextField(
          controller: TextEditingController(text: selectedNetwork?.name ?? ''),
          labelText: 'Network',
          hintText: 'Select network',
          suffixType: SuffixType.defaultt,
          readOnly: true,
          onTap: onSelectNetwork,
          prefixType: selectedNetwork != null
              ? PrefixType.customWidget
              : PrefixType.none,
          prefixWidget: selectedNetwork != null
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(selectedNetwork!.iconPath,
                      width: 24, height: 24),
                )
              : null,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          controller: paymentAmountController,
          hintText: 'Amount',
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
          contentPadding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
          prefixType: PrefixType.customWidget,
          prefixWidget: GestureDetector(
            onTap: onSelectAsset,
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedAsset != null)
                    Image.asset(selectedAsset!.iconPath, width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text(selectedAsset?.name ?? 'USDT',
                      style: context.theme.fonts.textMdMedium),
                  const SizedBox(width: 4),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 24,
                    color: context.theme.colors.strokeSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (contractType == ContractType.payAsYouGo) ...[
          SizedBox(height: 20.h),
          AppTextField(
            controller: TextEditingController(text: rateUnit ?? ''),
            labelText: 'Rate unit',
            hintText: 'Rate unit',
            suffixType: SuffixType.defaultt,
            readOnly: true,
            onTap: onSelectRateUnit,
          ),
          SizedBox(height: 8.h),
          Text(
            'Payment is based on the exact number of units submitted.',
            style: context.theme.fonts.textXsRegular.copyWith(
              color: context.theme.colors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

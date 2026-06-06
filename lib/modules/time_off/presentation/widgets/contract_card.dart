import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';

import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import '../../data/models/contract.dart';

class ContractCard extends StatelessWidget {
  final TimeOffContract contract;
  final VoidCallback? onTap;

  const ContractCard({
    Key? key,
    required this.contract,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    contract.title,
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.theme.colors.greenFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Active',
                    style: context.theme.fonts.textXsMedium.copyWith(
                      color: context.theme.colors.greenDefault,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type',
                      style: context.theme.fonts.textXsRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contract.type.title,
                      style: context.theme.fonts.textSmMedium.copyWith(
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      contract.paymentAmount,
                      style: context.theme.fonts.textMdSemiBold.copyWith(
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      contract.paymentFrequency,
                      style: context.theme.fonts.textXsRegular.copyWith(
                        color: context.theme.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

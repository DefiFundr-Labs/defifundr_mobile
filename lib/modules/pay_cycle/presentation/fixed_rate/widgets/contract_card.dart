import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';

import '../../../data/models/contract.dart';

class ContractCard extends StatelessWidget {
  final PayCycleContract contract;
  final VoidCallback? onTap;

  const ContractCard({
    Key? key,
    required this.contract,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.theme.colors.strokeSecondary),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      ellipsify(word: contract.title, maxLength: 20),
                      style: context.theme.fonts.textMdSemiBold.copyWith(
                        color: context.theme.colors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: contract.isActive
                          ? context.theme.colors.greenDefault
                              .withValues(alpha: 0.1)
                          : context.theme.colors.fillTertiary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      contract.isActive ? 'Active' : 'Inactive',
                      style: context.theme.fonts.textSmMedium.copyWith(
                        color: contract.isActive
                            ? context.theme.colors.greenDefault
                            : context.theme.colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Type',
                    style: context.theme.fonts.textSmRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    contract.rate,
                    style: context.theme.fonts.textMdSemiBold.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    contract.type.displayName,
                    style: context.theme.fonts.textSmMedium.copyWith(
                      color: context.theme.colors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    contract.frequency.displayName,
                    style: context.theme.fonts.textSmRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

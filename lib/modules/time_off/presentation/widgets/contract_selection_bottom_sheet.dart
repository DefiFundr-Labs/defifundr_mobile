import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/contract.dart';

class ContractSelectionBottomSheet extends StatefulWidget {
  final List<TimeOffContract> contracts;
  final String selectedContractId;
  final Function(TimeOffContract) onContractSelected;

  const ContractSelectionBottomSheet({
    Key? key,
    required this.contracts,
    required this.selectedContractId,
    required this.onContractSelected,
  }) : super(key: key);

  @override
  State<ContractSelectionBottomSheet> createState() => _ContractSelectionBottomSheetState();
}

class _ContractSelectionBottomSheetState extends State<ContractSelectionBottomSheet> {
  late String _localSelectedContractId;

  @override
  void initState() {
    super.initState();
    _localSelectedContractId = widget.selectedContractId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB0,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.theme.colors.strokeSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contracts', style: context.theme.fonts.heading2Bold),
              const SizedBox(height: 8),
              ...widget.contracts.map((contract) => ContractSelectionItem(
                    contract: contract,
                    isSelected: contract.id == _localSelectedContractId,
                    onTap: () {
                      setState(() {
                        _localSelectedContractId = contract.id;
                      });
                    },
                  )),
              const SizedBox(height: 20),
              PrimaryButton(
                text: 'Continue',
                enableShine: false,
                onPressed: () {
                  final selectedContract = widget.contracts.firstWhere(
                    (c) => c.id == _localSelectedContractId,
                    orElse: () => widget.contracts.first,
                  );
                  widget.onContractSelected(selectedContract);
                  context.router.maybePop();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class ContractSelectionItem extends StatelessWidget {
  final TimeOffContract contract;
  final bool isSelected;
  final VoidCallback onTap;

  const ContractSelectionItem({
    Key? key,
    required this.contract,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contract.title,
                      style: context.theme.fonts.textMdSemiBold),
                  Text(
                    contract.type.title,
                    style: context.theme.fonts.textSmRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? context.theme.colors.blueDefault
                      : context.theme.colors.strokeSecondary,
                  width: 2,
                ),
                color: Colors.transparent,
              ),
              child: isSelected
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.colors.blueDefault,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

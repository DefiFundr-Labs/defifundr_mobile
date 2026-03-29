import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/milestone.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/milestone_details_section.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMilestoneStep extends StatelessWidget {
  final Network? selectedNetwork;
  final NetworkAsset? selectedAsset;
  final List<Milestone> milestones;
  final bool requireDeposit;
  final TextEditingController depositAmountController;
  final ValueChanged<Network?> onNetworkChanged;
  final ValueChanged<NetworkAsset?> onAssetChanged;
  final ValueChanged<bool> onDepositToggled;
  final ValueChanged<Milestone> onMilestoneAdded;
  final ValueChanged<Milestone> onMilestoneEdited;
  final ValueChanged<String> onMilestoneDeleted;
  final VoidCallback onNext;

  const PaymentMilestoneStep({
    super.key,
    required this.selectedNetwork,
    required this.selectedAsset,
    required this.milestones,
    required this.requireDeposit,
    required this.depositAmountController,
    required this.onNetworkChanged,
    required this.onAssetChanged,
    required this.onDepositToggled,
    required this.onMilestoneAdded,
    required this.onMilestoneEdited,
    required this.onMilestoneDeleted,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment details',
                    style: context.theme.fonts.textBaseMedium),
                SizedBox(height: 20.h),
                AppTextField(
                  controller:
                      TextEditingController(text: selectedNetwork?.name ?? ''),
                  labelText: 'Network',
                  hintText: 'Select network',
                  suffixType: selectedNetwork != null
                      ? SuffixType.customWidget
                      : SuffixType.defaultt,
                  suffixWidget: selectedNetwork != null
                      ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(selectedNetwork!.iconPath,
                              width: 28, height: 28),
                        )
                      : null,
                  readOnly: true,
                  onTap: () => _showNetworkPicker(context),
                ),
                SizedBox(height: 20.h),
                AppTextField(
                  controller:
                      TextEditingController(text: selectedAsset?.name ?? ''),
                  labelText: 'Asset',
                  hintText: 'Select asset',
                  suffixType: selectedAsset != null
                      ? SuffixType.customWidget
                      : SuffixType.defaultt,
                  suffixWidget: selectedAsset != null
                      ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(selectedAsset!.iconPath,
                              width: 28, height: 28),
                        )
                      : null,
                  readOnly: true,
                  onTap: () => _showAssetPicker(context),
                ),
                SizedBox(height: 20.h),
                MilestoneDetailsSection(
                  milestones: milestones,
                  requireDeposit: requireDeposit,
                  depositAmountController: depositAmountController,
                  onDepositToggled: onDepositToggled,
                  onMilestoneAdded: onMilestoneAdded,
                  onMilestoneEdited: onMilestoneEdited,
                  onMilestoneDeleted: onMilestoneDeleted,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 32.h),
          child: PrimaryButton(
            text: 'Continue',
            onPressed: onNext,
          ),
        ),
      ],
    );
  }

  void _showNetworkPicker(BuildContext context) {
    _showPickerSheet(
      context: context,
      title: 'Select network',
      items: Network.supportedNetworks,
      onSelected: (val) => onNetworkChanged(val as Network),
      itemBuilder: (item) => Row(
        children: [
          Image.asset((item as Network).iconPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Text(item.name, style: context.theme.fonts.textMdMedium),
        ],
      ),
    );
  }

  void _showAssetPicker(BuildContext context) {
    _showPickerSheet(
      context: context,
      title: 'Select asset',
      items: NetworkAsset.supportedAssets,
      onSelected: (val) => onAssetChanged(val as NetworkAsset),
      itemBuilder: (item) => Row(
        children: [
          Image.asset((item as NetworkAsset).iconPath, width: 32, height: 32),
          const SizedBox(width: 12),
          Text(item.name, style: context.theme.fonts.textMdMedium),
          const Spacer(),
          Text(item.balance, style: context.theme.fonts.textMdRegular),
        ],
      ),
    );
  }

  void _showPickerSheet({
    required BuildContext context,
    required String title,
    required List<dynamic> items,
    required ValueChanged<dynamic> onSelected,
    Widget Function(dynamic)? itemBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SelectionBottomSheet(
        title: title,
        items: items,
        onSelected: (val) {
          onSelected(val);
          ctx.router.maybePop();
        },
        itemBuilder: itemBuilder,
      ),
    );
  }
}

import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/utils/ellipsify.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/milestone.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/create_contract_flow/widgets/add_edit_milestone_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MilestoneDetailsSection extends StatelessWidget {
  final List<Milestone> milestones;
  final bool requireDeposit;
  final TextEditingController depositAmountController;
  final ValueChanged<bool> onDepositToggled;
  final ValueChanged<Milestone> onMilestoneAdded;
  final ValueChanged<Milestone> onMilestoneEdited;
  final ValueChanged<String> onMilestoneDeleted;

  const MilestoneDetailsSection({
    super.key,
    required this.milestones,
    required this.requireDeposit,
    required this.depositAmountController,
    required this.onDepositToggled,
    required this.onMilestoneAdded,
    required this.onMilestoneEdited,
    required this.onMilestoneDeleted,
  });

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditMilestoneBottomSheet(
        onSave: onMilestoneAdded,
      ),
    );
  }

  void _openEditSheet(BuildContext context, Milestone milestone) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddEditMilestoneBottomSheet(
        existing: milestone,
        onSave: onMilestoneEdited,
        onDelete: () => onMilestoneDeleted(milestone.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Milestone details',
                style: context.theme.fonts.textBaseMedium),
            GestureDetector(
              onTap: () => _openAddSheet(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: context.theme.colors.fillTertiary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Add milestone',
                  style: context.theme.fonts.textSmMedium,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (milestones.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: context.theme.colors.bgB1,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.theme.colors.strokeSecondary),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: context.theme.colors.textSecondary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You currently have no milestone added.',
                    style: context.theme.fonts.textMdRegular.copyWith(
                      color: context.theme.colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Column(
            children: milestones
                .map((m) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: _MilestoneTile(
                        milestone: m,
                        assetName: 'USDT',
                        onEdit: () => _openEditSheet(context, m),
                      ),
                    ))
                .toList(),
          ),
        SizedBox(height: 20.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: context.theme.colors.fillTertiary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text('Require a Deposit',
                    style: context.theme.fonts.textMdRegular),
              ),
              Switch(
                value: requireDeposit,
                onChanged: onDepositToggled,
                activeThumbColor: Colors.white,
                activeTrackColor: context.theme.colors.brandDefault,
              ),
            ],
          ),
        ),
        if (requireDeposit) ...[
          SizedBox(height: 12.h),
          AppTextField(
            controller: depositAmountController,
            hintText: 'Enter amount',
            keyboardType: TextInputType.number,
            prefixType: PrefixType.none,
          ),
        ],
      ],
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  final Milestone milestone;
  final String assetName;
  final VoidCallback onEdit;

  const _MilestoneTile({
    required this.milestone,
    required this.assetName,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.theme.colors.bgB1,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: context.theme.colors.strokeSecondary.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ellipsify(word: milestone.name),
                  style: context.theme.fonts.textMdSemiBold,
                  maxLines: 1,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Due by: ${milestone.dueDate}',
                  style: context.theme.fonts.textSmRegular.copyWith(
                    color: context.theme.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${milestone.amount} $assetName',
            style: context.theme.fonts.textMdSemiBold,
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onEdit,
            child: Icon(
              Icons.open_in_new_rounded,
              size: 18.sp,
              color: context.theme.colors.graySecondary,
            ),
          ),
        ],
      ),
    );
  }
}

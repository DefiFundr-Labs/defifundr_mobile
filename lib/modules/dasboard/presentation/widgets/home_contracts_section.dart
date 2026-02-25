import 'package:defifundr_mobile/core/design_system/color_extension/app_color_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/widgets/home_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractItem {
  final String initials;
  final String title;
  final String subtitle;
  final String amount;
  final String status;

  const ContractItem({
    required this.initials,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
  });
}

class HomeContractsSection extends StatelessWidget {
  final List<ContractItem> contracts;
  final bool hasData;

  const HomeContractsSection({
    super.key,
    required this.contracts,
    required this.hasData,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return Column(
      children: [
        const HomeSectionHeader(title: 'Contracts'),
        SizedBox(height: 8.h),
        hasData
            ? Container(
                decoration: BoxDecoration(
                  color: isLightMode ? colors.bgB0 : colors.bgB1,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: contracts.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    thickness: 0.5,
                    color: colors.strokeSecondary,
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemBuilder: (context, index) =>
                      _ContractListItem(contract: contracts[index]),
                ),
              )
            : HomeEmptyState(
                imagePath: Assets.icons.emptyQuickpayIcon,
                message: 'Contracts will appear here',
              ),
      ],
    );
  }
}

class _ContractListItem extends StatelessWidget {
  final ContractItem contract;

  const _ContractListItem({required this.contract});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final avatarColor = getAvatarColor(contract.title);
    final statusColor = getStatusColor(contract.status, colors);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: avatarColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                contract.initials,
                style: fonts.textSmSemiBold.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contract.title,
                  style: fonts.textBaseSemiBold.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  contract.subtitle,
                  style: fonts.textSmRegular.copyWith(
                    color: colors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                contract.amount,
                style: fonts.textBaseSemiBold.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    contract.status,
                    style: fonts.textSmRegular.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getAvatarColor(String seed) {
  const palette = [
    Color(0xFFE53E3E),
    Color(0xFFED8936),
    Color(0xFF38A169),
    Color(0xFF3182CE),
    Color(0xFF805AD5),
    Color(0xFFD53F8C),
    Color(0xFF319795),
    Color(0xFFDD6B20),
  ];
  final hash = seed.codeUnits.fold<int>(0, (prev, c) => prev + c);
  return palette[hash % palette.length];
}

Color getStatusColor(String status, AppColorExtension colors) {
  switch (status.toLowerCase()) {
    case 'active':
    case 'successful':
      return colors.greenDefault;
    case 'pending':
    case 'processing':
      return colors.orangeDefault;
    case 'overdue':
    case 'failed':
      return colors.redDefault;
    default:
      return colors.textSecondary;
  }
}

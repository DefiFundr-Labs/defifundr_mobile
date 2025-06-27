import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/checkbox_status.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/slide_up_panel.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/widgets/time_filter_radio.dart';
import 'package:defifundr_mobile/core/shared/common_ui/buttons/primary_button.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/widgets/brand_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/model/quick_payments.dart';

class SearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueNotifier<bool> isPanelVisible;
  final ValueNotifier<TimeRange?> selectedTimeRange;
  final ValueNotifier<Map<QuickPaymentsStatus, bool?>?> statusFilter;

  const SearchAndFilterBar({
    super.key,
    required this.searchController,
    required this.isPanelVisible,
    required this.selectedTimeRange,
    required this.statusFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: searchController,
              style: context.theme.fonts.textBaseRegular
                  .copyWith(color: context.theme.colors.textTertiary),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: context.theme.fonts.textBaseRegular
                    .copyWith(color: context.theme.colors.textTertiary),
                filled: true,
                fillColor: context.theme.colors.bgB0,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: SvgPicture.asset(
                    AppAssets.magnifyingGlass,
                    colorFilter: ColorFilter.mode(
                      resolveColor(
                        context: context,
                        lightColor: context.theme.colors.textTertiary,
                        darkColor: context.theme.colors.textTertiary,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.theme.colors.strokeSecondary,
                    width: 0.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.theme.colors.strokeSecondary,
                    width: 0.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: context.theme.colors.strokeSecondary,
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () async {
            isPanelVisible.value = true;
            await slideUpPanel(
              context,
              _buildFilterPanel(context),
              canDismiss: true,
              onDismiss: () => isPanelVisible.value = false,
            );
          },
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.theme.colors.bgB0,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: context.theme.colors.strokeSecondary,
                width: 0.5,
              ),
            ),
            child: SvgPicture.asset(
              AppAssets.filterIcon,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPanel(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset(
                AppAssets.rectangleSvg,
                color: resolveColor(
                  context: context,
                  lightColor: context.theme.colors.contrastBlack,
                  darkColor: context.theme.colors.contrastBlack,
                ),
              ),
            ),
            const SizedBox(height: 11),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filter by',
                style: context.theme.fonts.heading2Bold.copyWith(
                    fontFamily: 'HankenGrotesk',
                    color: context.theme.colors.textPrimary),
              ),
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: context.theme.colors.textPrimary,
                title:
                    Text('Status', style: context.theme.fonts.textBaseSemiBold),
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                children: [
                  CheckBoxStatus(
                    onChanged: (value) => statusFilter.value = value,
                  ),
                ],
              ),
            ),
            Divider(
              color: context.theme.colors.strokeSecondary,
              height: 1,
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: context.theme.colors.textPrimary,
                title:
                    Text('Date', style: context.theme.fonts.textBaseSemiBold),
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                children: [
                  TimeFilterRadio(
                    onChanged: (selected) => selectedTimeRange.value = selected,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PrimaryButton(
                    textColor: context.theme.colors.textPrimary,
                    color: context.theme.colors.fillTertiary.withOpacity(0.08),
                    text: "Clear all",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BrandButton(
                    text: "Show results",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

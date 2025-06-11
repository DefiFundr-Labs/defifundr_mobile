import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/widgets/filter_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterPanel extends StatelessWidget {
  final List<Widget> sections;
  final Function() onClear;
  final Function() onShowResults;

  const FilterPanel({
    super.key,
    required this.sections,
    required this.onClear,
    required this.onShowResults,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: Column(
          children: [
            const SizedBox(height: 8),
            SvgPicture.asset(
              AppAssets.rectangleSvg,
              width: 48,
              height: 5,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filter by',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'HankenGrotesk',
                  fontWeight: FontWeight.w700,
                  height: 32 / 24,
                  letterSpacing: 0,
                  color: resolveColor(
                    context: context,
                    lightColor: AppColors.textPrimary,
                    darkColor: AppColorDark.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...sections,
            const SizedBox(height: 24),
            FilterPanelFooter(
              onClear: onClear,
              onShowResults: onShowResults,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FilterSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: resolveColor(
                  context: context,
                  lightColor: AppColors.textPrimary,
                  darkColor: AppColorDark.textPrimary,
                ),
              ),
            ),
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            children: children,
          ),
        ),
        Divider(
          color: resolveColor(
            context: context,
            lightColor:
                AppColors.strokeSecondary.withAlpha((0.06 * 255).toInt()),
            darkColor:
                AppColorDark.strokeSecondary.withAlpha((0.32 * 255).toInt()),
          ),
          height: 1,
        ),
      ],
    );
  }
}

class FilterPanelFooter extends StatelessWidget {
  final Function() onClear;
  final Function() onShowResults;

  const FilterPanelFooter({
    super.key,
    required this.onClear,
    required this.onShowResults,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmallButton(
          backgroundColor: resolveColor(
            context: context,
            lightColor:
                AppColors.strokeSecondary.withAlpha((0.08 * 255).toInt()),
            darkColor:
                AppColorDark.strokeSecondary.withAlpha((0.8 * 255).toInt()),
          ),
          textColor: resolveColor(
            context: context,
            lightColor: AppColors.textPrimary,
            darkColor: AppColorDark.textPrimary,
          ),
          text: "Clear all",
          onPressed: onClear,
        ),
        SmallButton(
          text: "Show results",
          onPressed: onShowResults,
        ),
      ],
    );
  }
}

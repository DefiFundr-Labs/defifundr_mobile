import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/constants/assets.dart';

class SearchAndFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;
  final VoidCallback? onFilterTap;

  const SearchAndFilterBar({
    Key? key,
    required this.searchController,
    this.hintText = 'Search',
    this.onFilterTap,
  }) : super(key: key);

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
                  ,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: context.theme.fonts.textBaseRegular
                    .copyWith(color: context.theme.colors.textTertiary),
                filled: true,
                fillColor: resolveColor(
                  context: context,
                  lightColor: AppColors.bgB1Base,
                  darkColor: AppColorDark.bgB1Base,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 8,
                  ),
                  child: SvgPicture.asset(
                    width: 20,
                    height: 20,
                    AppAssets.magnifyingGlass,
                    colorFilter: ColorFilter.mode(
                      resolveColor(
                        context: context,
                        lightColor: AppColors.grayTertiary,
                        darkColor: AppColorDark.grayTertiary,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: resolveColor(
                      context: context,
                      lightColor: AppColors.strokeSecondary,
                      darkColor: AppColorDark.strokeSecondary,
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: resolveColor(
                      context: context,
                      lightColor: AppColors.strokeSecondary,
                      darkColor: AppColorDark.strokeSecondary,
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: resolveColor(
                      context: context,
                      lightColor: AppColors.strokeSecondary,
                      darkColor: AppColorDark.strokeSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onFilterTap,
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: resolveColor(
                context: context,
                lightColor: AppColors.bgB1Base,
                darkColor: AppColorDark.bgB1Base,
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: resolveColor(
                  context: context,
                  lightColor: AppColors.strokeSecondary,
                  darkColor: AppColorDark.strokeSecondary,
                ),
              ),
            ),
            child: SvgPicture.asset(
              AppAssets.filterIcon,
              colorFilter: ColorFilter.mode(
                resolveColor(
                  context: context,
                  lightColor: AppColors.textPrimary,
                  darkColor: AppColorDark.textPrimary,
                ),
                BlendMode.srcIn,
              ),
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}

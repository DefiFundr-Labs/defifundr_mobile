import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/app_colors/app_colors.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchAndFilterBar extends StatelessWidget
    implements PreferredSizeWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Function()? onFilterTap;

  const SearchAndFilterBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                height: 1.5,
                letterSpacing: 0.0,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 1.5,
                  letterSpacing: 0.0,
                  color: resolveColor(
                    context: context,
                    lightColor: AppColors.textTertiary,
                    darkColor: AppColorDark.textTertiary,
                  ),
                ),
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
                  padding: const EdgeInsets.only(left: 16, right: 8),
                  child: SvgPicture.asset(
                    AppAssets.magnifyingGlass,
                    colorFilter: ColorFilter.mode(
                      resolveColor(
                        context: context,
                        lightColor: AppColors.textPrimary,
                        darkColor: AppColorDark.textPrimary,
                      ),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: resolveColor(
                      context: context,
                      lightColor: AppColors.strokeSecondary,
                      darkColor: AppColorDark.strokeSecondary,
                    ),
                    width: 0.5,
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
                    width: 0.5,
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
                    width: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
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
                width: 0.5,
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

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

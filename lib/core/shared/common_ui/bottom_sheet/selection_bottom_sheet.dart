import 'package:defifundr_mobile/core/constants/assets.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/enums/app_text_field_enums.dart';
import 'package:defifundr_mobile/core/shared/common_ui/textfield/app_text_field.dart';
import 'package:defifundr_mobile/core/utils/resolve_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectionBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final TextEditingController controller;

  const SelectionBottomSheet({
    Key? key,
    required this.controller,
    required this.title,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SvgPicture.asset(AppAssets.rectangleSvg)),
          const SizedBox(height: 11),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: context.theme.fonts.heading2Bold.copyWith(
                  fontFamily: 'HankenGrotesk',
                  color: context.theme.colors.textPrimary),
            ),
          ),
          const SizedBox(height: 12.0),
          AppTextField(
            controller: controller,
            labelText: 'Search',
            prefixType: PrefixType.customIcon,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12),
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                  child: itemBuilder(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

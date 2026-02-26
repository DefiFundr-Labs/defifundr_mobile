import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLanguage {
  final String name;
  final String flagPath;

  const AppLanguage({required this.name, required this.flagPath});
}

final _languages = [
  AppLanguage(
    name: 'Arabic',
    flagPath: Assets.icons.countryFlags.unitedArabEmirates,
  ),
  AppLanguage(
    name: 'Chinese (Mandarin)',
    flagPath: Assets.icons.countryFlags.china,
  ),
  AppLanguage(
    name: 'English (UK)',
    flagPath: Assets.icons.countryFlags.unitedKingdom,
  ),
  AppLanguage(
    name: 'English (United States)',
    flagPath: Assets.icons.countryFlags.unitedStates,
  ),
  AppLanguage(
    name: 'French',
    flagPath: Assets.icons.countryFlags.france,
  ),
  AppLanguage(
    name: 'German',
    flagPath: Assets.icons.countryFlags.germany,
  ),
  AppLanguage(
    name: 'Italian',
    flagPath: Assets.icons.countryFlags.italy,
  ),
  AppLanguage(
    name: 'Japanese',
    flagPath: Assets.icons.countryFlags.japan,
  ),
  AppLanguage(
    name: 'Portuguese',
    flagPath: Assets.icons.countryFlags.portugal,
  ),
];

void showAppLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _AppLanguageSheet(),
  );
}

class _AppLanguageSheet extends StatefulWidget {
  const _AppLanguageSheet();

  @override
  State<_AppLanguageSheet> createState() => _AppLanguageSheetState();
}

class _AppLanguageSheetState extends State<_AppLanguageSheet> {
  // English (UK) selected by default (index 2)
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final bottomInset = MediaQuery.systemGestureInsetsOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: isLight ? Colors.white : colors.bgB1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: colors.grayTertiary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'App language',
                style: fonts.heading2Bold.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Language list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _languages.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                thickness: 0.5,
                color: isLight ? colors.bgB2 : colors.bgB2,
              ),
              itemBuilder: (context, index) {
                final lang = _languages[index];
                final isSelected = _selectedIndex == index;

                return InkWell(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(
                      children: [
                        // Flag
                        ClipOval(
                          child: SvgPicture.asset(
                            lang.flagPath,
                            width: 36.w,
                            height: 36.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),

                        // Language name
                        Expanded(
                          child: Text(
                            lang.name,
                            style: fonts.textBaseMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                        ),

                        // Radio button
                        _RadioDot(isSelected: isSelected),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Continue button
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, bottomInset + 24.h),
            child: PrimaryButton(
              text: 'Continue',
              isEnabled: true,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool isSelected;

  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Container(
      width: 22.w,
      height: 22.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colors.brandDefault : colors.grayTertiary,
          width: isSelected ? 6 : 1.5,
        ),
        color: Colors.white,
      ),
    );
  }
}

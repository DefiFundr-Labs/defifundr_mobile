import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/theme_cubit.dart';
import 'package:defifundr_mobile/core/extensions/l10n_extension.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/theme_enum.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/core/services/app_icon_service.dart';
import 'package:defifundr_mobile/core/shared/common/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _AppTheme { light, dark, system }

@RoutePage()
class AppAppearanceScreen extends StatefulWidget {
  const AppAppearanceScreen({super.key});

  @override
  State<AppAppearanceScreen> createState() => _AppAppearanceScreenState();
}

class _AppAppearanceScreenState extends State<AppAppearanceScreen> {
  late _AppTheme _selectedTheme;
  int _selectedIconIndex = 0;
  int _activeIconIndex = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Initialise theme selection from the current cubit state
    final current = context.read<ThemeCubit>().state.themeMode;
    _selectedTheme = _themeModeToAppTheme(current);
  }

  _AppTheme _themeModeToAppTheme(ThemeModeEnum mode) {
    switch (mode) {
      case ThemeModeEnum.light:
        return _AppTheme.light;
      case ThemeModeEnum.dark:
        return _AppTheme.dark;
      case ThemeModeEnum.system:
        return _AppTheme.system;
    }
  }

  ThemeModeEnum _appThemeToModeEnum(_AppTheme theme) {
    switch (theme) {
      case _AppTheme.light:
        return ThemeModeEnum.light;
      case _AppTheme.dark:
        return ThemeModeEnum.dark;
      case _AppTheme.system:
        return ThemeModeEnum.system;
    }
  }

  static const List<String> _appIcons = [
    'assets/images/app_icons/Image.png',
    'assets/images/app_icons/Image-1.png',
    'assets/images/app_icons/Image-2.png',
    'assets/images/app_icons/Image-3.png',
    'assets/images/app_icons/Image-4.png',
    'assets/images/app_icons/Image-5.png',
  ];

  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);

    // Apply theme change immediately via cubit
    context.read<ThemeCubit>().setTheme(_appThemeToModeEnum(_selectedTheme));

    // Apply icon change if it differs from the active one
    if (_selectedIconIndex != _activeIconIndex) {
      try {
        final supports = await AppIconService.supportsAlternateIcons;
        if (supports) {
          await AppIconService.setIconByIndex(_selectedIconIndex);
          setState(() => _activeIconIndex = _selectedIconIndex);
        }
      } on PlatformException {
        // Icon change not supported or failed — proceed without changing
      }
    }

    setState(() => _isSaving = false);
    if (mounted) {
      // ignore: use_build_context_synchronously
      context.router.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: isLight ? colors.bgB1 : colors.bgB0,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      l10n.appAppearance,
                      style: context.theme.textTheme.headlineLarge?.copyWith(
                        fontSize: 24.sp,
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      l10n.appAppearanceSubtitle,
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 28.h),

                    // Theme section
                    Text(
                      l10n.theme,
                      style: fonts.textSmRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isLight ? colors.bgB0 : colors.bgB1,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _ThemeCard(
                              label: 'Light',
                              isSelected: _selectedTheme == _AppTheme.light,
                              themeType: _AppTheme.light,
                              onTap: () =>
                                  setState(() => _selectedTheme = _AppTheme.light),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _ThemeCard(
                              label: 'Dark',
                              isSelected: _selectedTheme == _AppTheme.dark,
                              themeType: _AppTheme.dark,
                              onTap: () =>
                                  setState(() => _selectedTheme = _AppTheme.dark),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _ThemeCard(
                              label: 'System',
                              isSelected: _selectedTheme == _AppTheme.system,
                              themeType: _AppTheme.system,
                              onTap: () =>
                                  setState(() => _selectedTheme = _AppTheme.system),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // App icon section
                    Text(
                      l10n.appIcon,
                      style: fonts.textSmRegular.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isLight ? colors.bgB0 : colors.bgB1,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: _appIcons.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedIconIndex == index;
                          return _AppIconCard(
                            assetPath: _appIcons[index],
                            isSelected: isSelected,
                            isActive: index == _activeIconIndex,
                            onTap: () =>
                                setState(() => _selectedIconIndex = index),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
              child: PrimaryButton(
                text: _isSaving ? l10n.saving : l10n.saveChanges,
                isEnabled: !_isSaving,
                onPressed: _saveChanges,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colors = context.theme.colors;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.icons.arrowBack,
            colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
            width: 24.w,
            height: 24.w,
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final _AppTheme themeType;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.label,
    required this.isSelected,
    required this.themeType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? colors.brandDefault : colors.bgB2,
                width: isSelected ? 2 : 1,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: _buildPhoneMockup(context),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: fonts.textSmRegular.copyWith(
              color: isSelected ? colors.brandDefault : colors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneMockup(BuildContext context) {
    switch (themeType) {
      case _AppTheme.light:
        return _MockupFrame(isDark: false);
      case _AppTheme.dark:
        return _MockupFrame(isDark: true);
      case _AppTheme.system:
        return Row(
          children: [
            Expanded(child: _MockupFrame(isDark: false, isHalf: true)),
            Expanded(child: _MockupFrame(isDark: true, isHalf: true)),
          ],
        );
    }
  }
}

class _MockupFrame extends StatelessWidget {
  final bool isDark;
  final bool isHalf;

  const _MockupFrame({required this.isDark, this.isHalf = false});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final lineColor =
        isDark ? const Color(0xFF2E2E2E) : const Color(0xFFE8E8E8);

    return Container(
      color: bg,
      padding: EdgeInsets.all(isHalf ? 4.w : 6.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 6.h, decoration: BoxDecoration(color: lineColor, borderRadius: BorderRadius.circular(3.r))),
          SizedBox(height: 4.h),
          Container(height: 6.h, decoration: BoxDecoration(color: lineColor, borderRadius: BorderRadius.circular(3.r))),
          SizedBox(height: 4.h),
          Container(height: 6.h, width: double.infinity * 0.6, decoration: BoxDecoration(color: lineColor, borderRadius: BorderRadius.circular(3.r))),
          SizedBox(height: 4.h),
          Container(height: 6.h, decoration: BoxDecoration(color: lineColor, borderRadius: BorderRadius.circular(3.r))),
        ],
      ),
    );
  }
}

class _AppIconCard extends StatelessWidget {
  final String assetPath;
  final bool isSelected;
  final bool isActive;
  final VoidCallback onTap;

  const _AppIconCard({
    required this.assetPath,
    required this.isSelected,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected ? colors.brandDefault : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            isActive ? context.l10n.active : '',
            style: fonts.textXsRegular.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      inheritNavigatorObservers: false,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final colors = context.theme.colors;
        final fonts = context.theme.fonts;

        // Hide the bottom nav bar when the user has navigated deeper than the
        // root screen of any tab (e.g. Withdraw, Asset Details, More sub-screens).
        final activeTabRouter =
            tabsRouter.stackRouterOfIndex(tabsRouter.activeIndex);
        final isAtTabRoot = (activeTabRouter?.pageCount ?? 1) <= 1;
        final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

        return Scaffold(
          body: child,
          bottomNavigationBar: isAtTabRoot
              ? Container(
                  decoration: BoxDecoration(
                    color: colors.bgB1,
                    border: Border(
                      top: BorderSide(
                        color: colors.grayQuaternary,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 8 + bottomPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          _tabs.length,
                          (index) => _BottomNavItem(
                            tab: _tabs[index],
                            isActive: tabsRouter.activeIndex == index,
                            onTap: () => tabsRouter.setActiveIndex(index),
                            colors: colors,
                            fonts: fonts,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }
}

class _TabDefinition {
  final String label;
  final String activeIcon;
  final String inactiveIcon;

  const _TabDefinition({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}

 final _tabs = [
  _TabDefinition(
    label: 'Home',
    activeIcon: Assets.icons.bottomNav.homeActive,
    inactiveIcon: Assets.icons.bottomNav.homeInactive,
  ),
  _TabDefinition(
    label: 'Workspace',
    activeIcon: Assets.icons.bottomNav.workspaceActive,
    inactiveIcon: Assets.icons.bottomNav.workspaceInactive,
  ),
    _TabDefinition(
    label: 'Finance',
    activeIcon: Assets.icons.bottomNav.financeActive,
    inactiveIcon: Assets.icons.bottomNav.financeInactive,
  ),
  _TabDefinition(
    label: 'More',
    activeIcon: Assets.icons.bottomNav.moreActive,
    inactiveIcon: Assets.icons.bottomNav.moreInactive,
  ),
];

class _BottomNavItem extends StatelessWidget {
  final _TabDefinition tab;
  final bool isActive;
  final VoidCallback onTap;
  final dynamic colors;
  final dynamic fonts;

  const _BottomNavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.colors,
    required this.fonts,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isActive ? tab.activeIcon : tab.inactiveIcon,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? colors.brandDefault
                    : colors.textSecondary,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

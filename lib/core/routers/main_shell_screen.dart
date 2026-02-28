import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
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

        return Scaffold(
          body: child,
          bottomNavigationBar: isAtTabRoot
              ? Container(
                  decoration: BoxDecoration(
                    color: colors.bgB0,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
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

const _tabs = [
  _TabDefinition(
    label: 'Home',
    activeIcon: 'assets/icons/bottom_nav/home_active.svg',
    inactiveIcon: 'assets/icons/bottom_nav/home_inactive.svg',
  ),
  _TabDefinition(
    label: 'Workspace',
    activeIcon: 'assets/icons/bottom_nav/workspace_active.svg',
    inactiveIcon: 'assets/icons/bottom_nav/workspace_inactive.svg',
  ),
    _TabDefinition(
    label: 'Finance',
    activeIcon: 'assets/icons/bottom_nav/finance_active.svg',
    inactiveIcon: 'assets/icons/bottom_nav/finance_inactive.svg',
  ),
  _TabDefinition(
    label: 'More',
    activeIcon: 'assets/icons/bottom_nav/more_active.svg',
    inactiveIcon: 'assets/icons/bottom_nav/more_inactive.svg',
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

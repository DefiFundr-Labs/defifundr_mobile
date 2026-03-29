import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A tab definition used by [AppTabs].
class AppTab {
  const AppTab({required this.label, required this.content});

  /// Tab button label.
  final String label;

  /// Content rendered when this tab is active.
  final Widget content;
}

/// A design-system-consistent tab bar + tab body.
///
/// Wraps [TabBar] + [TabBarView] with brand colors, removing the need to
/// configure indicator, label styles, and unselected colors at every call site.
///
/// ```dart
/// AppTabs(
///   tabs: [
///     AppTab(label: 'All', content: _AllList()),
///     AppTab(label: 'Pending', content: _PendingList()),
///     AppTab(label: 'Paid', content: _PaidList()),
///   ],
/// )
///
/// // Controlled — manage the tab index yourself
/// AppTabs(
///   controller: _tabController,
///   tabs: [...],
/// )
/// ```
class AppTabs extends StatefulWidget {
  const AppTabs({
    super.key,
    required this.tabs,
    this.controller,
    this.initialIndex = 0,
    this.onTabChanged,
    this.tabBarPadding,
  });

  /// List of tabs to render. Must have at least 2.
  final List<AppTab> tabs;

  /// Optional external [TabController]. When provided [initialIndex] and
  /// [onTabChanged] are ignored — manage them on the controller directly.
  final TabController? controller;

  /// Initial active tab index when using the internal controller. Defaults to `0`.
  final int initialIndex;

  /// Callback fired whenever the active tab changes (only used with internal controller).
  final ValueChanged<int>? onTabChanged;

  /// Horizontal padding around the [TabBar]. Defaults to `EdgeInsets.zero`.
  final EdgeInsetsGeometry? tabBarPadding;

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> with SingleTickerProviderStateMixin {
  TabController? _internal;

  TabController get _controller => widget.controller ?? _internal!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internal = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.initialIndex,
      );
      _internal!.addListener(() {
        if (!_internal!.indexIsChanging) {
          widget.onTabChanged?.call(_internal!.index);
        }
      });
    }
  }

  @override
  void dispose() {
    _internal?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.tabBarPadding ?? EdgeInsets.zero,
          child: TabBar(
            controller: _controller,
            indicatorColor: colors.brandDefault,
            indicatorWeight: 2,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: colors.brandDefault,
            unselectedLabelColor: colors.textTertiary,
            labelStyle: fonts.textBaseMedium,
            unselectedLabelStyle: fonts.textBaseRegular,
            dividerColor: colors.strokePrimary,
            tabs: widget.tabs
                .map((t) => Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text(t.label),
                      ),
                    ))
                .toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: widget.tabs.map((t) => t.content).toList(),
          ),
        ),
      ],
    );
  }
}

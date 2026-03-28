import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A single collapsible section item used inside [AppAccordion].
class AppAccordionItem {
  const AppAccordionItem({
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  });

  /// Header label shown when collapsed and expanded.
  final String title;

  /// Body widget revealed when expanded.
  final Widget content;

  /// Whether this item starts expanded. Defaults to `false`.
  final bool initiallyExpanded;
}

/// A list of collapsible accordion sections styled with design-system tokens.
///
/// Replaces raw `ExpansionTile` usages that had no consistent styling.
/// Each item shows a chevron that rotates on expand/collapse.
///
/// ```dart
/// AppAccordion(
///   items: [
///     AppAccordionItem(
///       title: 'How do I add a wallet?',
///       content: Text('Go to Settings → Manage Wallets and tap Add.'),
///     ),
///     AppAccordionItem(
///       title: 'What currencies are supported?',
///       content: Text('We support ETH, USDC, and USDT on EVM chains.'),
///       initiallyExpanded: true,
///     ),
///   ],
/// )
///
/// // Single-expand mode (closing others when one opens)
/// AppAccordion(
///   singleExpand: true,
///   items: [...],
/// )
/// ```
class AppAccordion extends StatefulWidget {
  const AppAccordion({
    super.key,
    required this.items,
    this.singleExpand = false,
    this.showDividers = true,
  });

  /// The accordion sections to render.
  final List<AppAccordionItem> items;

  /// When `true`, expanding one section collapses all others. Defaults to `false`.
  final bool singleExpand;

  /// Whether to draw dividers between sections. Defaults to `true`.
  final bool showDividers;

  @override
  State<AppAccordion> createState() => _AppAccordionState();
}

class _AppAccordionState extends State<AppAccordion> {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.items.map((i) => i.initiallyExpanded).toList();
  }

  void _toggle(int index) {
    setState(() {
      if (widget.singleExpand) {
        for (int i = 0; i < _expanded.length; i++) {
          _expanded[i] = i == index ? !_expanded[index] : false;
        }
      } else {
        _expanded[index] = !_expanded[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.bgB0,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.strokePrimary),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.items.length, (i) {
          final isLast = i == widget.items.length - 1;
          return _AccordionSection(
            item: widget.items[i],
            isExpanded: _expanded[i],
            onToggle: () => _toggle(i),
            showDivider: widget.showDividers && !isLast,
          );
        }),
      ),
    );
  }
}

class _AccordionSection extends StatelessWidget {
  const _AccordionSection({
    required this.item,
    required this.isExpanded,
    required this.onToggle,
    required this.showDivider,
  });

  final AppAccordionItem item;
  final bool isExpanded;
  final VoidCallback onToggle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final fonts = context.theme.fonts;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(12.r),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: fonts.textBaseMedium
                        .copyWith(color: colors.textPrimary),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colors.textTertiary,
                    size: 20.w,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
            child: item.content,
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        if (showDivider)
          Divider(height: 1, thickness: 1, color: colors.strokePrimary),
      ],
    );
  }
}

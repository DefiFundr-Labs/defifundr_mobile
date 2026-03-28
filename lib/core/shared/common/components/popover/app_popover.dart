import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Controls and exposes the [AppPopover] overlay to descendants.
///
/// ```dart
/// final _controller = AppPopoverController();
///
/// AppPopover(
///   controller: _controller,
///   content: _FilterPanel(),
///   child: AppIconButton(
///     svgPath: Assets.icons.filter,
///     onPressed: _controller.toggle,
///   ),
/// )
/// ```
class AppPopoverController {
  _AppPopoverState? _state;

  void open() => _state?.open();
  void close() => _state?.close();
  void toggle() => _state?.toggle();
  bool get isOpen => _state?._isOpen ?? false;
}

/// Floating contextual overlay anchored to a [child] widget, inspired by
/// shadcn's `Popover` component.
///
/// The popover floats above/below the child using an [OverlayEntry] and
/// auto-dismisses when the user taps outside. Provide an
/// [AppPopoverController] to open/close it programmatically.
///
/// ```dart
/// // Controlled via controller
/// AppPopover(
///   controller: _controller,
///   content: Padding(
///     padding: EdgeInsets.all(16.w),
///     child: Column(
///       mainAxisSize: MainAxisSize.min,
///       children: [
///         AppListTile(title: 'Edit', onTap: _edit),
///         AppListTile(title: 'Delete', titleColor: colors.redDefault, onTap: _delete),
///       ],
///     ),
///   ),
///   child: AppIconButton(svgPath: Assets.icons.more, onPressed: _controller.toggle),
/// )
///
/// // Trigger built into the popover (no external controller needed)
/// AppPopover.trigger(
///   content: _OptionsPanel(),
///   triggerBuilder: (open) => AppIconButton(
///     svgPath: Assets.icons.more,
///     onPressed: open,
///   ),
/// )
/// ```
class AppPopover extends StatefulWidget {
  const AppPopover({
    super.key,
    required this.child,
    required this.content,
    this.controller,
    this.width = 200,
    this.preferBelow = true,
  });

  /// The anchor widget. The popover is positioned relative to this.
  final Widget child;

  /// Content shown inside the floating card.
  final Widget content;

  /// Optional controller for programmatic open/close/toggle.
  final AppPopoverController? controller;

  /// Width of the floating card in dp. Defaults to `200`.
  final double width;

  /// Whether to prefer positioning the popover below the anchor.
  /// Falls back to above when there isn't enough space. Defaults to `true`.
  final bool preferBelow;

  @override
  State<AppPopover> createState() => _AppPopoverState();
}

class _AppPopoverState extends State<AppPopover> {
  OverlayEntry? _entry;
  final _layerLink = LayerLink();
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    widget.controller?._state = this;
  }

  @override
  void dispose() {
    _removeEntry();
    widget.controller?._state = null;
    super.dispose();
  }

  void open() {
    if (_isOpen) return;
    _isOpen = true;
    _entry = _buildEntry();
    Overlay.of(context).insert(_entry!);
  }

  void close() {
    if (!_isOpen) return;
    _isOpen = false;
    _removeEntry();
  }

  void toggle() => _isOpen ? close() : open();

  void _removeEntry() {
    _entry?.remove();
    _entry = null;
  }

  OverlayEntry _buildEntry() {
    final colors = context.theme.colors;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          // Dismiss tap target
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: close,
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, widget.preferBelow ? size.height + 4 : 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: widget.width.w,
                  decoration: BoxDecoration(
                    color: colors.bgB0,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colors.strokePrimary),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: widget.content,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: widget.child,
    );
  }
}

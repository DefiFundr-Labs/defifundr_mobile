import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A pinned bottom action bar for screens that have a primary action button
/// at the bottom (form screens, confirmation screens, onboarding flows, etc.).
///
/// Handles horizontal padding, bottom safe-area inset, and optional top border.
/// Wrap the main `body` in a `Column` with `Expanded` for the scrollable content
/// and `AppBottomActionBar` as the last child (NOT inside the scroll).
///
/// ```dart
/// body: SafeArea(
///   child: Column(
///     children: [
///       Expanded(child: SingleChildScrollView(...)),
///       AppBottomActionBar(
///         child: PrimaryButton(text: 'Continue', onPressed: onNext),
///       ),
///     ],
///   ),
/// ),
///
/// // Multiple actions (e.g., primary + secondary)
/// AppBottomActionBar(
///   child: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       PrimaryButton(text: 'Confirm', onPressed: onConfirm),
///       SizedBox(height: 12.h),
///       SecondaryButton(text: 'Cancel', onPressed: onCancel),
///     ],
///   ),
/// )
/// ```
class AppBottomActionBar extends StatelessWidget {
  const AppBottomActionBar({
    super.key,
    required this.child,
    this.padding,
    this.showTopBorder = false,
    this.backgroundColor,
  });

  /// The action widget(s) to display — typically a [PrimaryButton] or a
  /// [Column] of buttons.
  final Widget child;

  /// Override the default padding.
  /// Defaults to `EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h)`.
  final EdgeInsetsGeometry? padding;

  /// Whether to draw a hairline separator above the bar. Defaults to `false`.
  final bool showTopBorder;

  /// Background color. Transparent by default so the scaffold colour shows through.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTopBorder)
            Divider(height: 1, thickness: 1, color: Colors.black12),
          Padding(
            padding: padding ??
                EdgeInsets.fromLTRB(
                  20.w,
                  8.h,
                  20.w,
                  (bottomInset > 0 ? bottomInset : 16.h),
                ),
            child: child,
          ),
        ],
      ),
    );
  }
}

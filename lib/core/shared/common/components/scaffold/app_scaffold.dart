import 'package:defifundr_mobile/core/design_system/theme_extension/app_theme_extension.dart';
import 'package:defifundr_mobile/core/shared/common/appbar/appbar.dart';
import 'package:defifundr_mobile/core/shared/common/components/scaffold/app_bottom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The standard single-screen layout for defifundr.
///
/// Provides three named slots that cover the pattern used on 60+ screens:
/// an optional app bar, a scrollable body, and an optional pinned bottom action.
///
/// The scaffold handles:
/// - Theme-aware background color (`bgB1` light / `bgB0` dark)
/// - `SafeArea` wrapping
/// - Scroll behaviour (`SingleChildScrollView` + `Expanded`)
/// - Bottom safe-area inset (via [AppBottomActionBar])
///
/// ### Layouts
///
/// **Form / list screen** (most common):
/// ```dart
/// AppScaffold(
///   title: 'Personal Details',
///   body: Column(children: [...fields]),
///   bottomAction: PrimaryButton(text: 'Continue', onPressed: onNext),
/// )
/// ```
///
/// **Centred / splash screen** (use [centreBody]):
/// ```dart
/// AppScaffold(
///   title: '',
///   centreBody: true,
///   body: Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       AppCircleIconBadge(svgPath: Assets.icons.shieldStar),
///       SizedBox(height: 32.h),
///       AppPageHeader(title: 'Set Up 2FA', subtitle: '...', textAlign: TextAlign.center),
///     ],
///   ),
///   bottomAction: PrimaryButton(text: 'Activate Now', onPressed: onActivate),
/// )
/// ```
///
/// **Custom app bar** (pass [appBar] to replace the default):
/// ```dart
/// AppScaffold(
///   appBar: DeFiRaiseAppBar(isBack: true, title: 'Wallet', actions: [...]),
///   body: ...,
/// )
/// ```
///
/// **No app bar** (pass [showAppBar]: false):
/// ```dart
/// AppScaffold(
///   showAppBar: false,
///   body: ...,
/// )
/// ```
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.appBar,
    this.showAppBar = true,
    this.bottomAction,
    this.centreBody = false,
    this.horizontalPadding = 24,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  /// Primary scrollable content.
  final Widget body;

  /// Title passed to the default [DeFiRaiseAppBar]. Ignored when [appBar] is set.
  final String? title;

  /// Override the entire app bar. When provided, [title] and [showAppBar] are
  /// ignored.
  final PreferredSizeWidget? appBar;

  /// Whether to render the default [DeFiRaiseAppBar]. Defaults to `true`.
  /// Set to `false` for full-bleed screens that manage their own header.
  final bool showAppBar;

  /// Widget rendered inside [AppBottomActionBar]. Typically a [PrimaryButton]
  /// or a `Column` of buttons. When null no bottom bar is shown.
  final Widget? bottomAction;

  /// When `true`, [body] is vertically centred using `Spacer` widgets instead
  /// of being top-aligned. Use this for splash, success, and info screens.
  /// Defaults to `false`.
  final bool centreBody;

  /// Horizontal padding applied to [body]. Defaults to `24`.
  /// Set to `0` for edge-to-edge content (handle padding inside [body]).
  final double horizontalPadding;

  /// Scaffold background color.
  /// Defaults to `colors.bgB1` (light) / `colors.bgB0` (dark).
  final Color? backgroundColor;

  /// Passed directly to [Scaffold.resizeToAvoidBottomInset]. Defaults to `true`.
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final isDark = context.isDarkMode;

    final effectiveAppBar = appBar ??
        (showAppBar
            ? DeFiRaiseAppBar(isBack: true, title: title ?? '')
            : null);

    final paddedBody = horizontalPadding > 0
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
            child: body,
          )
        : body;

    final scrollableBody = centreBody
        ? Column(
            children: [
              const Spacer(),
              paddedBody,
              const Spacer(),
            ],
          )
        : SingleChildScrollView(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            child: paddedBody,
          );

    return Scaffold(
      backgroundColor: backgroundColor ?? (isDark ? colors.bgB0 : colors.bgB1),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: effectiveAppBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: scrollableBody),
            if (bottomAction != null)
              AppBottomActionBar(child: bottomAction!),
          ],
        ),
      ),
    );
  }
}

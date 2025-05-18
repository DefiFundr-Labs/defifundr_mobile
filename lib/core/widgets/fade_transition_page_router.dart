import 'package:flutter/material.dart';

class FadeTransitionPage extends Page {
  /// The color to use for the modal barrier. If this is null, the barrier will be transparent.
  ///
  /// The modal barrier is the scrim that is rendered behind each route, which generally prevents the user from interacting with the route below the current route, and normally partially obscures such routes.
  final Color? barrierColor;

  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if accessibility tools (like VoiceOver on iOS) focus on the barrier.
  final String? barrierLabel;

  ///   Whether the route should remain in memory when it is inactive.
  ///
  /// If this is true, then the route is maintained, so that any futures it is holding from the next route will properly resolve when the next route pops. If this is not necessary, this can be set to false to allow the framework to entirely discard the route's widget hierarchy when it is not visible.
  final bool maintainState;

  ///The duration the transition going forwards.
  final Duration transitionDuration;

  final Widget child;

  FadeTransitionPage({
    required this.child,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 300),
    required super.key,
  });
  @override
  Route createRoute(BuildContext context) {
    return _FadeTransitionPageRoute(this);
  }
}

class _FadeTransitionPageRoute extends PageRoute {
  final FadeTransitionPage page;
  _FadeTransitionPageRoute(this.page) : super(settings: page);

  @override
  Color? get barrierColor => page.barrierColor;

  @override
  String? get barrierLabel => page.barrierLabel;

  @override
  bool get maintainState => page.maintainState;

  @override
  Duration get transitionDuration => page.transitionDuration;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      child: page.child,
    );
  }
}

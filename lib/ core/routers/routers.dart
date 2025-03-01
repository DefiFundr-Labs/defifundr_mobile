part of '_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteConstants.initial,
    redirect: (context, state) async {
      return null;
    },
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          path: '/',
          name: RouteConstants.contractDetails,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ComplianceScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          }),
      GoRoute(
          path: '/',
          name: RouteConstants.letsGetToKnowYou,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: LetsGetToKnowYouScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          }),
      GoRoute(
          path: '/',
          name: RouteConstants.forgotPassword,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ForgotPasswordScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          }),
    ],
  );

  static GoRouter get router => _router;
}

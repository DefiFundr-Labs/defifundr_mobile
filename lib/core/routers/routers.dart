import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/web3auth/web3auth_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          name: RouteConstants.login,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const Web3AuthTestPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) {
            // Handle the authentication callback
            // The query parameters will be in state.queryParameters
            final params = state.queryParameters['b64Params'];
            print('Auth params: $params');

            // Navigate to your desired screen after auth
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/'); // Or wherever you want to navigate after auth
            });

            // Show a loading screen during transition
            return Web3AuthTestPage();
          },
        ),
      ]);

  static GoRouter get router => _router;
}

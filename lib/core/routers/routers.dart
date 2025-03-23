import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/screens/auth_screens/create_password/create_password_screen.dart';
import 'package:defifundr_mobile/screens/auth_screens/get_started/view/get_started.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../../screens/auth_screens/complete_kyc/complete_kyc.dart';
import '../../screens/home/verify_identity/verify_identity.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: RouteConstants.initial,
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          name: RouteConstants.compliance,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const CompleteKyc (),
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
          path: '/',
          name: RouteConstants.initial,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const GetStartedScreen(),
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
          path: '/',
          name: RouteConstants.createPassword,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const CreatePasswordScreen(),
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
      ]);

  static GoRouter get router => _router;
}

import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/screens/confirm_pin_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/screens/create_pin_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/screens/enable_face_id_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/screens/enable_fingerprint_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/screens/enable_push_notification_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/multi_factor_authentication_screen/screens/pin_created_screen.dart';
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
              child: const PinCreatedScreen(),
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

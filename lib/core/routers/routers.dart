import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/screens/auth_screens/complete_kyc/complete_kyc.dart';
import 'package:defifundr_mobile/screens/auth_screens/contract_overview/view/contract_overview.dart';
import 'package:defifundr_mobile/screens/auth_screens/create_password/create_password_screen.dart';
import 'package:defifundr_mobile/screens/auth_screens/get_started/view/get_started.dart';
import 'package:defifundr_mobile/screens/auth_screens/get_to_know_you_screen/lets_get_to_know_you.dart';
import 'package:defifundr_mobile/screens/auth_screens/incomplete_registration/incomplete_registration.dart';
import 'package:defifundr_mobile/screens/auth_screens/reset_password/forgot_password_screen.dart';
import 'package:defifundr_mobile/screens/auth_screens/reset_password/reset_password_success.dart';
import 'package:defifundr_mobile/screens/auth_screens/signIn_with_email/view/signIn_with_email.dart';
import 'package:defifundr_mobile/screens/auth_screens/sign_in_screen/signin.dart';
import 'package:defifundr_mobile/screens/auth_screens/signup/view/select_nationality_screen.dart';
import 'package:defifundr_mobile/screens/auth_screens/verify_bvn/verify_bvn_screen.dart';
import 'package:defifundr_mobile/screens/auth_screens/verify_with_passport_screen/verify_with_passport.dart';
import 'package:defifundr_mobile/screens/onboarding/onboarding_screen.dart';
import 'package:defifundr_mobile/screens/payment_screen/payment.dart';
import 'package:defifundr_mobile/screens/voters_verification_screen/votersVerification.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: '/verify-drivers-card',
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/verify-drivers-card',
          name: RouteConstants.verifyDriversCard,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SignInScreen(),
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
          path: '/verify-passport',
          name: RouteConstants.verifyPassport,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const VerifyPassportScreen(),
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
          path: '/verify-voters-card',
          name: RouteConstants.verifyVotersCard,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const VoterCardScreen(),
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
          path: '/verify-bvn',
          name: RouteConstants.verifyBVN,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const VerifyBVNScreen(),
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
          name: RouteConstants.compliance,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ContractOverview(),
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

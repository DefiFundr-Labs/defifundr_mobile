import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/widgets/fade_transition_page_router.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteConstants.login,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
      GoRoute(
        path: '/account-type',
        name: RouteConstants.accountType,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
      GoRoute(
        path: '/personal-details',
        name: RouteConstants.personalDetails,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
      GoRoute(
        path: '/country-selection',
        name: RouteConstants.countrySelection,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
      GoRoute(
        path: '/dial-code-selection',
        name: RouteConstants.dialCodeSelection,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
      GoRoute(
        path: '/address-details',
        name: RouteConstants.addressDetails,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
      GoRoute(
        path: '/profile-created',
        name: RouteConstants.profileCreated,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}

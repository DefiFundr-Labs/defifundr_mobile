import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login_screen/login_screen.dart';
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
          return FadeTransitionPage(key: state.pageKey, child: const LoginScreen());
        },
      ),
      GoRoute(
        path: '/account-type',
        name: RouteConstants.accountType,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const AccountTypeScreen());
        },
      ),
      GoRoute(
        path: '/personal-details',
        name: RouteConstants.personalDetails,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const PersonalDetailsScreen());
        },
      ),
      GoRoute(
        path: '/country-selection',
        name: RouteConstants.countrySelection,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const CountrySelectionScreen());
        },
      ),
      GoRoute(
        path: '/dial-code-selection',
        name: RouteConstants.dialCodeSelection,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const DialCodeSelectionScreen());
        },
      ),
      GoRoute(
        path: '/address-details',
        name: RouteConstants.addressDetails,
        pageBuilder: (context, state) {
          return FadeTransitionPage(key: state.pageKey, child: const AddressDetailsScreen());
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

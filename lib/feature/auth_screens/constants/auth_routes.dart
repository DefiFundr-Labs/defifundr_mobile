import 'package:defifundr_mobile/core/widgets/fade_transition_page_router.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login_screen/login_screen.dart';
import 'package:go_router/go_router.dart';

class _AuthPaths {
  final initial = '/';
  final login = '/auth/login';
  final newPassword = '/auth/new-password';
  final personalDetails = '/auth/personalDetails';
  final countrySelection = '/auth/countrySelection';
  final dialCodeSelection = '/auth/dialCodeSelection';
  final addressDetails = '/auth/addressDetails';
  final profileCreated = '/auth/profileCreated';
  final accountType = '/auth/accountType';
}

class AuthRoutes {
  static final paths = _AuthPaths();
  static final routes = [
    GoRoute(
      path: paths.login,
      name: paths.login,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const LoginScreen());
      },
    ),
    GoRoute(
      path: paths.accountType,
      name: paths.accountType,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const AccountTypeScreen());
      },
    ),
    GoRoute(
      path: paths.personalDetails,
      name: paths.personalDetails,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const PersonalDetailsScreen());
      },
    ),
    GoRoute(
      path: paths.countrySelection,
      name: paths.countrySelection,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const CountrySelectionScreen());
      },
    ),
    GoRoute(
      path: paths.dialCodeSelection,
      name: paths.dialCodeSelection,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const DialCodeSelectionScreen());
      },
    ),
    GoRoute(
      path: paths.addressDetails,
      name: paths.addressDetails,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const AddressDetailsScreen());
      },
    ),
    GoRoute(
      path: paths.profileCreated,
      name: paths.profileCreated,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
      },
    ),
  ];
}

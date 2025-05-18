import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/core/widgets/fade_transition_page_router.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login_screen/login_screen.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  final initial = '/';
  final login = 'login';
  final newPassword = 'new-password';
  final personalDetails = 'personalDetails';
  final countrySelection = 'countrySelection';
  final dialCodeSelection = 'dialCodeSelection';
  final addressDetails = 'addressDetails';
  final profileCreated = 'profileCreated';
  final accountType = 'accountType';

  static final routes = [
    GoRoute(
      path: RouteConstants.authRoute.initial,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const LoginScreen());
      },
    ),
    GoRoute(
      path: RouteConstants.authRoute.accountType,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const AccountTypeScreen());
      },
    ),
    GoRoute(
      path: RouteConstants.authRoute.personalDetails,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const PersonalDetailsScreen());
      },
    ),
    GoRoute(
      path: RouteConstants.authRoute.countrySelection,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const CountrySelectionScreen());
      },
    ),
    GoRoute(
      path: RouteConstants.authRoute.dialCodeSelection,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const DialCodeSelectionScreen());
      },
    ),
    GoRoute(
      path: RouteConstants.authRoute.addressDetails,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const AddressDetailsScreen());
      },
    ),
    GoRoute(
      path: RouteConstants.authRoute.profileCreated,
      pageBuilder: (context, state) {
        return FadeTransitionPage(key: state.pageKey, child: const ProfileCreatedScreen());
      },
    ),
  ];
}

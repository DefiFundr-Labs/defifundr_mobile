import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/constants/auth_routes.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login_screen/login_screen.dart';
import 'package:defifundr_mobile/core/widgets/fade_transition_page_router.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      ...AuthRoutes.routes,
    ],
  );

  static GoRouter get router => _router;
}

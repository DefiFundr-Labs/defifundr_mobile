import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/constants/auth_routes.dart';
import 'package:defifundr_mobile/feature/transaction/constants/transaction_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RouteConstants.authRoute.login,
    routes: [
      ...AuthRoutes.routes,
      ...TransactionRoutes.routes,
    ],
  );

  static GoRouter get router => _router;
}

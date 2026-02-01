import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // TODO: Implement your authentication check here
    // For now, allowing all navigation
    // Example:
    // final isAuthenticated = getIt<AuthService>().isAuthenticated;
    // if (isAuthenticated) {
    //   resolver.next(true);
    // } else {
    //   router.push(const LoginRoute());
    // }
    resolver.next(true);
  }
}

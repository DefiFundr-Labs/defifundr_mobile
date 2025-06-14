import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/screens/select_id_country_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/screens/verification_confirmed_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/identity_verification/screens/verify_identity_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login_screen/login_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/class/quick_payments.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/class/receive_params.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/screens/quick_pay_home_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/screens/receive_done.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/screens/receive_payment_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/quick_pay/screens/transaction_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/contracts_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/client_details.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/compliance_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/contract_dates_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/contract_details_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/payment_and_invoice_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/review_and_sign_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_page_view/select_contract_type.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/create_contract_screen.dart';
import 'package:defifundr_mobile/feature/fixed_rate_contract_creation/presentation/screens/workspace_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  // ignore: unused_field
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
              child: const LoginScreen(),
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
          path: '/account-type',
          name: RouteConstants.accountType,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const AccountTypeScreen(),
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
          path: '/personal-details',
          name: RouteConstants.personalDetails,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const PersonalDetailsScreen(),
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
          path: '/country-selection',
          name: RouteConstants.countrySelection,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const CountrySelectionScreen(),
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
          path: '/dial-code-selection',
          name: RouteConstants.dialCodeSelection,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const DialCodeSelectionScreen(),
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
          path: '/address-details',
          name: RouteConstants.addressDetails,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const AddressDetailsScreen(),
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
          path: '/profile-created',
          name: RouteConstants.profileCreated,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ProfileCreatedScreen(),
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
          path: '/verify-identity',
          name: RouteConstants.verifyIdentity,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const VerifyIdentityScreen(),
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
          path: '/select-country-id',
          name: RouteConstants.selectIdCountry,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SelectIdCountryScreen(),
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
          path: '/verification-confirmed',
          name: RouteConstants.verificationConfirmed,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const VerificationConfirmedScreen(),
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
          path: '/quick-pay-screen',
          name: RouteConstants.quickPayScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const QuickPayHomeScreen(),
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
          path: '/receive-payment-screen',
          name: RouteConstants.receivePaymentScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ReceivePaymentScreen(),
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
          path: '/receive-done-screen',
          name: RouteConstants.receivePaymentDoneScreen,
          pageBuilder: (context, state) {
            final args = state.extra as ReceiveParams;
            return CustomTransitionPage(
              key: state.pageKey,
              child: ReceivePaymentDoneScreen(args: args),
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
          path: '/transaction-screen',
          name: RouteConstants.transactionScreen,
          pageBuilder: (context, state) {
            final args = state.extra as QuickPayment;
            return CustomTransitionPage(
              key: state.pageKey,
              child: TransactionScreen(args: args),
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
          path: '/workspace-screen',
          name: RouteConstants.workspaceScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: WorkspaceScreen(),
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
          path: '/contracts-screen',
          name: RouteConstants.contractsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ContractsScreen(),
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
          path: '/create-contract-screen',
          name: RouteConstants.createcontractScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: CreateContractScreen(),
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
          path: '/select-contract-type',
          name: RouteConstants.selectContractTypeScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SelectContractTypeScreen(),
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
          path: '/contract-details',
          name: RouteConstants.contractDetailsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ContractDetailsScreen(),
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
          path: '/client-details',
          name: RouteConstants.clientDetailsScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ClientDetails(),
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
          path: '/contract-dates',
          name: RouteConstants.contractDatesScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ContractDatesScreen(),
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
          path: '/payment-and-invoice',
          name: RouteConstants.paymentAndInvoiceScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: PaymentAndInvoiceScreen(),
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
          path: '/compliance',
          name: RouteConstants.complianceScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ComplianceScreen(),
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
          path: '/review-and-sign',
          name: RouteConstants.reviewAndSignScreen,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ReviewAndSignScreen(),
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

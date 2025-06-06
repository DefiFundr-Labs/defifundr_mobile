import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/feature/auth_screens/screens/login_screen/login_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/two_fa_auth_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/withdraw_details_model.dart';
import 'package:defifundr_mobile/feature/payment_screens/upcoming_payments/upcoming_payments.dart';
import 'package:defifundr_mobile/feature/payment_screens/upcoming_payments/invoice.dart';
import 'package:defifundr_mobile/feature/payment_screens/models/payment.dart';
import 'package:defifundr_mobile/feature/finance_screen/finance_home_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/asset_details_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/select_asset_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/select_network_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/withdraw_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/address_book_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/add_address_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/sent_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/withdraw_preview_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/asset_deposit_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/receive_screen.dart';
import 'package:defifundr_mobile/feature/finance_screen/confirm_payment_screen.dart';
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
          path: '/upcoming-payments',
          name: RouteConstants.upcomingPayments,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const UpcomingPaymentsScreen(),
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
          path: '/invoice',
          name: RouteConstants.invoice,
          pageBuilder: (context, state) {
            final payment = state.extra;
            if (payment is! Payment) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const Scaffold(
                    body: Center(child: Text('Error: Payment data not found'))),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            }
            return CustomTransitionPage(
              key: state.pageKey,
              child: InvoiceScreen(payment: payment),
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
          path: '/finance-home',
          name: RouteConstants.financeHome,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const FinanceHomeScreen(),
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
          path: '/asset-details',
          name: RouteConstants.assetDetails,
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>?;
            if (args == null ||
                !args.containsKey('asset') ||
                !args.containsKey('network')) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const Scaffold(
                    body: Center(
                        child:
                            Text('Error: Asset or Network details not found'))),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            }
            final asset = args['asset'] as Asset;
            final network = args['network'] as Network;
            return CustomTransitionPage(
              key: state.pageKey,
              child: AssetDetailsScreen(asset: asset, network: network),
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
          path: '/receive',
          name: RouteConstants.receive,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const ReceiveScreen(),
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
          path: '/select-asset',
          name: RouteConstants.selectAsset,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SelectAssetScreen(),
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
          path: '/select-network',
          name: RouteConstants.selectNetwork,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SelectNetworkScreen(),
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
          path: '/withdraw',
          name: RouteConstants.withdraw,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const WithdrawScreen(),
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
          path: '/withdraw-preview',
          name: RouteConstants.withdrawPreview,
          pageBuilder: (context, state) {
            final withdrawDetails = state.extra as WithdrawDetailsModel?;
            return CustomTransitionPage(
              key: state.pageKey,
              child: WithdrawPreviewScreen(withdrawDetails: withdrawDetails),
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
          path: '/address-book',
          name: RouteConstants.addressBook,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const AddressBookScreen(),
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
          path: '/add-address',
          name: RouteConstants.addAddress,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const AddAddressScreen(),
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
          path: '/sent',
          name: RouteConstants.sent,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SentScreen(),
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
          path: '/asset-deposit',
          name: RouteConstants.assetDeposit,
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>?;
            if (args == null ||
                !args.containsKey('asset') ||
                !args.containsKey('network')) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const Scaffold(
                    body: Center(
                        child:
                            Text('Error: Asset or Network details not found'))),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            }
            final asset = args['asset'] as Asset;
            final network = args['network'] as Network;
            final address = args['address'] as String;

            return CustomTransitionPage(
              key: state.pageKey,
              child: AssetDepositScreen(
                  asset: asset, network: network, address: address),
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
        // Add route for ConfirmPinScreen
        GoRoute(
          path: '/confirm-payment',
          name: RouteConstants.confirmPayment,
          pageBuilder: (context, state) {
            final withdrawDetails = state.extra as WithdrawDetailsModel?;
            if (withdrawDetails == null) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const Scaffold(
                    body: Center(
                        child: Text('Error: Withdraw details not found'))),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            }
            return CustomTransitionPage(
              key: state.pageKey,
              child: ConfirmPaymentScreen(),
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
          path: '/two-fa-auth',
          name: RouteConstants.twoFaAuth,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: TwoFaAuthScreen(),
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

import 'package:defifundr_mobile/core/routers/routes_constant.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/identity_verification/screens/select_id_country_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/identity_verification/screens/verification_confirmed_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/identity_verification/screens/verify_identity_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/profile_created_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/widgets/country_selection.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/widgets/dial_code_selection.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/screens/login_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/two_fa_auth_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw_details_model.dart';
import 'package:defifundr_mobile/modules/payment/presentation/upcoming_payments/upcoming_payments.dart';
import 'package:defifundr_mobile/modules/payment/presentation/upcoming_payments/invoice.dart';
import 'package:defifundr_mobile/modules/payment/data/models/payment.dart';
import 'package:defifundr_mobile/modules/finance/presentation/finance_home_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/asset_details_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_asset_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address_book_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/add_address_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/sent_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw_preview_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/asset_deposit_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/receive_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/confirm_payment_screen.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/receive_params.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/quick_pay_home_screen.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/receive_done.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/receive_payment_screen.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/transaction_screen.dart';
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
      ]);

  static GoRouter get router => _router;
}

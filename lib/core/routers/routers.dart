import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/routers/guards/auth_guard.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/new_password.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/password_reset_success.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/reset_password.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/verify_otp.dart';
// Authentication
import 'package:defifundr_mobile/modules/authentication/presentation/login/screens/login_screen.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/screens/pin_code_screen.dart';
// Dashboard
import 'package:defifundr_mobile/modules/dasboard/presentation/screens/onboarding_checklist_screen.dart';
import 'package:defifundr_mobile/modules/expenses/data/model/expense_model.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/add_expense_screen.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/expense_details_screen.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/expense_submitted_screen.dart';
// Expenses
import 'package:defifundr_mobile/modules/expenses/presentation/screen/expenses_screen.dart';
import 'package:defifundr_mobile/modules/expenses/presentation/screen/time_off_details_screen.dart';
// Models
import 'package:defifundr_mobile/modules/finance/data/model/assets.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';
import 'package:defifundr_mobile/modules/finance/data/model/withdraw_details_model.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address/add_address_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/address/address_book_screen.dart';
import 'package:defifundr_mobile/modules/pay_cycle/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';

// Finance
import 'package:defifundr_mobile/modules/finance/presentation/finance/screen/finance_home_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_assets/asset_deposit_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_assets/asset_details_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_asset_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/select_network/select_network_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/confirm_payment_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/receive_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/sent_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/two_fa_auth_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/withdraw_preview_screen.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/withdraw_screen.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/create_invoice_flow_screen.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/screens/invoice_complete_screen.dart';
// Invoice
import 'package:defifundr_mobile/modules/invoice/presentation/screens/invoices_screen.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/bvn_verification/screens/processing_bvn_request_screen.dart';
// KYC
import 'package:defifundr_mobile/modules/kyc/presentation/bvn_verification/screens/provide_bvn_screen.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/screens/select_id_country_screen.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/screens/verification_in_progress_screen.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/identity_verification/screens/verify_identity_screen.dart';
import 'package:defifundr_mobile/modules/kyc/presentation/tax_compliance/screens/tax_information_screen.dart';
// Onboarding
import 'package:defifundr_mobile/modules/onboarding/presentation/create_account/screen/create_account_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/create_account/screen/create_password_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/create_account/screen/verify_account_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/account_type_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/address_details_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/personal_details_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/individual_account_flow/screens/profile_created_sucess.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/screens/confirm_pin_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/screens/create_pin_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/screens/enable_face_id_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/screens/enable_fingerprint_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/screens/enable_push_notification_screen.dart';
import 'package:defifundr_mobile/modules/onboarding/presentation/multi_factor_authentication_screen/screens/pin_created_screen.dart';
import 'package:defifundr_mobile/modules/pay_cycle/presentation/fixed_rate/screens/contract_detail_screen.dart';
// Pay Cycle
import 'package:defifundr_mobile/modules/pay_cycle/presentation/fixed_rate/screens/contracts_screen.dart';
import 'package:defifundr_mobile/modules/pay_cycle/presentation/fixed_rate/screens/payout_detail_screen.dart';
// Payment
import 'package:defifundr_mobile/modules/payment/presentation/upcoming_payments/upcoming_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/quick_payments.dart';
import 'package:defifundr_mobile/modules/quickpay/data/model/receive_params.dart';
import 'package:defifundr_mobile/modules/quickpay/invoice_detail_screen.dart';
// QuickPay
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/quick_pay_home_screen.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/receive_done.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/receive_payment_screen.dart';
import 'package:defifundr_mobile/modules/quickpay/presentation/screens/transaction_screen.dart';
import 'package:defifundr_mobile/modules/time_off/data/models/time_off_detail.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/cancel_time_off_request_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/contracts_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/edit_time_off_request_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/new_time_off_request_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/request_change_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/time_off_detail_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/time_off_details_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/time_off_history_screen.dart';
// Time Off
import 'package:defifundr_mobile/modules/time_off/presentation/screens/time_off_screen.dart';
import 'package:defifundr_mobile/modules/time_off/presentation/screens/unpaid_time_off_balance_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/submitted_timesheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/contracts_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/resubmit_hours_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/submit_hours_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/submitted_hours_detail_screen.dart';
// Time Tracking
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/time_tracking_screen.dart';
// Web3Auth
import 'package:defifundr_mobile/modules/web3auth/presentation/screen/web3auth_test_screen.dart';
import 'package:flutter/material.dart';

part 'routers.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard = AuthGuard();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        // Authentication routes
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: VerifyOtpRoute.page),
        AutoRoute(page: NewPasswordRoute.page),
        AutoRoute(page: PasswordResetSuccessRoute.page),
        AutoRoute(page: PinCodeRoute.page),

        // Onboarding routes
        AutoRoute(page: CreateAccountRoute.page),
        AutoRoute(page: CreatePasswordRoute.page),
        AutoRoute(page: VerifyAccountRoute.page),
        AutoRoute(page: AccountTypeRoute.page),
        AutoRoute(page: PersonalDetailsRoute.page),
        AutoRoute(page: AddressDetailsRoute.page),
        AutoRoute(page: ProfileCreatedSucessRoute.page),
        AutoRoute(page: CreatePinRoute.page),
        AutoRoute(page: ConfirmPinRoute.page),
        AutoRoute(page: PinCreatedRoute.page),
        AutoRoute(page: EnableFaceIdRoute.page),
        AutoRoute(page: EnableFingerprintRoute.page),
        AutoRoute(page: EnablePushNotificationRoute.page),

        // Dashboard
        AutoRoute(page: OnboardingChecklistRoute.page, guards: [authGuard]),

        // KYC routes
        AutoRoute(page: ProvideBvnRoute.page, guards: [authGuard]),
        AutoRoute(page: ProcessingBvnRequestRoute.page, guards: [authGuard]),
        AutoRoute(page: VerifyIdentityRoute.page, guards: [authGuard]),
        AutoRoute(page: SelectIdCountryRoute.page, guards: [authGuard]),
        AutoRoute(page: VerificationInProgressRoute.page, guards: [authGuard]),
        AutoRoute(page: TaxInformationRoute.page, guards: [authGuard]),

        // Finance routes
        AutoRoute(page: FinanceHomeRoute.page, guards: [authGuard]),
        AutoRoute(page: SelectNetworkRoute.page, guards: [authGuard]),
        AutoRoute(page: SelectAssetRoute.page, guards: [authGuard]),
        AutoRoute(page: AssetDetailsRoute.page, guards: [authGuard]),
        AutoRoute(page: AssetDepositRoute.page, guards: [authGuard]),
        AutoRoute(page: WithdrawRoute.page, guards: [authGuard]),
        AutoRoute(page: WithdrawPreviewRoute.page, guards: [authGuard]),
        AutoRoute(page: TwoFaAuthRoute.page, guards: [authGuard]),
        AutoRoute(page: ConfirmPaymentRoute.page, guards: [authGuard]),
        AutoRoute(page: SentRoute.page, guards: [authGuard]),
        AutoRoute(page: ReceiveRoute.page, guards: [authGuard]),
        AutoRoute(page: AddAddressRoute.page, guards: [authGuard]),
        AutoRoute(page: AddressBookRoute.page, guards: [authGuard]),

        // QuickPay routes
        AutoRoute(page: QuickPayHomeRoute.page, guards: [authGuard]),
        AutoRoute(page: ReceivePaymentRoute.page, guards: [authGuard]),
        AutoRoute(page: ReceivePaymentDoneRoute.page, guards: [authGuard]),
        AutoRoute(page: TransactionRoute.page, guards: [authGuard]),
        AutoRoute(page: InvoiceDetailRoute.page, guards: [authGuard]),

        // Payment routes
        AutoRoute(page: UpcomingPaymentsRoute.page, guards: [authGuard]),

        // Time Tracking routes
        AutoRoute(
          page: TimeTrackingRoute.page,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TimeTrackingContractsRoute.page,
          guards: [authGuard],
        ),
        AutoRoute(page: SubmitHoursRoute.page, guards: [authGuard]),
        AutoRoute(page: ResubmitHoursRoute.page, guards: [authGuard]),
        AutoRoute(page: SubmittedHoursDetailRoute.page, guards: [authGuard]),

        // Time Off routes
        AutoRoute(page: TimeOffRoute.page, guards: [authGuard]),
        AutoRoute(page: TimeOffDetailsRoute.page, guards: [authGuard]),
        AutoRoute(page: TimeOffDetailRoute.page, guards: [authGuard]),
        AutoRoute(page: NewTimeOffRequestRoute.page, guards: [authGuard]),
        AutoRoute(page: EditTimeOffRequestRoute.page, guards: [authGuard]),
        AutoRoute(page: CancelTimeOffRequestRoute.page, guards: [authGuard]),
        AutoRoute(page: RequestChangeRoute.page, guards: [authGuard]),
        AutoRoute(page: TimeOffHistoryRoute.page, guards: [authGuard]),
        AutoRoute(page: UnpaidTimeOffBalanceRoute.page, guards: [authGuard]),
        AutoRoute(
          page: TimeOffContractsRoute.page,
          guards: [authGuard],
        ),

        // Pay Cycle routes
        AutoRoute(page: PayCycleContractsRoute.page, guards: [authGuard]),
        AutoRoute(page: ContractDetailRoute.page, guards: [authGuard]),
        AutoRoute(page: PayoutDetailRoute.page, guards: [authGuard]),

        // Invoice routes
        AutoRoute(page: InvoicesRoute.page, guards: [authGuard]),
        AutoRoute(page: CreateInvoiceFlowRoute.page, guards: [authGuard]),
        AutoRoute(page: InvoiceCompleteRoute.page, guards: [authGuard]),

        // Expenses routes
        AutoRoute(page: ExpensesRoute.page, guards: [authGuard]),
        AutoRoute(page: AddExpenseRoute.page, guards: [authGuard]),
        AutoRoute(page: ExpenseDetailsRoute.page, guards: [authGuard]),
        AutoRoute(page: ExpenseSubmittedRoute.page, guards: [authGuard]),
        AutoRoute(page: ExpensesTimeOffDetailsRoute.page, guards: [authGuard]),

        // Web3Auth test
        AutoRoute(page: Web3authTestRoute.page),
      ];
}

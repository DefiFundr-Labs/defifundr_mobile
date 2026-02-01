import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/routers/guards/auth_guard.dart';
import 'package:defifundr_mobile/core/routers/route_constants.dart';
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
        // ============================================================
        // AUTHENTICATION ROUTES
        // ============================================================
        AutoRoute(
          page: LoginRoute.page,
          path: RouteConstants.login,
          initial: true,
        ),
        AutoRoute(
          page: PinCodeRoute.page,
          path: RouteConstants.pinCode,
        ),
        AutoRoute(
          page: ResetPasswordRoute.page,
          path: RouteConstants.resetPassword,
        ),
        AutoRoute(
          page: VerifyOtpRoute.page,
          path: RouteConstants.verifyOtp,
        ),
        AutoRoute(
          page: NewPasswordRoute.page,
          path: RouteConstants.newPassword,
        ),
        AutoRoute(
          page: PasswordResetSuccessRoute.page,
          path: RouteConstants.passwordResetSuccess,
        ),

        // ============================================================
        // ONBOARDING ROUTES
        // ============================================================
        AutoRoute(
          page: CreateAccountRoute.page,
          path: RouteConstants.createAccount,
        ),
        AutoRoute(
          page: CreatePasswordRoute.page,
          path: RouteConstants.createPassword,
        ),
        AutoRoute(
          page: VerifyAccountRoute.page,
          path: RouteConstants.verifyAccount,
        ),
        AutoRoute(
          page: AccountTypeRoute.page,
          path: RouteConstants.accountType,
        ),
        AutoRoute(
          page: PersonalDetailsRoute.page,
          path: RouteConstants.personalDetails,
        ),
        AutoRoute(
          page: AddressDetailsRoute.page,
          path: RouteConstants.addressDetails,
        ),
        AutoRoute(
          page: ProfileCreatedSucessRoute.page,
          path: RouteConstants.profileCreatedSuccess,
        ),
        AutoRoute(
          page: CreatePinRoute.page,
          path: RouteConstants.createPin,
        ),
        AutoRoute(
          page: ConfirmPinRoute.page,
          path: RouteConstants.confirmPin,
        ),
        AutoRoute(
          page: PinCreatedRoute.page,
          path: RouteConstants.pinCreated,
        ),
        AutoRoute(
          page: EnableFaceIdRoute.page,
          path: RouteConstants.enableFaceId,
        ),
        AutoRoute(
          page: EnableFingerprintRoute.page,
          path: RouteConstants.enableFingerprint,
        ),
        AutoRoute(
          page: EnablePushNotificationRoute.page,
          path: RouteConstants.enablePushNotification,
        ),

        // ============================================================
        // DASHBOARD ROUTES
        // ============================================================
        AutoRoute(
          page: OnboardingChecklistRoute.page,
          path: RouteConstants.dashboard,
          guards: [authGuard],
        ),

        // ============================================================
        // KYC ROUTES
        // ============================================================
        AutoRoute(
          page: ProvideBvnRoute.page,
          path: RouteConstants.kycProvideBvn,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ProcessingBvnRequestRoute.page,
          path: RouteConstants.kycProcessingBvn,
          guards: [authGuard],
        ),
        AutoRoute(
          page: VerifyIdentityRoute.page,
          path: RouteConstants.kycVerifyIdentity,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SelectIdCountryRoute.page,
          path: RouteConstants.kycSelectCountry,
          guards: [authGuard],
        ),
        AutoRoute(
          page: VerificationInProgressRoute.page,
          path: RouteConstants.kycVerificationInProgress,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TaxInformationRoute.page,
          path: RouteConstants.kycTaxInformation,
          guards: [authGuard],
        ),

        // ============================================================
        // FINANCE ROUTES
        // ============================================================
        AutoRoute(
          page: FinanceHomeRoute.page,
          path: RouteConstants.finance,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SelectNetworkRoute.page,
          path: RouteConstants.financeSelectNetwork,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SelectAssetRoute.page,
          path: RouteConstants.financeSelectAsset,
          guards: [authGuard],
        ),
        AutoRoute(
          page: AssetDetailsRoute.page,
          path: RouteConstants.financeAssetDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: AssetDepositRoute.page,
          path: RouteConstants.financeAssetDeposit,
          guards: [authGuard],
        ),
        AutoRoute(
          page: WithdrawRoute.page,
          path: RouteConstants.financeWithdraw,
          guards: [authGuard],
        ),
        AutoRoute(
          page: WithdrawPreviewRoute.page,
          path: RouteConstants.financeWithdrawPreview,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TwoFaAuthRoute.page,
          path: RouteConstants.financeTwoFaAuth,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ConfirmPaymentRoute.page,
          path: RouteConstants.financeConfirmPayment,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SentRoute.page,
          path: RouteConstants.financeSent,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ReceiveRoute.page,
          path: RouteConstants.financeReceive,
          guards: [authGuard],
        ),
        AutoRoute(
          page: AddAddressRoute.page,
          path: RouteConstants.financeAddAddress,
          guards: [authGuard],
        ),
        AutoRoute(
          page: AddressBookRoute.page,
          path: RouteConstants.financeAddressBook,
          guards: [authGuard],
        ),

        // ============================================================
        // QUICKPAY ROUTES
        // ============================================================
        AutoRoute(
          page: QuickPayHomeRoute.page,
          path: RouteConstants.quickpay,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ReceivePaymentRoute.page,
          path: RouteConstants.quickpayReceivePayment,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ReceivePaymentDoneRoute.page,
          path: RouteConstants.quickpayReceiveDone,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TransactionRoute.page,
          path: RouteConstants.quickpayTransaction,
          guards: [authGuard],
        ),
        AutoRoute(
          page: InvoiceDetailRoute.page,
          path: RouteConstants.quickpayInvoiceDetail,
          guards: [authGuard],
        ),

        // ============================================================
        // PAYMENT ROUTES
        // ============================================================
        AutoRoute(
          page: UpcomingPaymentsRoute.page,
          path: RouteConstants.paymentsUpcoming,
          guards: [authGuard],
        ),

        // ============================================================
        // TIME TRACKING ROUTES
        // ============================================================
        AutoRoute(
          page: TimeTrackingRoute.page,
          path: RouteConstants.timeTracking,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TimeTrackingContractsRoute.page,
          path: RouteConstants.timeTrackingContracts,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SubmitHoursRoute.page,
          path: RouteConstants.timeTrackingSubmitHours,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ResubmitHoursRoute.page,
          path: RouteConstants.timeTrackingResubmitHours,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SubmittedHoursDetailRoute.page,
          path: RouteConstants.timeTrackingSubmittedHoursDetail,
          guards: [authGuard],
        ),

        // ============================================================
        // TIME OFF ROUTES
        // ============================================================
        AutoRoute(
          page: TimeOffRoute.page,
          path: RouteConstants.timeOff,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TimeOffDetailsRoute.page,
          path: RouteConstants.timeOffDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TimeOffDetailRoute.page,
          path: RouteConstants.timeOffDetail,
          guards: [authGuard],
        ),
        AutoRoute(
          page: NewTimeOffRequestRoute.page,
          path: RouteConstants.timeOffNewRequest,
          guards: [authGuard],
        ),
        AutoRoute(
          page: EditTimeOffRequestRoute.page,
          path: RouteConstants.timeOffEditRequest,
          guards: [authGuard],
        ),
        AutoRoute(
          page: CancelTimeOffRequestRoute.page,
          path: RouteConstants.timeOffCancelRequest,
          guards: [authGuard],
        ),
        AutoRoute(
          page: RequestChangeRoute.page,
          path: RouteConstants.timeOffRequestChange,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TimeOffHistoryRoute.page,
          path: RouteConstants.timeOffHistory,
          guards: [authGuard],
        ),
        AutoRoute(
          page: UnpaidTimeOffBalanceRoute.page,
          path: RouteConstants.timeOffUnpaidBalance,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TimeOffContractsRoute.page,
          path: RouteConstants.timeOffContracts,
          guards: [authGuard],
        ),

        // ============================================================
        // PAY CYCLE ROUTES
        // ============================================================
        AutoRoute(
          page: PayCycleContractsRoute.page,
          path: RouteConstants.payCycleContracts,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ContractDetailRoute.page,
          path: RouteConstants.payCycleContractDetail,
          guards: [authGuard],
        ),
        AutoRoute(
          page: PayoutDetailRoute.page,
          path: RouteConstants.payCyclePayoutDetail,
          guards: [authGuard],
        ),

        // ============================================================
        // INVOICE ROUTES
        // ============================================================
        AutoRoute(
          page: InvoicesRoute.page,
          path: RouteConstants.invoices,
          guards: [authGuard],
        ),
        AutoRoute(
          page: CreateInvoiceFlowRoute.page,
          path: RouteConstants.invoicesCreate,
          guards: [authGuard],
        ),
        AutoRoute(
          page: InvoiceCompleteRoute.page,
          path: RouteConstants.invoicesComplete,
          guards: [authGuard],
        ),

        // ============================================================
        // EXPENSE ROUTES
        // ============================================================
        AutoRoute(
          page: ExpensesRoute.page,
          path: RouteConstants.expenses,
          guards: [authGuard],
        ),
        AutoRoute(
          page: AddExpenseRoute.page,
          path: RouteConstants.expensesAdd,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ExpenseDetailsRoute.page,
          path: RouteConstants.expensesDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ExpenseSubmittedRoute.page,
          path: RouteConstants.expensesSubmitted,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ExpensesTimeOffDetailsRoute.page,
          path: RouteConstants.expensesTimeOffDetails,
          guards: [authGuard],
        ),

        // ============================================================
        // WEB3AUTH TEST ROUTE
        // ============================================================
        AutoRoute(
          page: Web3authTestRoute.page,
          path: RouteConstants.web3authTest,
        ),
      ];
}

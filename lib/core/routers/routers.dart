import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/enums/biometics_enum.dart';
import 'package:defifundr_mobile/core/routers/bottom_sheet_route.dart';
import 'package:defifundr_mobile/core/routers/guards/auth_guard.dart';
import 'package:defifundr_mobile/core/routers/main_shell_screen.dart';
import 'package:defifundr_mobile/core/routers/route_constants.dart';
import 'package:defifundr_mobile/core/routers/tab_routes.dart';
import 'package:defifundr_mobile/shared/widgets/sample_bottom_sheet_screen.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/new_password.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/password_reset_success.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/reset_password.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/forget_password/screens/verify_otp.dart';
// Authentication
import 'package:defifundr_mobile/modules/authentication/presentation/login/screens/login_screen.dart';
import 'package:defifundr_mobile/modules/authentication/presentation/login/screens/pin_code_screen.dart';
// Dashboard
import 'package:defifundr_mobile/modules/dasboard/presentation/screens/onboarding_checklist_screen.dart';
import 'package:defifundr_mobile/modules/dasboard/presentation/screens/notifications_screen.dart';
import 'package:defifundr_mobile/modules/dasboard/data/models/notification_item.dart';
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
// More
import 'package:defifundr_mobile/modules/more/presentation/screens/more_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/personal_details_view_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/edit_profile_details_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/edit_address_details_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/edit_account_details_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/edit_tax_information_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/delete_account_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/manage_wallet_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/wallet_detail_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/export_private_key_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/private_key_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/change_password_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/current_pin_code_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/new_pin_code_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/confirm_new_pin_code_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/setup_two_fa_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/setup_instructions_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/more_two_fa_auth_code_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/two_fa_setup_complete_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/device_management_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/app_appearance_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/help_feedback_screen.dart';
import 'package:defifundr_mobile/modules/more/presentation/screens/social_media_screen.dart';
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
import 'package:defifundr_mobile/modules/pay_cycle/data/models/contract.dart';
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
import 'package:defifundr_mobile/modules/time_tracking/data/models/contract.dart';
import 'package:defifundr_mobile/modules/time_tracking/data/models/submitted_timesheet.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/contracts_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/resubmit_hours_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/submit_hours_screen.dart';
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/submitted_hours_detail_screen.dart';
// Time Tracking
import 'package:defifundr_mobile/modules/time_tracking/presentation/screens/time_tracking_screen.dart';
// Workspace
import 'package:defifundr_mobile/modules/workspace/presentation/screens/workspace_screen.dart';
// Web3Auth
import 'package:defifundr_mobile/modules/web3auth/presentation/screen/web3auth_test_screen.dart';
import 'package:flutter/material.dart';

import '../../modules/dasboard/presentation/screens/home_screen.dart';
import '../../modules/kyc/presentation/fund_wallet/screens/fund_wallet_screen.dart';

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
        // DASHBOARD ROUTES
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
        // MAIN SHELL (Bottom Navigation)
        // ============================================================
        AutoRoute(
          page: MainShellRoute.page,
          path: RouteConstants.mainShell,
          guards: [authGuard],
          children: [
            // Home Tab
            AutoRoute(
              page: HomeTabRoute.page,
              path: RouteConstants.homeTab,
              children: [
                AutoRoute(
                  page: HomeRoute.page,
                  path: RouteConstants.home,
                  initial: true,
                ),
                AutoRoute(
                  page: OnboardingChecklistRoute.page,
                  path: RouteConstants.dashboard,
                ),
                AutoRoute(
                  page: NotificationsRoute.page,
                  path: RouteConstants.notifications,
                ),
              ],
            ),

            // Workspace Tab
            AutoRoute(
              page: WorkspaceTabRoute.page,
              path: RouteConstants.workspaceTab,
              children: [
                AutoRoute(
                  page: WorkspaceRoute.page,
                  path: '',
                  initial: true,
                ),
                AutoRoute(
                  page: TimeTrackingContractsRoute.page,
                  path: 'contracts',
                ),
                AutoRoute(
                  page: TimeTrackingRoute.page,
                  path: 'time-tracking',
                ),
                AutoRoute(
                  page: SubmitHoursRoute.page,
                  path: 'submit-hours',
                ),
                AutoRoute(
                  page: ResubmitHoursRoute.page,
                  path: 'resubmit-hours',
                ),
                AutoRoute(
                  page: SubmittedHoursDetailRoute.page,
                  path: 'submitted-hours-detail',
                ),
                AutoRoute(
                  page: TimeOffRoute.page,
                  path: 'time-off',
                ),
                AutoRoute(
                  page: TimeOffDetailsRoute.page,
                  path: 'time-off-details',
                ),
                AutoRoute(
                  page: TimeOffDetailRoute.page,
                  path: 'time-off-detail',
                ),
                AutoRoute(
                  page: NewTimeOffRequestRoute.page,
                  path: 'time-off-new-request',
                ),
                AutoRoute(
                  page: EditTimeOffRequestRoute.page,
                  path: 'time-off-edit-request',
                ),
                AutoRoute(
                  page: CancelTimeOffRequestRoute.page,
                  path: 'time-off-cancel-request',
                ),
                AutoRoute(
                  page: RequestChangeRoute.page,
                  path: 'time-off-request-change',
                ),
                AutoRoute(
                  page: TimeOffHistoryRoute.page,
                  path: 'time-off-history',
                ),
                AutoRoute(
                  page: UnpaidTimeOffBalanceRoute.page,
                  path: 'time-off-unpaid-balance',
                ),
                AutoRoute(
                  page: TimeOffContractsRoute.page,
                  path: 'time-off-contracts',
                ),
                AutoRoute(
                  page: ExpensesRoute.page,
                  path: 'expenses',
                ),
                AutoRoute(
                  page: AddExpenseRoute.page,
                  path: 'expenses-add',
                ),
                AutoRoute(
                  page: ExpenseDetailsRoute.page,
                  path: 'expenses-details',
                ),
                AutoRoute(
                  page: ExpenseSubmittedRoute.page,
                  path: 'expenses-submitted',
                ),
                AutoRoute(
                  page: ExpensesTimeOffDetailsRoute.page,
                  path: 'expenses-time-off-details',
                ),
              ],
            ),

            // Finance Tab
            AutoRoute(
              page: FinanceTabRoute.page,
              path: RouteConstants.financeTab,
              children: [
                AutoRoute(
                  page: FinanceHomeRoute.page,
                  path: '',
                  initial: true,
                ),
                AutoRoute(
                  page: SelectNetworkRoute.page,
                  path: 'select-network',
                ),
                AutoRoute(
                  page: SelectAssetRoute.page,
                  path: 'select-asset',
                ),
                AutoRoute(
                  page: AssetDetailsRoute.page,
                  path: 'asset-details',
                ),
                AutoRoute(
                  page: AssetDepositRoute.page,
                  path: 'asset-deposit',
                ),
                AutoRoute(
                  page: WithdrawRoute.page,
                  path: 'withdraw',
                ),
                AutoRoute(
                  page: WithdrawPreviewRoute.page,
                  path: 'withdraw-preview',
                ),
                AutoRoute(
                  page: TwoFaAuthRoute.page,
                  path: 'two-fa-auth',
                ),
                AutoRoute(
                  page: ConfirmPaymentRoute.page,
                  path: 'confirm-payment',
                ),
                AutoRoute(
                  page: SentRoute.page,
                  path: 'sent',
                ),
                AutoRoute(
                  page: ReceiveRoute.page,
                  path: 'receive',
                ),
                AutoRoute(
                  page: AddAddressRoute.page,
                  path: 'add-address',
                ),
                AutoRoute(
                  page: AddressBookRoute.page,
                  path: 'address-book',
                ),
              ],
            ),

            // More Tab
            AutoRoute(
              page: MoreTabRoute.page,
              path: RouteConstants.moreTab,
              children: [
                AutoRoute(
                  page: MoreRoute.page,
                  path: RouteConstants.more,
                  initial: true,
                ),
              ],
            ),
          ],
        ),

        // ============================================================
        // KYC ROUTES (pushed over shell — no bottom nav)
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
        AutoRoute(
          page: FundWalletRoute.page,
          path: RouteConstants.kycFundWallet,
          guards: [authGuard],
        ),

        // ============================================================
        // QUICKPAY ROUTES (pushed over shell)
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
        // PAYMENT ROUTES (pushed over shell)
        // ============================================================
        AutoRoute(
          page: UpcomingPaymentsRoute.page,
          path: RouteConstants.paymentsUpcoming,
          guards: [authGuard],
        ),

        // ============================================================
        // PAY CYCLE ROUTES (pushed over shell)
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
        // INVOICE ROUTES (pushed over shell)
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
        // MORE ROUTES (pushed over shell)
        // ============================================================
        AutoRoute(
          page: PersonalDetailsViewRoute.page,
          path: RouteConstants.morePersonalDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: EditProfileDetailsRoute.page,
          path: RouteConstants.moreEditProfileDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: EditAddressDetailsRoute.page,
          path: RouteConstants.moreEditAddressDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: EditAccountDetailsRoute.page,
          path: RouteConstants.moreEditAccountDetails,
          guards: [authGuard],
        ),
        AutoRoute(
          page: EditTaxInformationRoute.page,
          path: RouteConstants.moreEditTaxInformation,
          guards: [authGuard],
        ),
        AutoRoute(
          page: DeleteAccountRoute.page,
          path: RouteConstants.moreDeleteAccount,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ManageWalletRoute.page,
          path: RouteConstants.moreManageWallet,
          guards: [authGuard],
        ),
        AutoRoute(
          page: WalletDetailRoute.page,
          path: RouteConstants.moreWalletDetail,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ExportPrivateKeyRoute.page,
          path: RouteConstants.moreExportPrivateKey,
          guards: [authGuard],
        ),
        AutoRoute(
          page: PrivateKeyRoute.page,
          path: RouteConstants.morePrivateKey,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ChangePasswordRoute.page,
          path: RouteConstants.moreChangePassword,
          guards: [authGuard],
        ),
        AutoRoute(
          page: CurrentPinCodeRoute.page,
          path: RouteConstants.moreCurrentPin,
          guards: [authGuard],
        ),
        AutoRoute(
          page: NewPinCodeRoute.page,
          path: RouteConstants.moreNewPin,
          guards: [authGuard],
        ),
        AutoRoute(
          page: ConfirmNewPinCodeRoute.page,
          path: RouteConstants.moreConfirmNewPin,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SetupTwoFaRoute.page,
          path: RouteConstants.moreSetupTwoFa,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SetupInstructionsRoute.page,
          path: RouteConstants.moreSetupInstructions,
          guards: [authGuard],
        ),
        AutoRoute(
          page: MoreTwoFaAuthCodeRoute.page,
          path: RouteConstants.moreTwoFaAuthCode,
          guards: [authGuard],
        ),
        AutoRoute(
          page: TwoFaSetupCompleteRoute.page,
          path: RouteConstants.moreTwoFaSetupComplete,
          guards: [authGuard],
        ),
        AutoRoute(
          page: DeviceManagementRoute.page,
          path: RouteConstants.moreDeviceManagement,
          guards: [authGuard],
        ),
        AutoRoute(
          page: AppAppearanceRoute.page,
          path: RouteConstants.moreAppAppearance,
          guards: [authGuard],
        ),
        AutoRoute(
          page: HelpFeedbackRoute.page,
          path: RouteConstants.moreHelpFeedback,
          guards: [authGuard],
        ),
        AutoRoute(
          page: SocialMediaRoute.page,
          path: RouteConstants.moreSocialMedia,
          guards: [authGuard],
        ),

        // ============================================================
        // WEB3AUTH TEST ROUTE
        // ============================================================
        AutoRoute(
          page: Web3authTestRoute.page,
          path: RouteConstants.web3authTest,
        ),

        // ============================================================
        // BOTTOM SHEET ROUTES
        // ============================================================
        CustomRoute(
          page: SampleBottomSheetRoute.page,
          path: '/sample-bottom-sheet',
          customRouteBuilder: bottomSheetRouteBuilder,
        ),
      ];
}

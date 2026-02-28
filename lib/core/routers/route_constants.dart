/// Route path constants for the application
///
/// This file contains all route paths used in the app.
/// Centralizing route paths makes them easier to maintain and update.
class RouteConstants {
  RouteConstants._();

  // ============================================================
  // AUTHENTICATION ROUTES
  // ============================================================
  static const String login = '/login';
  static const String pinCode = '/pin-code';
  static const String resetPassword = '/reset-password';
  static const String verifyOtp = '/verify-otp';
  static const String newPassword = '/new-password';
  static const String passwordResetSuccess = '/password-reset-success';

  // ============================================================
  // ONBOARDING ROUTES
  // ============================================================
  static const String createAccount = '/create-account';
  static const String createPassword = '/create-password';
  static const String verifyAccount = '/verify-account';
  static const String accountType = '/account-type';
  static const String personalDetails = '/personal-details';
  static const String addressDetails = '/address-details';
  static const String profileCreatedSuccess = '/profile-created-success';
  static const String createPin = '/create-pin';
  static const String confirmPin = '/confirm-pin';
  static const String pinCreated = '/pin-created';
  static const String enableFaceId = '/enable-face-id';
  static const String enableFingerprint = '/enable-fingerprint';
  static const String enablePushNotification = '/enable-push-notification';

  // ============================================================
  // MAIN SHELL / TABS
  // ============================================================
  static const String mainShell = '/main';
  static const String homeTab = 'home';
  static const String financeTab = 'finance';
  static const String workspaceTab = 'workspace';
  static const String moreTab = 'more';
  static const String more = '';

  // ============================================================
  // DASHBOARD ROUTES
  // ============================================================
  static const String home = '';
  static const String dashboard = 'onboarding-checklist';
  static const String notifications = 'notifications';
  static const String notificationDetail = 'notification-detail';

  // ============================================================
  // KYC ROUTES
  // ============================================================
  static const String kycProvideBvn = '/kyc/provide-bvn';
  static const String kycProcessingBvn = '/kyc/processing-bvn';
  static const String kycVerifyIdentity = '/kyc/verify-identity';
  static const String kycSelectCountry = '/kyc/select-country';
  static const String kycVerificationInProgress =
      '/kyc/verification-in-progress';
  static const String kycTaxInformation = '/kyc/tax-information';
  static const String kycFundWallet = '/kyc/fund-wallet';

  // ============================================================
  // FINANCE ROUTES
  // ============================================================
  static const String finance = '/finance';
  static const String financeSelectNetwork = '/finance/select-network';
  static const String financeSelectAsset = '/finance/select-asset';
  static const String financeAssetDetails = '/finance/asset-details';
  static const String financeAssetDeposit = '/finance/asset-deposit';
  static const String financeWithdraw = '/finance/withdraw';
  static const String financeWithdrawPreview = '/finance/withdraw-preview';
  static const String financeTwoFaAuth = '/finance/two-fa-auth';
  static const String financeConfirmPayment = '/finance/confirm-payment';
  static const String financeSent = '/finance/sent';
  static const String financeReceive = '/finance/receive';
  static const String financeAddAddress = '/finance/add-address';
  static const String financeAddressBook = '/finance/address-book';

  // ============================================================
  // QUICKPAY ROUTES
  // ============================================================
  static const String quickpay = '/quickpay';
  static const String quickpayReceivePayment = '/quickpay/receive-payment';
  static const String quickpayReceiveDone = '/quickpay/receive-done';
  static const String quickpayTransaction = '/quickpay/transaction';
  static const String quickpayInvoiceDetail = '/quickpay/invoice-detail';

  // ============================================================
  // PAYMENT ROUTES
  // ============================================================
  static const String paymentsUpcoming = '/payments/upcoming';
  static const String paymentsTransactions = '/payments/transactions';

  // ============================================================
  // TIME TRACKING ROUTES
  // ============================================================
  static const String timeTracking = '/time-tracking';
  static const String timeTrackingContracts = '/time-tracking/contracts';
  static const String timeTrackingSubmitHours = '/time-tracking/submit-hours';
  static const String timeTrackingResubmitHours =
      '/time-tracking/resubmit-hours';
  static const String timeTrackingSubmittedHoursDetail =
      '/time-tracking/submitted-hours-detail';

  // ============================================================
  // TIME OFF ROUTES
  // ============================================================
  static const String timeOff = '/time-off';
  static const String timeOffDetails = '/time-off/details';
  static const String timeOffDetail = '/time-off/detail';
  static const String timeOffNewRequest = '/time-off/new-request';
  static const String timeOffEditRequest = '/time-off/edit-request';
  static const String timeOffCancelRequest = '/time-off/cancel-request';
  static const String timeOffRequestChange = '/time-off/request-change';
  static const String timeOffHistory = '/time-off/history';
  static const String timeOffUnpaidBalance = '/time-off/unpaid-balance';
  static const String timeOffContracts = '/time-off/contracts';

  // ============================================================
  // PAY CYCLE ROUTES
  // ============================================================
  static const String payCycleContracts = '/pay-cycle/contracts';
  static const String payCycleContractDetail = '/pay-cycle/contract-detail';
  static const String payCyclePayoutDetail = '/pay-cycle/payout-detail';

  // ============================================================
  // INVOICE ROUTES
  // ============================================================
  static const String invoices = '/invoices';
  static const String invoicesCreate = '/invoices/create';
  static const String invoicesComplete = '/invoices/complete';

  // ============================================================
  // EXPENSE ROUTES
  // ============================================================
  static const String expenses = '/expenses';
  static const String expensesAdd = '/expenses/add';
  static const String expensesDetails = '/expenses/details';
  static const String expensesSubmitted = '/expenses/submitted';
  static const String expensesTimeOffDetails = '/expenses/time-off-details';

  // ============================================================
  // MORE ROUTES
  // ============================================================
  static const String morePersonalDetails = '/more/personal-details';
  static const String moreEditProfileDetails = '/more/edit-profile-details';
  static const String moreEditAddressDetails = '/more/edit-address-details';
  static const String moreEditAccountDetails = '/more/edit-account-details';
  static const String moreEditTaxInformation = '/more/edit-tax-information';
  static const String moreDeleteAccount = '/more/delete-account';
  static const String moreManageWallet = '/more/manage-wallet';
  static const String moreWalletDetail = '/more/wallet-detail';
  static const String moreExportPrivateKey = '/more/export-private-key';
  static const String morePrivateKey = '/more/private-key';
  static const String moreChangePassword = '/more/change-password';
  static const String moreCurrentPin = '/more/current-pin';
  static const String moreNewPin = '/more/new-pin';
  static const String moreConfirmNewPin = '/more/confirm-new-pin';
  static const String moreSetupTwoFa = '/more/setup-two-fa';
  static const String moreSetupInstructions = '/more/setup-instructions';
  static const String moreTwoFaAuthCode = '/more/two-fa-auth-code';
  static const String moreTwoFaSetupComplete = '/more/two-fa-setup-complete';
  static const String moreDeviceManagement = '/more/device-management';
  static const String moreAppAppearance = '/more/app-appearance';
  static const String moreHelpFeedback = '/more/help-feedback';
  static const String moreSocialMedia = '/more/social-media';

  // ============================================================
  // WEB3AUTH TEST ROUTE
  // ============================================================
  static const String web3authTest = '/web3auth-test';
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My App';

  @override
  String get welcome => 'Welcome';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String counter(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemMode => 'System Mode';

  @override
  String get more => 'More';

  @override
  String get profile => 'Profile';

  @override
  String get security => 'Security';

  @override
  String get general => 'General';

  @override
  String get about => 'About';

  @override
  String get personalDetails => 'Personal details';

  @override
  String get manageWallet => 'Manage wallet';

  @override
  String get addressBook => 'Address book';

  @override
  String get changePassword => 'Change password';

  @override
  String get changePIN => 'Change PIN';

  @override
  String get useFaceIdFingerprint => 'Use Face ID / Fingerprint';

  @override
  String get twoFactorAuthentication => 'Two-factor authentication';

  @override
  String get deviceManagement => 'Device management';

  @override
  String get appAppearance => 'App appearance';

  @override
  String get pushNotifications => 'Push notifications';

  @override
  String get appLanguage => 'App language';

  @override
  String get helpFeedback => 'Help & feedback';

  @override
  String get visitWebsite => 'Visit website';

  @override
  String get termsOfService => 'Terms of service';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get logOut => 'Log out';

  @override
  String versionInfo(String version, String build) {
    return 'Version $version (Build $build)';
  }

  @override
  String get appAppearanceSubtitle =>
      'Customize the look and feel of the app by choosing your preferred theme and app icon.';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get appIcon => 'App icon';

  @override
  String get active => 'Active';

  @override
  String get saving => 'Saving...';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get legalFirstName => 'Legal first name';

  @override
  String get legalLastName => 'Legal last name';

  @override
  String get countryOfCitizenship => 'Country of citizenship';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get gender => 'Gender';

  @override
  String get phoneNo => 'Phone no';

  @override
  String get address => 'Address';

  @override
  String get country => 'Country';

  @override
  String get accountDetails => 'Account details';

  @override
  String get taxInformation => 'Tax information';

  @override
  String get countryOfTaxResidence => 'Country of tax residence';

  @override
  String get taxId => 'Tax ID';

  @override
  String get profilePhoto => 'Profile photo';

  @override
  String get editPhoto => 'Edit photo';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get profileDetails => 'Profile details';

  @override
  String get changePasswordSubtitle =>
      'Please provide your personal details, this will be used to complete your profile.';

  @override
  String get currentPassword => 'Current password';

  @override
  String get newPassword => 'New password';

  @override
  String get passwordRequirementsTitle => 'Must Contain At Least:';

  @override
  String get passwordReq8Chars => '8 characters';

  @override
  String get passwordReqNumber => 'A number';

  @override
  String get passwordReqUppercase => 'An uppercase letter';

  @override
  String get passwordReqLowercase => 'A lowercase letter';

  @override
  String get passwordReqSpecial => 'A special character';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get confirmNewPasswordHint =>
      'Your new password is what you\'ll use to access your account.';

  @override
  String get deviceManagementSubtitle =>
      'See all devices that have logged into your account. Remove any for added security.';

  @override
  String get currentDevice => 'Current device';

  @override
  String get otherDevices => 'Other devices';

  @override
  String get deleteDevice => 'Delete device';

  @override
  String get deleteDeviceConfirm =>
      'Are you sure you want to delete this device? Password will be required to sign in again.';

  @override
  String get goBack => 'Go back';

  @override
  String get delete => 'Delete';

  @override
  String get logOutAllDevices => 'Log out all known devices';

  @override
  String get logOutAllDevicesConfirm =>
      'Are you sure you want to log out all known devices? You\'ll need to sign in again on each one.';

  @override
  String get logOutAllDevicesTitle => 'Log Out All Known Devices';

  @override
  String get logOutAllDevicesSubtitle =>
      'You\'ll have to log back in on all logged out devices.';

  @override
  String get location => 'Location:';

  @override
  String get lastLogin => 'Last login:';

  @override
  String get helpFeedbackSubtitle =>
      'Find answers in our Help Center or contact support for account, wallet, or other issues.';

  @override
  String get helpCenter => 'Help center';

  @override
  String get helpCenterSubtitle =>
      'Find answers fast with articles and FAQs covering common questions and issues.';

  @override
  String get chatWithUs => 'Chat with us';

  @override
  String get chatWithUsSubtitle =>
      'Need quick help? Start a live chat for quick help from our support team.';

  @override
  String get leaveFeedback => 'Leave feedback';

  @override
  String get leaveFeedbackSubtitle =>
      'Tell us what you think. Your feedback helps us improve your experience.';

  @override
  String get followUsOnSocialMedia => 'Follow us on social media';

  @override
  String get followUsSubtitle =>
      'Get updates, tips, and news by following us on your favorite platforms.';

  @override
  String get wallets => 'Wallets';

  @override
  String get manageWalletSubtitle =>
      'View your wallet details and securely access your private key.';

  @override
  String get setupTwoFaTitle => 'Set up 2FA for your transactions';

  @override
  String get setupTwoFaSubtitle =>
      'Activate two factor authentication to have an extra layer of security on your account, transactions will need a code from an authenticator app when enabled';

  @override
  String get activateNow => 'Activate now';

  @override
  String get twoFaCompleteTitle => '2FA setup complete';

  @override
  String get twoFaCompleteSubtitle =>
      'Two factor authentication is enabled, we\'ll use your authenticator app codes for transactions';

  @override
  String get backToSettings => 'Back to settings';

  @override
  String get totalBalance => 'Total balance';

  @override
  String get transactions => 'Transactions';

  @override
  String get transactionsEmpty => 'Transactions will appear here';

  @override
  String get upcomingPayments => 'Upcoming payments';

  @override
  String get upcomingPaymentsEmpty => 'Upcoming payments will appear here';

  @override
  String get workspace => 'Workspace';

  @override
  String get contracts => 'Contracts';

  @override
  String get payCycle => 'Pay cycle';

  @override
  String get expenses => 'Expenses';

  @override
  String get timesheets => 'Timesheets';

  @override
  String get timeOff => 'Time off';

  @override
  String get finance => 'Finance';

  @override
  String get receive => 'Receive';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get assets => 'Assets';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get invoices => 'Invoices';

  @override
  String get search => 'Search';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get seeAll => 'See all';

  @override
  String get needHelp => 'Need Help?';

  @override
  String get noContractsYet => 'Contracts will appear here';

  @override
  String get exportPrivateKey => 'Export private key';

  @override
  String get exportPrivateKeySubtitle =>
      'Your Private Key is the key used to back up your wallet. Keep it secret and secure at all times.';

  @override
  String get keepScreenPrivateTitle => 'Keep Your Screen Private';

  @override
  String get keepScreenPrivateDesc =>
      'Screenshots or recordings of your private keys can lead to wallet loss.';

  @override
  String get storeKeysOfflineTitle => 'Store Keys Offline';

  @override
  String get storeKeysOfflineDesc =>
      'Avoid sharing or saving your keys in the cloud, as they are easily compromised.';

  @override
  String get yourKeyYourWalletTitle => 'Your Key, Your Wallet';

  @override
  String get yourKeyYourWalletDesc =>
      'Anyone with your private keys can access and steal your assets.';

  @override
  String get revealPrivateKey => 'Reveal private key';

  @override
  String get yourPrivateKey => 'Your private key';

  @override
  String get doNotSharePrivateKey => 'Do Not Share Your Private Key';

  @override
  String get privateKeyWarning =>
      'Your private key gives full access to your wallet. Never share it with anyone. If someone else gets it, they can steal your assets.';

  @override
  String get copyToClipboard => 'Copy to clipboard';

  @override
  String get done => 'Done';

  @override
  String get addressCopiedToClipboard => 'Address copied to clipboard';

  @override
  String get privateKeyCopiedToClipboard => 'Private key copied to clipboard';

  @override
  String get setupInstructions => 'Setup Instructions';

  @override
  String get scanQrCodeTitle => 'Scan the QR code';

  @override
  String get scanQrCodeDesc =>
      'Scan the QR code above with your authenticator app to get generated codes from your authenticator app';

  @override
  String get close => 'Close';

  @override
  String get continueText => 'Continue';

  @override
  String get copySetupKey => 'Copy setup key';

  @override
  String get viewBarcodeQrCode => 'View barcode / QR code';

  @override
  String get setupKeyCopied => 'Setup key copied to clipboard.';

  @override
  String get step1Title => 'Download an authenticator app';

  @override
  String get step1Desc =>
      'We recommend downloading Google Authenticator if you don\'t have one installed.';

  @override
  String get step2Title => 'Scan or copy the setup key below';

  @override
  String get step2Desc =>
      'Scan this QR code from the app or copy the key and paste it in the authenticator app';

  @override
  String get step3Title => 'Enter the 6-digit code';

  @override
  String get step3Desc =>
      'If you scanned the QR code from step 2, your 2FA will auto complete setup and generate a 6-digit auth code for you. If you copied the code from step 2, then you have to select key type as \'Time based\' to complete setup.';

  @override
  String get twoFaAuthCode => '2FA Auth Code';

  @override
  String get twoFaAuthCodeSubtitle =>
      'Enter in the 6-digit code generated by the authenticator app';

  @override
  String get currentPINCode => 'Current PIN Code';

  @override
  String get currentPINCodeSubtitle =>
      'Please provide your current 4 digit PIN';

  @override
  String get incorrectPIN => 'Incorrect PIN. Please try again.';

  @override
  String get newPINCode => 'New PIN Code';

  @override
  String get newPINCodeSubtitle =>
      'Enter a 4 digit code you will use to log in, without entering your login credentials.';

  @override
  String get confirmNewPINCode => 'Confirm New PIN Code';

  @override
  String get confirmNewPINCodeSubtitle =>
      'Enter the 4 digit code you entered again for confirmation.';

  @override
  String get pinsDoNotMatch => 'PINs do not match. Please try again.';

  @override
  String get deleteAccountReason =>
      'Please tell us why have you decided to delete your account?';

  @override
  String get deleteAccountWarning1 => 'Deleting your account is irreversible.';

  @override
  String get deleteAccountWarning2 =>
      'You will lose all accumulated data but retain account access.';

  @override
  String get deleteAccountCommentHint =>
      'Would you like to leave any suggestions or comments?';

  @override
  String get editProfileDetails => 'Edit profile details';

  @override
  String get editProfileDetailsSubtitle =>
      'Update your personal information to keep your profile accurate and up to date.';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get dialCode => 'Dial code';

  @override
  String get editAddressDetails => 'Edit address details';

  @override
  String get street => 'Street';

  @override
  String get city => 'City';

  @override
  String get postalZipCode => 'Postal / zip code';

  @override
  String get editAccountDetails => 'Edit account details';

  @override
  String get editAccountDetailsSubtitle =>
      'Update your email to maintain account access and receive important notifications.';

  @override
  String get currentEmail => 'Current email';

  @override
  String get newEmail => 'New email';

  @override
  String get editTaxInformation => 'Edit tax information';

  @override
  String get editTaxInformationSubtitle =>
      'Update your tax details to ensure compliance with regulations and accurate reporting.';

  @override
  String get asset => 'Asset';

  @override
  String get network => 'Network';

  @override
  String get selectAsset => 'Select Asset';

  @override
  String get selectNetwork => 'Select Network';

  @override
  String get pasteOrScanAddress => 'Paste or scan address';

  @override
  String get paste => 'Paste';

  @override
  String get walletLabel => 'Wallet label';

  @override
  String get enterWalletLabel => 'Enter Wallet label';

  @override
  String get save => 'Save';

  @override
  String get addNewAddress => 'Add new address';

  @override
  String get shareAddress => 'Share address';

  @override
  String get max => 'Max';

  @override
  String get sendOnly => 'Send only';

  @override
  String get viaThe => 'via the';

  @override
  String assetSentTo(String assetName) {
    return '$assetName was successfully sent to';
  }

  @override
  String get amount => 'Amount';

  @override
  String get sendTo => 'Send to';

  @override
  String get to => 'To';

  @override
  String get fee => 'Fee';

  @override
  String get memo => 'Memo';

  @override
  String get preview => 'Preview';

  @override
  String get sent => 'Sent!';

  @override
  String get noSavedAddresses => 'No saved addresses yet';

  @override
  String get noSavedAddressesDesc =>
      'Save your go-to crypto addresses so sending funds is faster and safer.';

  @override
  String get copyAddress => 'Copy address';

  @override
  String get edit => 'Edit';

  @override
  String get addressRemoved => 'Address removed';

  @override
  String get contractsDesc => 'Create, manage, and track your contracts.';

  @override
  String get payCycleDesc => 'Manage payments and log work submissions.';

  @override
  String get invoiceDesc => 'Create and send invoices with ease.';

  @override
  String get expensesDesc => 'Log and manage project expenses.';

  @override
  String get timesheetsDesc => 'Track hours and log work time.';

  @override
  String get timeOffDesc => 'Request, schedule, and manage time off.';

  @override
  String get addAddress => 'Add address';

  @override
  String get receivedFromWallet => 'Received from wallet';

  @override
  String get defiStakingReward => 'DeFi Staking Reward';

  @override
  String get withdrawal => 'Withdrawal';

  @override
  String get networkUsingAnyOtherAssetOrNetworkWillResultInPerm =>
      'network. Using any other asset or network will result in permanent loss.';

  @override
  String myAsset(String assetName) {
    return 'My $assetName';
  }

  @override
  String get walletAddressCopiedToClipboard =>
      'Wallet address copied to clipboard.';

  @override
  String get enterNewPassword => 'Enter New Password';

  @override
  String get passwordHasBeenReset => 'Password Has Been Reset!';

  @override
  String get youCanNowLogInWithYourNewPasswordAndContinueUsingY =>
      'You can now log in with your new password and continue using your account securely.';

  @override
  String get proceedToLogin => 'Proceed to login';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterYourEmailAddressToGetACodeToResetYourPassword =>
      'Enter your email address to get a code to reset your password.';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get tryCheckingYourJunkspamFolderOrResendTheCode =>
      'Try checking your junk/spam folder, or resend the code.';

  @override
  String get pleaseEnterThe6DigitOtpCodeSentTo =>
      'Please enter the 6 digit OTP code sent to';

  @override
  String get verifyCode => 'Verify code';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get enterYourDetailsBelowToLoginToYourAccount =>
      'Enter your details below to login to your account.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get logIn => 'Log In';

  @override
  String get logInUsingGoogle => 'Log in using Google';

  @override
  String get logInUsingApple => 'Log in using Apple';

  @override
  String get forgotYourPin => 'Forgot your PIN?';

  @override
  String get welcomeBackUsername => 'Welcome Back, \$userName';

  @override
  String get pleaseEnterYourPinToAccessYourAccount =>
      'Please enter your PIN to access your account.';

  @override
  String get enterPin => 'Enter PIN';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'strings_en.dart';
import 'strings_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings)!;
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'My App'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// A welcome message with a name parameter
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String hello(String name);

  /// A plural message for counter items
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String counter(int count);

  /// Sign in button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Sign up button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Forgot password button text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Settings menu item
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Light mode setting
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// System theme mode setting
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get systemMode;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personalDetails;

  /// No description provided for @manageWallet.
  ///
  /// In en, this message translates to:
  /// **'Manage wallet'**
  String get manageWallet;

  /// No description provided for @addressBook.
  ///
  /// In en, this message translates to:
  /// **'Address book'**
  String get addressBook;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @changePIN.
  ///
  /// In en, this message translates to:
  /// **'Change PIN'**
  String get changePIN;

  /// No description provided for @useFaceIdFingerprint.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID / Fingerprint'**
  String get useFaceIdFingerprint;

  /// No description provided for @twoFactorAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Two-factor authentication'**
  String get twoFactorAuthentication;

  /// No description provided for @deviceManagement.
  ///
  /// In en, this message translates to:
  /// **'Device management'**
  String get deviceManagement;

  /// No description provided for @appAppearance.
  ///
  /// In en, this message translates to:
  /// **'App appearance'**
  String get appAppearance;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushNotifications;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguage;

  /// No description provided for @helpFeedback.
  ///
  /// In en, this message translates to:
  /// **'Help & feedback'**
  String get helpFeedback;

  /// No description provided for @visitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit website'**
  String get visitWebsite;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @versionInfo.
  ///
  /// In en, this message translates to:
  /// **'Version {version} (Build {build})'**
  String versionInfo(String version, String build);

  /// No description provided for @appAppearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize the look and feel of the app by choosing your preferred theme and app icon.'**
  String get appAppearanceSubtitle;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @appIcon.
  ///
  /// In en, this message translates to:
  /// **'App icon'**
  String get appIcon;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @legalFirstName.
  ///
  /// In en, this message translates to:
  /// **'Legal first name'**
  String get legalFirstName;

  /// No description provided for @legalLastName.
  ///
  /// In en, this message translates to:
  /// **'Legal last name'**
  String get legalLastName;

  /// No description provided for @countryOfCitizenship.
  ///
  /// In en, this message translates to:
  /// **'Country of citizenship'**
  String get countryOfCitizenship;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @phoneNo.
  ///
  /// In en, this message translates to:
  /// **'Phone no'**
  String get phoneNo;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account details'**
  String get accountDetails;

  /// No description provided for @taxInformation.
  ///
  /// In en, this message translates to:
  /// **'Tax information'**
  String get taxInformation;

  /// No description provided for @countryOfTaxResidence.
  ///
  /// In en, this message translates to:
  /// **'Country of tax residence'**
  String get countryOfTaxResidence;

  /// No description provided for @taxId.
  ///
  /// In en, this message translates to:
  /// **'Tax ID'**
  String get taxId;

  /// No description provided for @profilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profilePhoto;

  /// No description provided for @editPhoto.
  ///
  /// In en, this message translates to:
  /// **'Edit photo'**
  String get editPhoto;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @profileDetails.
  ///
  /// In en, this message translates to:
  /// **'Profile details'**
  String get profileDetails;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please provide your personal details, this will be used to complete your profile.'**
  String get changePasswordSubtitle;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @passwordRequirementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Must Contain At Least:'**
  String get passwordRequirementsTitle;

  /// No description provided for @passwordReq8Chars.
  ///
  /// In en, this message translates to:
  /// **'8 characters'**
  String get passwordReq8Chars;

  /// No description provided for @passwordReqNumber.
  ///
  /// In en, this message translates to:
  /// **'A number'**
  String get passwordReqNumber;

  /// No description provided for @passwordReqUppercase.
  ///
  /// In en, this message translates to:
  /// **'An uppercase letter'**
  String get passwordReqUppercase;

  /// No description provided for @passwordReqLowercase.
  ///
  /// In en, this message translates to:
  /// **'A lowercase letter'**
  String get passwordReqLowercase;

  /// No description provided for @passwordReqSpecial.
  ///
  /// In en, this message translates to:
  /// **'A special character'**
  String get passwordReqSpecial;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Your new password is what you\'ll use to access your account.'**
  String get confirmNewPasswordHint;

  /// No description provided for @deviceManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See all devices that have logged into your account. Remove any for added security.'**
  String get deviceManagementSubtitle;

  /// No description provided for @currentDevice.
  ///
  /// In en, this message translates to:
  /// **'Current device'**
  String get currentDevice;

  /// No description provided for @otherDevices.
  ///
  /// In en, this message translates to:
  /// **'Other devices'**
  String get otherDevices;

  /// No description provided for @deleteDevice.
  ///
  /// In en, this message translates to:
  /// **'Delete device'**
  String get deleteDevice;

  /// No description provided for @deleteDeviceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this device? Password will be required to sign in again.'**
  String get deleteDeviceConfirm;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @logOutAllDevices.
  ///
  /// In en, this message translates to:
  /// **'Log out all known devices'**
  String get logOutAllDevices;

  /// No description provided for @logOutAllDevicesConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out all known devices? You\'ll need to sign in again on each one.'**
  String get logOutAllDevicesConfirm;

  /// No description provided for @logOutAllDevicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Out All Known Devices'**
  String get logOutAllDevicesTitle;

  /// No description provided for @logOutAllDevicesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ll have to log back in on all logged out devices.'**
  String get logOutAllDevicesSubtitle;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location:'**
  String get location;

  /// No description provided for @lastLogin.
  ///
  /// In en, this message translates to:
  /// **'Last login:'**
  String get lastLogin;

  /// No description provided for @helpFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find answers in our Help Center or contact support for account, wallet, or other issues.'**
  String get helpFeedbackSubtitle;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get helpCenter;

  /// No description provided for @helpCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find answers fast with articles and FAQs covering common questions and issues.'**
  String get helpCenterSubtitle;

  /// No description provided for @chatWithUs.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get chatWithUs;

  /// No description provided for @chatWithUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Need quick help? Start a live chat for quick help from our support team.'**
  String get chatWithUsSubtitle;

  /// No description provided for @leaveFeedback.
  ///
  /// In en, this message translates to:
  /// **'Leave feedback'**
  String get leaveFeedback;

  /// No description provided for @leaveFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you think. Your feedback helps us improve your experience.'**
  String get leaveFeedbackSubtitle;

  /// No description provided for @followUsOnSocialMedia.
  ///
  /// In en, this message translates to:
  /// **'Follow us on social media'**
  String get followUsOnSocialMedia;

  /// No description provided for @followUsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get updates, tips, and news by following us on your favorite platforms.'**
  String get followUsSubtitle;

  /// No description provided for @wallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get wallets;

  /// No description provided for @manageWalletSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your wallet details and securely access your private key.'**
  String get manageWalletSubtitle;

  /// No description provided for @setupTwoFaTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up 2FA for your transactions'**
  String get setupTwoFaTitle;

  /// No description provided for @setupTwoFaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Activate two factor authentication to have an extra layer of security on your account, transactions will need a code from an authenticator app when enabled'**
  String get setupTwoFaSubtitle;

  /// No description provided for @activateNow.
  ///
  /// In en, this message translates to:
  /// **'Activate now'**
  String get activateNow;

  /// No description provided for @twoFaCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'2FA setup complete'**
  String get twoFaCompleteTitle;

  /// No description provided for @twoFaCompleteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Two factor authentication is enabled, we\'ll use your authenticator app codes for transactions'**
  String get twoFaCompleteSubtitle;

  /// No description provided for @backToSettings.
  ///
  /// In en, this message translates to:
  /// **'Back to settings'**
  String get backToSettings;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get totalBalance;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @transactionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Transactions will appear here'**
  String get transactionsEmpty;

  /// No description provided for @upcomingPayments.
  ///
  /// In en, this message translates to:
  /// **'Upcoming payments'**
  String get upcomingPayments;

  /// No description provided for @upcomingPaymentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Upcoming payments will appear here'**
  String get upcomingPaymentsEmpty;

  /// No description provided for @workspace.
  ///
  /// In en, this message translates to:
  /// **'Workspace'**
  String get workspace;

  /// No description provided for @contracts.
  ///
  /// In en, this message translates to:
  /// **'Contracts'**
  String get contracts;

  /// No description provided for @payCycle.
  ///
  /// In en, this message translates to:
  /// **'Pay cycle'**
  String get payCycle;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @timesheets.
  ///
  /// In en, this message translates to:
  /// **'Timesheets'**
  String get timesheets;

  /// No description provided for @timeOff.
  ///
  /// In en, this message translates to:
  /// **'Time off'**
  String get timeOff;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receive;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @assets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assets;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get needHelp;

  /// No description provided for @noContractsYet.
  ///
  /// In en, this message translates to:
  /// **'Contracts will appear here'**
  String get noContractsYet;

  /// No description provided for @exportPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Export private key'**
  String get exportPrivateKey;

  /// No description provided for @exportPrivateKeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your Private Key is the key used to back up your wallet. Keep it secret and secure at all times.'**
  String get exportPrivateKeySubtitle;

  /// No description provided for @keepScreenPrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep Your Screen Private'**
  String get keepScreenPrivateTitle;

  /// No description provided for @keepScreenPrivateDesc.
  ///
  /// In en, this message translates to:
  /// **'Screenshots or recordings of your private keys can lead to wallet loss.'**
  String get keepScreenPrivateDesc;

  /// No description provided for @storeKeysOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Store Keys Offline'**
  String get storeKeysOfflineTitle;

  /// No description provided for @storeKeysOfflineDesc.
  ///
  /// In en, this message translates to:
  /// **'Avoid sharing or saving your keys in the cloud, as they are easily compromised.'**
  String get storeKeysOfflineDesc;

  /// No description provided for @yourKeyYourWalletTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Key, Your Wallet'**
  String get yourKeyYourWalletTitle;

  /// No description provided for @yourKeyYourWalletDesc.
  ///
  /// In en, this message translates to:
  /// **'Anyone with your private keys can access and steal your assets.'**
  String get yourKeyYourWalletDesc;

  /// No description provided for @revealPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Reveal private key'**
  String get revealPrivateKey;

  /// No description provided for @yourPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Your private key'**
  String get yourPrivateKey;

  /// No description provided for @doNotSharePrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Do Not Share Your Private Key'**
  String get doNotSharePrivateKey;

  /// No description provided for @privateKeyWarning.
  ///
  /// In en, this message translates to:
  /// **'Your private key gives full access to your wallet. Never share it with anyone. If someone else gets it, they can steal your assets.'**
  String get privateKeyWarning;

  /// No description provided for @copyToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copy to clipboard'**
  String get copyToClipboard;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @addressCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get addressCopiedToClipboard;

  /// No description provided for @privateKeyCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Private key copied to clipboard'**
  String get privateKeyCopiedToClipboard;

  /// No description provided for @setupInstructions.
  ///
  /// In en, this message translates to:
  /// **'Setup Instructions'**
  String get setupInstructions;

  /// No description provided for @scanQrCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code'**
  String get scanQrCodeTitle;

  /// No description provided for @scanQrCodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code above with your authenticator app to get generated codes from your authenticator app'**
  String get scanQrCodeDesc;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @copySetupKey.
  ///
  /// In en, this message translates to:
  /// **'Copy setup key'**
  String get copySetupKey;

  /// No description provided for @viewBarcodeQrCode.
  ///
  /// In en, this message translates to:
  /// **'View barcode / QR code'**
  String get viewBarcodeQrCode;

  /// No description provided for @setupKeyCopied.
  ///
  /// In en, this message translates to:
  /// **'Setup key copied to clipboard.'**
  String get setupKeyCopied;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Download an authenticator app'**
  String get step1Title;

  /// No description provided for @step1Desc.
  ///
  /// In en, this message translates to:
  /// **'We recommend downloading Google Authenticator if you don\'t have one installed.'**
  String get step1Desc;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Scan or copy the setup key below'**
  String get step2Title;

  /// No description provided for @step2Desc.
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code from the app or copy the key and paste it in the authenticator app'**
  String get step2Desc;

  /// No description provided for @step3Title.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code'**
  String get step3Title;

  /// No description provided for @step3Desc.
  ///
  /// In en, this message translates to:
  /// **'If you scanned the QR code from step 2, your 2FA will auto complete setup and generate a 6-digit auth code for you. If you copied the code from step 2, then you have to select key type as \'Time based\' to complete setup.'**
  String get step3Desc;

  /// No description provided for @twoFaAuthCode.
  ///
  /// In en, this message translates to:
  /// **'2FA Auth Code'**
  String get twoFaAuthCode;

  /// No description provided for @twoFaAuthCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter in the 6-digit code generated by the authenticator app'**
  String get twoFaAuthCodeSubtitle;

  /// No description provided for @currentPINCode.
  ///
  /// In en, this message translates to:
  /// **'Current PIN Code'**
  String get currentPINCode;

  /// No description provided for @currentPINCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please provide your current 4 digit PIN'**
  String get currentPINCodeSubtitle;

  /// No description provided for @incorrectPIN.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. Please try again.'**
  String get incorrectPIN;

  /// No description provided for @newPINCode.
  ///
  /// In en, this message translates to:
  /// **'New PIN Code'**
  String get newPINCode;

  /// No description provided for @newPINCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a 4 digit code you will use to log in, without entering your login credentials.'**
  String get newPINCodeSubtitle;

  /// No description provided for @confirmNewPINCode.
  ///
  /// In en, this message translates to:
  /// **'Confirm New PIN Code'**
  String get confirmNewPINCode;

  /// No description provided for @confirmNewPINCodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 4 digit code you entered again for confirmation.'**
  String get confirmNewPINCodeSubtitle;

  /// No description provided for @pinsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match. Please try again.'**
  String get pinsDoNotMatch;

  /// No description provided for @deleteAccountReason.
  ///
  /// In en, this message translates to:
  /// **'Please tell us why have you decided to delete your account?'**
  String get deleteAccountReason;

  /// No description provided for @deleteAccountWarning1.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account is irreversible.'**
  String get deleteAccountWarning1;

  /// No description provided for @deleteAccountWarning2.
  ///
  /// In en, this message translates to:
  /// **'You will lose all accumulated data but retain account access.'**
  String get deleteAccountWarning2;

  /// No description provided for @deleteAccountCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Would you like to leave any suggestions or comments?'**
  String get deleteAccountCommentHint;

  /// No description provided for @editProfileDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit profile details'**
  String get editProfileDetails;

  /// No description provided for @editProfileDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your personal information to keep your profile accurate and up to date.'**
  String get editProfileDetailsSubtitle;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @dialCode.
  ///
  /// In en, this message translates to:
  /// **'Dial code'**
  String get dialCode;

  /// No description provided for @editAddressDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit address details'**
  String get editAddressDetails;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @postalZipCode.
  ///
  /// In en, this message translates to:
  /// **'Postal / zip code'**
  String get postalZipCode;

  /// No description provided for @editAccountDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit account details'**
  String get editAccountDetails;

  /// No description provided for @editAccountDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your email to maintain account access and receive important notifications.'**
  String get editAccountDetailsSubtitle;

  /// No description provided for @currentEmail.
  ///
  /// In en, this message translates to:
  /// **'Current email'**
  String get currentEmail;

  /// No description provided for @newEmail.
  ///
  /// In en, this message translates to:
  /// **'New email'**
  String get newEmail;

  /// No description provided for @editTaxInformation.
  ///
  /// In en, this message translates to:
  /// **'Edit tax information'**
  String get editTaxInformation;

  /// No description provided for @editTaxInformationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your tax details to ensure compliance with regulations and accurate reporting.'**
  String get editTaxInformationSubtitle;

  /// No description provided for @asset.
  ///
  /// In en, this message translates to:
  /// **'Asset'**
  String get asset;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @selectAsset.
  ///
  /// In en, this message translates to:
  /// **'Select Asset'**
  String get selectAsset;

  /// No description provided for @selectNetwork.
  ///
  /// In en, this message translates to:
  /// **'Select Network'**
  String get selectNetwork;

  /// No description provided for @pasteOrScanAddress.
  ///
  /// In en, this message translates to:
  /// **'Paste or scan address'**
  String get pasteOrScanAddress;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @walletLabel.
  ///
  /// In en, this message translates to:
  /// **'Wallet label'**
  String get walletLabel;

  /// No description provided for @enterWalletLabel.
  ///
  /// In en, this message translates to:
  /// **'Enter Wallet label'**
  String get enterWalletLabel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// No description provided for @shareAddress.
  ///
  /// In en, this message translates to:
  /// **'Share address'**
  String get shareAddress;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @sendOnly.
  ///
  /// In en, this message translates to:
  /// **'Send only'**
  String get sendOnly;

  /// No description provided for @viaThe.
  ///
  /// In en, this message translates to:
  /// **'via the'**
  String get viaThe;

  /// No description provided for @assetSentTo.
  ///
  /// In en, this message translates to:
  /// **'{assetName} was successfully sent to'**
  String assetSentTo(String assetName);

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @sendTo.
  ///
  /// In en, this message translates to:
  /// **'Send to'**
  String get sendTo;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// No description provided for @memo.
  ///
  /// In en, this message translates to:
  /// **'Memo'**
  String get memo;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent!'**
  String get sent;

  /// No description provided for @noSavedAddresses.
  ///
  /// In en, this message translates to:
  /// **'No saved addresses yet'**
  String get noSavedAddresses;

  /// No description provided for @noSavedAddressesDesc.
  ///
  /// In en, this message translates to:
  /// **'Save your go-to crypto addresses so sending funds is faster and safer.'**
  String get noSavedAddressesDesc;

  /// No description provided for @copyAddress.
  ///
  /// In en, this message translates to:
  /// **'Copy address'**
  String get copyAddress;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @addressRemoved.
  ///
  /// In en, this message translates to:
  /// **'Address removed'**
  String get addressRemoved;

  /// No description provided for @contractsDesc.
  ///
  /// In en, this message translates to:
  /// **'Create, manage, and track your contracts.'**
  String get contractsDesc;

  /// No description provided for @payCycleDesc.
  ///
  /// In en, this message translates to:
  /// **'Manage payments and log work submissions.'**
  String get payCycleDesc;

  /// No description provided for @invoiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Create and send invoices with ease.'**
  String get invoiceDesc;

  /// No description provided for @expensesDesc.
  ///
  /// In en, this message translates to:
  /// **'Log and manage project expenses.'**
  String get expensesDesc;

  /// No description provided for @timesheetsDesc.
  ///
  /// In en, this message translates to:
  /// **'Track hours and log work time.'**
  String get timesheetsDesc;

  /// No description provided for @timeOffDesc.
  ///
  /// In en, this message translates to:
  /// **'Request, schedule, and manage time off.'**
  String get timeOffDesc;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddress;

  /// No description provided for @receivedFromWallet.
  ///
  /// In en, this message translates to:
  /// **'Received from wallet'**
  String get receivedFromWallet;

  /// No description provided for @defiStakingReward.
  ///
  /// In en, this message translates to:
  /// **'DeFi Staking Reward'**
  String get defiStakingReward;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @networkUsingAnyOtherAssetOrNetworkWillResultInPerm.
  ///
  /// In en, this message translates to:
  /// **'network. Using any other asset or network will result in permanent loss.'**
  String get networkUsingAnyOtherAssetOrNetworkWillResultInPerm;

  /// No description provided for @myAsset.
  ///
  /// In en, this message translates to:
  /// **'My {assetName}'**
  String myAsset(String assetName);

  /// No description provided for @walletAddressCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Wallet address copied to clipboard.'**
  String get walletAddressCopiedToClipboard;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @passwordHasBeenReset.
  ///
  /// In en, this message translates to:
  /// **'Password Has Been Reset!'**
  String get passwordHasBeenReset;

  /// No description provided for @youCanNowLogInWithYourNewPasswordAndContinueUsingY.
  ///
  /// In en, this message translates to:
  /// **'You can now log in with your new password and continue using your account securely.'**
  String get youCanNowLogInWithYourNewPasswordAndContinueUsingY;

  /// No description provided for @proceedToLogin.
  ///
  /// In en, this message translates to:
  /// **'Proceed to login'**
  String get proceedToLogin;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @enterYourEmailAddressToGetACodeToResetYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to get a code to reset your password.'**
  String get enterYourEmailAddressToGetACodeToResetYourPassword;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @tryCheckingYourJunkspamFolderOrResendTheCode.
  ///
  /// In en, this message translates to:
  /// **'Try checking your junk/spam folder, or resend the code.'**
  String get tryCheckingYourJunkspamFolderOrResendTheCode;

  /// No description provided for @pleaseEnterThe6DigitOtpCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6 digit OTP code sent to'**
  String get pleaseEnterThe6DigitOtpCodeSentTo;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyCode;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @enterYourDetailsBelowToLoginToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Enter your details below to login to your account.'**
  String get enterYourDetailsBelowToLoginToYourAccount;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @logInUsingGoogle.
  ///
  /// In en, this message translates to:
  /// **'Log in using Google'**
  String get logInUsingGoogle;

  /// No description provided for @logInUsingApple.
  ///
  /// In en, this message translates to:
  /// **'Log in using Apple'**
  String get logInUsingApple;

  /// No description provided for @forgotYourPin.
  ///
  /// In en, this message translates to:
  /// **'Forgot your PIN?'**
  String get forgotYourPin;

  /// No description provided for @welcomeBackUsername.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back, \$userName'**
  String get welcomeBackUsername;

  /// No description provided for @pleaseEnterYourPinToAccessYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Please enter your PIN to access your account.'**
  String get pleaseEnterYourPinToAccessYourAccount;

  /// No description provided for @enterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN'**
  String get enterPin;
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return StringsEn();
    case 'es':
      return StringsEs();
  }

  throw FlutterError(
      'Strings.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}

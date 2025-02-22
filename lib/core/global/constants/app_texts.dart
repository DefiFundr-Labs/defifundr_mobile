class AppTexts {
  //! AUTHENTICATION
  static String createAccount = "Create an account";
  static String createAccountDescription =
      "Enter your credentials to get started";
  static String termsAndConditions =
      "By creating an account, you agree to our ";
  static String termsAndConditionsLink = "Terms and Conditions";
  static String createAccountButton = "Create my account";
  static String accountLogin = "Login to my account";
  static String firstName = "User Name";
  static String fillEmail = "Your email address";
  static String fillEmailLogin = "Your email address or username";
  static String forgetPasswordLogin = "Your email address";
  static String emailInvalid = "Email is invalid";
  static String fieldEmpty(String field) => "$field can't be empty";
  static String alreadyHaveAccount = "Already have an account?";
  static String dontHaveAccount = "Don't have an account?";
  static String verifyOTP = "Verify your Email";
  static String verify = "Verify";
  static String verifyOTPDescription(String email) =>
      "OTP has been sent to $email";
  static String notYourEmail(String email) => "Not $email?";
  static String signUp = "Sign up";
  static String resendOTP = "Resend OTP";
  static String editEmail = "Edit Email";
  static String editEmailDesc = "Please re-enter your email";
  static String password = "Password";
  static String confirmPassword = "Confirm Password";
  static String passwordText = "Create your password";
  static String capitalLetter = "Capital letter";
  static String number = "Must Contain At least One number";
  static String specialCharacter = "At least One special character";
  static String chacterLength = "At least 8 characters";
  static String passwordNotMatch = "Password does not match";
  static String looksGood = "Looks Good!";
  static String useBiometrics = "Use my Biometrics";
  static String login = "Login";
  static String loginDesc = "Enter Your Email to Proceed";
  static String forgetDetails = "Forgot my login details";
  static String biometrics = "Use Biometrics";
  static String selectAvatar = "Select Avatar";
  static String selectAvatarDesc = "Choose your avatar";
  static String usernameAlreadyTaken = "Username Already Exists";
  static String dashboard = "Get Started";
  static String forgotPassword = "Forget Password";
  static String neeHelp="Need Help?";
  static String forgotPasswordDesc =
      "Ooops! don’t worry,\nthe process is simpler than you thought";
  static String forgotPasswordButton = "Continue";
  static String resetPassword = "Reset Password";
  static String resetPasswordDesc =
      "Enter your email or username to reset password";
  static String resetPasswordButton = "Reset Password";
  static String biometricsToContinue = "Please use your biometrics to continue";
  static String resetOTP = "Reset OTP";
  static String resetPassDesc = "Enter new password to reset";
  static String hiUser(String username) => "Hello $username,";
  static String notUser(String username) => "Not $username?";
  static String loginDiff = "Login as a different user";
  static String invalidCode = "invalid otp code";
  static String incompleteRegistration = "incomplete registration";
  static String userNotVerified = "user not verified";
  static String didYouKnow = "Did you know?";
  static String privateKey = "Private Key";
  static String recoveryOrSeedPhrase = "Recovery or Seed Phrase";
  static String pasteYourRecoveryPhrase = "Paste your recovery phrase";
  static String pasteOrTypePrivateKey = "Paste or type private key";
  static String clear = "Clear";
  static String whatIsARecoveryPhrase = "What is a recovery phrase?";
  static String learnMore = "Learn more";
  static String importMyAccount = "Import my account";
  static String yourPrivateKeyIsA64Char =
      "Your private key is a 64 character special kind of password. It is one way to access your account. Never share it with anyone!";
  static String yourRecoveryOrSeedPhrase =
      "Your recovery or seed phrase is a 12 word special kind of password. it is another way to access your account and it must be kept private!";

  //! DASHBOARD
  static String searchCampaign = "Search Campaign";
  static String balance = "Balance";
  static String topUp = "Top Up";
  static String discoverCampaign = "Discover Campaign";
  static String latestFundRaiser = "Latest Fundraising";
  static String education = "Education";
  static String placeHolderName = "Joe Doe";
  static String donation = "Donation";
  static String createDonation = "Create Donation";
  static String copied = "Copied to clipboard";

  //! DONATION
  static String donationDesc = "Enter the amount you want to donate";
  static String aboutDonation = "About Donations";
  static String organizedBy = "Organized by";
  static String viewDonations = "View Donations";
  static String donate = "Donate";
  static String viewDonors = "View Donors";
  static String loremIpsum =
      "This June, a mix of parents and staff are raising money in aid of Hawkedon Primary School Association and every donation will help, by completing the National 3 Peaks Challenge within 24 hours. Our brave challengers are; Rebeca Lovato, Ben Murphy, Dan Ronan, Sam Midwinter, Eddy Edwards, John O'Brien, Saskia Palmer, Oli Perry, Siva Singaravelu and Greg Jackson with our amazing volunteer driver Rachel Spencer.";
  static String share = "Share";
  static String shareDesc = "Share this campaign with your friends";
  static String amount2Donate = "Amount to Donate";
  static String proceed = "Proceed";
  static String availableBalance = "Available Balance";
  static String confirmDonation = "Confirm Donation Details";
  static String success = "Successful!!!";
  static String successDesc = "Your donation was successful";
  static String continueText = "Go to dashboard";
  static String walletAddr = "Wallet Address";
  static String copyAddr = "Copy address";
  static String campaignName = "Campaign Title";
  static String campaignDesc = "Campaign Description";
  static String campaignGoal = "Campaign Goal";
  static String selectCategory = "Select Category";
  static String deadline = "Select Deadline";
  static String emptyMyCampaigns = "No Campaigns Yet";
  static String emptyMyCampaignsDescription = "Create Donation";

  //! NAVIGATION
  static String home = "Home";
  static String navDonation = "Donations";
  static String navCampaign = "Campaigns";
  static String navProfile = "Profile";

  //! My Campaign
  static String myCampaign = "My Campaign";
  static String addCampaign = "Add Campaign";

  //! Profile
  static String profile = "Profile";
  static String editProfile = "Edit Profile";
  static String continueTo = "continue";
  static String changePassword = "Change Password";
  static String oldPassword = "Old Password";
  static String newPassword = "New Password";
  static String security = "Security";
  static String securityDesc = "Enter Password to Access Private Key";
  static String getPrivateKey = "Get Private Key";
  static String setPasscode = "Set a 6-digit passcode for login";
  static String passcode = "Passcode";
}

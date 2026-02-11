// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routers.dart';

/// generated route for
/// [AccountTypeScreen]
class AccountTypeRoute extends PageRouteInfo<void> {
  const AccountTypeRoute({List<PageRouteInfo>? children})
    : super(AccountTypeRoute.name, initialChildren: children);

  static const String name = 'AccountTypeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountTypeScreen();
    },
  );
}

/// generated route for
/// [AddAddressScreen]
class AddAddressRoute extends PageRouteInfo<void> {
  const AddAddressRoute({List<PageRouteInfo>? children})
    : super(AddAddressRoute.name, initialChildren: children);

  static const String name = 'AddAddressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddAddressScreen();
    },
  );
}

/// generated route for
/// [AddExpenseScreen]
class AddExpenseRoute extends PageRouteInfo<void> {
  const AddExpenseRoute({List<PageRouteInfo>? children})
    : super(AddExpenseRoute.name, initialChildren: children);

  static const String name = 'AddExpenseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddExpenseScreen();
    },
  );
}

/// generated route for
/// [AddressBookScreen]
class AddressBookRoute extends PageRouteInfo<void> {
  const AddressBookRoute({List<PageRouteInfo>? children})
    : super(AddressBookRoute.name, initialChildren: children);

  static const String name = 'AddressBookRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddressBookScreen();
    },
  );
}

/// generated route for
/// [AddressDetailsScreen]
class AddressDetailsRoute extends PageRouteInfo<void> {
  const AddressDetailsRoute({List<PageRouteInfo>? children})
    : super(AddressDetailsRoute.name, initialChildren: children);

  static const String name = 'AddressDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddressDetailsScreen();
    },
  );
}

/// generated route for
/// [AssetDepositScreen]
class AssetDepositRoute extends PageRouteInfo<AssetDepositRouteArgs> {
  AssetDepositRoute({
    Key? key,
    required NetworkAsset asset,
    required Network network,
    required String address,
    List<PageRouteInfo>? children,
  }) : super(
         AssetDepositRoute.name,
         args: AssetDepositRouteArgs(
           key: key,
           asset: asset,
           network: network,
           address: address,
         ),
         initialChildren: children,
       );

  static const String name = 'AssetDepositRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AssetDepositRouteArgs>();
      return AssetDepositScreen(
        key: args.key,
        asset: args.asset,
        network: args.network,
        address: args.address,
      );
    },
  );
}

class AssetDepositRouteArgs {
  const AssetDepositRouteArgs({
    this.key,
    required this.asset,
    required this.network,
    required this.address,
  });

  final Key? key;

  final NetworkAsset asset;

  final Network network;

  final String address;

  @override
  String toString() {
    return 'AssetDepositRouteArgs{key: $key, asset: $asset, network: $network, address: $address}';
  }
}

/// generated route for
/// [AssetDetailsScreen]
class AssetDetailsRoute extends PageRouteInfo<AssetDetailsRouteArgs> {
  AssetDetailsRoute({
    Key? key,
    required NetworkAsset asset,
    required Network network,
    List<PageRouteInfo>? children,
  }) : super(
         AssetDetailsRoute.name,
         args: AssetDetailsRouteArgs(key: key, asset: asset, network: network),
         initialChildren: children,
       );

  static const String name = 'AssetDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AssetDetailsRouteArgs>();
      return AssetDetailsScreen(
        key: args.key,
        asset: args.asset,
        network: args.network,
      );
    },
  );
}

class AssetDetailsRouteArgs {
  const AssetDetailsRouteArgs({
    this.key,
    required this.asset,
    required this.network,
  });

  final Key? key;

  final NetworkAsset asset;

  final Network network;

  @override
  String toString() {
    return 'AssetDetailsRouteArgs{key: $key, asset: $asset, network: $network}';
  }
}

/// generated route for
/// [CancelTimeOffRequestScreen]
class CancelTimeOffRequestRoute
    extends PageRouteInfo<CancelTimeOffRequestRouteArgs> {
  CancelTimeOffRequestRoute({
    Key? key,
    required TimeOffDetail timeOffDetail,
    List<PageRouteInfo>? children,
  }) : super(
         CancelTimeOffRequestRoute.name,
         args: CancelTimeOffRequestRouteArgs(
           key: key,
           timeOffDetail: timeOffDetail,
         ),
         initialChildren: children,
       );

  static const String name = 'CancelTimeOffRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CancelTimeOffRequestRouteArgs>();
      return CancelTimeOffRequestScreen(
        key: args.key,
        timeOffDetail: args.timeOffDetail,
      );
    },
  );
}

class CancelTimeOffRequestRouteArgs {
  const CancelTimeOffRequestRouteArgs({this.key, required this.timeOffDetail});

  final Key? key;

  final TimeOffDetail timeOffDetail;

  @override
  String toString() {
    return 'CancelTimeOffRequestRouteArgs{key: $key, timeOffDetail: $timeOffDetail}';
  }
}

/// generated route for
/// [ConfirmPaymentScreen]
class ConfirmPaymentRoute extends PageRouteInfo<ConfirmPaymentRouteArgs> {
  ConfirmPaymentRoute({
    Key? key,
    WithdrawDetailsModel? withdrawDetails,
    List<PageRouteInfo>? children,
  }) : super(
         ConfirmPaymentRoute.name,
         args: ConfirmPaymentRouteArgs(
           key: key,
           withdrawDetails: withdrawDetails,
         ),
         initialChildren: children,
       );

  static const String name = 'ConfirmPaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ConfirmPaymentRouteArgs>(
        orElse: () => const ConfirmPaymentRouteArgs(),
      );
      return ConfirmPaymentScreen(
        key: args.key,
        withdrawDetails: args.withdrawDetails,
      );
    },
  );
}

class ConfirmPaymentRouteArgs {
  const ConfirmPaymentRouteArgs({this.key, this.withdrawDetails});

  final Key? key;

  final WithdrawDetailsModel? withdrawDetails;

  @override
  String toString() {
    return 'ConfirmPaymentRouteArgs{key: $key, withdrawDetails: $withdrawDetails}';
  }
}

/// generated route for
/// [ConfirmPinScreen]
class ConfirmPinRoute extends PageRouteInfo<void> {
  const ConfirmPinRoute({List<PageRouteInfo>? children})
    : super(ConfirmPinRoute.name, initialChildren: children);

  static const String name = 'ConfirmPinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConfirmPinScreen();
    },
  );
}

/// generated route for
/// [ContractDetailScreen]
class ContractDetailRoute extends PageRouteInfo<ContractDetailRouteArgs> {
  ContractDetailRoute({
    Key? key,
    required PayCycleContract contract,
    List<PageRouteInfo>? children,
  }) : super(
         ContractDetailRoute.name,
         args: ContractDetailRouteArgs(key: key, contract: contract),
         initialChildren: children,
       );

  static const String name = 'ContractDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContractDetailRouteArgs>();
      return ContractDetailScreen(key: args.key, contract: args.contract);
    },
  );
}

class ContractDetailRouteArgs {
  const ContractDetailRouteArgs({this.key, required this.contract});

  final Key? key;

  final PayCycleContract contract;

  @override
  String toString() {
    return 'ContractDetailRouteArgs{key: $key, contract: $contract}';
  }
}

/// generated route for
/// [CreateAccountScreen]
class CreateAccountRoute extends PageRouteInfo<void> {
  const CreateAccountRoute({List<PageRouteInfo>? children})
    : super(CreateAccountRoute.name, initialChildren: children);

  static const String name = 'CreateAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateAccountScreen();
    },
  );
}

/// generated route for
/// [CreateInvoiceFlowScreen]
class CreateInvoiceFlowRoute extends PageRouteInfo<void> {
  const CreateInvoiceFlowRoute({List<PageRouteInfo>? children})
    : super(CreateInvoiceFlowRoute.name, initialChildren: children);

  static const String name = 'CreateInvoiceFlowRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateInvoiceFlowScreen();
    },
  );
}

/// generated route for
/// [CreatePasswordScreen]
class CreatePasswordRoute extends PageRouteInfo<void> {
  const CreatePasswordRoute({List<PageRouteInfo>? children})
    : super(CreatePasswordRoute.name, initialChildren: children);

  static const String name = 'CreatePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreatePasswordScreen();
    },
  );
}

/// generated route for
/// [CreatePinScreen]
class CreatePinRoute extends PageRouteInfo<void> {
  const CreatePinRoute({List<PageRouteInfo>? children})
    : super(CreatePinRoute.name, initialChildren: children);

  static const String name = 'CreatePinRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreatePinScreen();
    },
  );
}

/// generated route for
/// [EditTimeOffRequestScreen]
class EditTimeOffRequestRoute
    extends PageRouteInfo<EditTimeOffRequestRouteArgs> {
  EditTimeOffRequestRoute({
    Key? key,
    required TimeOffDetail timeOffDetail,
    List<PageRouteInfo>? children,
  }) : super(
         EditTimeOffRequestRoute.name,
         args: EditTimeOffRequestRouteArgs(
           key: key,
           timeOffDetail: timeOffDetail,
         ),
         initialChildren: children,
       );

  static const String name = 'EditTimeOffRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditTimeOffRequestRouteArgs>();
      return EditTimeOffRequestScreen(
        key: args.key,
        timeOffDetail: args.timeOffDetail,
      );
    },
  );
}

class EditTimeOffRequestRouteArgs {
  const EditTimeOffRequestRouteArgs({this.key, required this.timeOffDetail});

  final Key? key;

  final TimeOffDetail timeOffDetail;

  @override
  String toString() {
    return 'EditTimeOffRequestRouteArgs{key: $key, timeOffDetail: $timeOffDetail}';
  }
}

/// generated route for
/// [EnableFaceIdScreen]
class EnableFaceIdRoute extends PageRouteInfo<void> {
  const EnableFaceIdRoute({List<PageRouteInfo>? children})
    : super(EnableFaceIdRoute.name, initialChildren: children);

  static const String name = 'EnableFaceIdRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EnableFaceIdScreen();
    },
  );
}

/// generated route for
/// [EnableFingerprintScreen]
class EnableFingerprintRoute extends PageRouteInfo<void> {
  const EnableFingerprintRoute({List<PageRouteInfo>? children})
    : super(EnableFingerprintRoute.name, initialChildren: children);

  static const String name = 'EnableFingerprintRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EnableFingerprintScreen();
    },
  );
}

/// generated route for
/// [EnablePushNotificationScreen]
class EnablePushNotificationRoute extends PageRouteInfo<void> {
  const EnablePushNotificationRoute({List<PageRouteInfo>? children})
    : super(EnablePushNotificationRoute.name, initialChildren: children);

  static const String name = 'EnablePushNotificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EnablePushNotificationScreen();
    },
  );
}

/// generated route for
/// [ExpenseDetailsScreen]
class ExpenseDetailsRoute extends PageRouteInfo<ExpenseDetailsRouteArgs> {
  ExpenseDetailsRoute({
    Key? key,
    required Expense expense,
    List<PageRouteInfo>? children,
  }) : super(
         ExpenseDetailsRoute.name,
         args: ExpenseDetailsRouteArgs(key: key, expense: expense),
         initialChildren: children,
       );

  static const String name = 'ExpenseDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExpenseDetailsRouteArgs>();
      return ExpenseDetailsScreen(key: args.key, expense: args.expense);
    },
  );
}

class ExpenseDetailsRouteArgs {
  const ExpenseDetailsRouteArgs({this.key, required this.expense});

  final Key? key;

  final Expense expense;

  @override
  String toString() {
    return 'ExpenseDetailsRouteArgs{key: $key, expense: $expense}';
  }
}

/// generated route for
/// [ExpenseSubmittedScreen]
class ExpenseSubmittedRoute extends PageRouteInfo<void> {
  const ExpenseSubmittedRoute({List<PageRouteInfo>? children})
    : super(ExpenseSubmittedRoute.name, initialChildren: children);

  static const String name = 'ExpenseSubmittedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExpenseSubmittedScreen();
    },
  );
}

/// generated route for
/// [ExpensesScreen]
class ExpensesRoute extends PageRouteInfo<void> {
  const ExpensesRoute({List<PageRouteInfo>? children})
    : super(ExpensesRoute.name, initialChildren: children);

  static const String name = 'ExpensesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExpensesScreen();
    },
  );
}

/// generated route for
/// [ExpensesTimeOffDetailsScreen]
class ExpensesTimeOffDetailsRoute
    extends PageRouteInfo<ExpensesTimeOffDetailsRouteArgs> {
  ExpensesTimeOffDetailsRoute({
    Key? key,
    required Expense expense,
    List<PageRouteInfo>? children,
  }) : super(
         ExpensesTimeOffDetailsRoute.name,
         args: ExpensesTimeOffDetailsRouteArgs(key: key, expense: expense),
         initialChildren: children,
       );

  static const String name = 'ExpensesTimeOffDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExpensesTimeOffDetailsRouteArgs>();
      return ExpensesTimeOffDetailsScreen(key: args.key, expense: args.expense);
    },
  );
}

class ExpensesTimeOffDetailsRouteArgs {
  const ExpensesTimeOffDetailsRouteArgs({this.key, required this.expense});

  final Key? key;

  final Expense expense;

  @override
  String toString() {
    return 'ExpensesTimeOffDetailsRouteArgs{key: $key, expense: $expense}';
  }
}

/// generated route for
/// [FinanceHomeScreen]
class FinanceHomeRoute extends PageRouteInfo<void> {
  const FinanceHomeRoute({List<PageRouteInfo>? children})
    : super(FinanceHomeRoute.name, initialChildren: children);

  static const String name = 'FinanceHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FinanceHomeScreen();
    },
  );
}

/// generated route for
/// [FinanceTabPage]
class FinanceTabRoute extends PageRouteInfo<void> {
  const FinanceTabRoute({List<PageRouteInfo>? children})
    : super(FinanceTabRoute.name, initialChildren: children);

  static const String name = 'FinanceTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FinanceTabPage();
    },
  );
}

/// generated route for
/// [HomeTabPage]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeTabPage();
    },
  );
}

/// generated route for
/// [InvoiceCompleteScreen]
class InvoiceCompleteRoute extends PageRouteInfo<InvoiceCompleteRouteArgs> {
  InvoiceCompleteRoute({
    Key? key,
    required InvoiceData invoiceData,
    List<PageRouteInfo>? children,
  }) : super(
         InvoiceCompleteRoute.name,
         args: InvoiceCompleteRouteArgs(key: key, invoiceData: invoiceData),
         initialChildren: children,
       );

  static const String name = 'InvoiceCompleteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvoiceCompleteRouteArgs>();
      return InvoiceCompleteScreen(
        key: args.key,
        invoiceData: args.invoiceData,
      );
    },
  );
}

class InvoiceCompleteRouteArgs {
  const InvoiceCompleteRouteArgs({this.key, required this.invoiceData});

  final Key? key;

  final InvoiceData invoiceData;

  @override
  String toString() {
    return 'InvoiceCompleteRouteArgs{key: $key, invoiceData: $invoiceData}';
  }
}

/// generated route for
/// [InvoiceDetailScreen]
class InvoiceDetailRoute extends PageRouteInfo<InvoiceDetailRouteArgs> {
  InvoiceDetailRoute({
    Key? key,
    required Invoice invoice,
    List<PageRouteInfo>? children,
  }) : super(
         InvoiceDetailRoute.name,
         args: InvoiceDetailRouteArgs(key: key, invoice: invoice),
         initialChildren: children,
       );

  static const String name = 'InvoiceDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvoiceDetailRouteArgs>();
      return InvoiceDetailScreen(key: args.key, invoice: args.invoice);
    },
  );
}

class InvoiceDetailRouteArgs {
  const InvoiceDetailRouteArgs({this.key, required this.invoice});

  final Key? key;

  final Invoice invoice;

  @override
  String toString() {
    return 'InvoiceDetailRouteArgs{key: $key, invoice: $invoice}';
  }
}

/// generated route for
/// [InvoicesScreen]
class InvoicesRoute extends PageRouteInfo<void> {
  const InvoicesRoute({List<PageRouteInfo>? children})
    : super(InvoicesRoute.name, initialChildren: children);

  static const String name = 'InvoicesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InvoicesScreen();
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginScreen();
    },
  );
}

/// generated route for
/// [MainShellScreen]
class MainShellRoute extends PageRouteInfo<void> {
  const MainShellRoute({List<PageRouteInfo>? children})
    : super(MainShellRoute.name, initialChildren: children);

  static const String name = 'MainShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainShellScreen();
    },
  );
}

/// generated route for
/// [MoreScreen]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute({List<PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoreScreen();
    },
  );
}

/// generated route for
/// [MoreTabPage]
class MoreTabRoute extends PageRouteInfo<void> {
  const MoreTabRoute({List<PageRouteInfo>? children})
    : super(MoreTabRoute.name, initialChildren: children);

  static const String name = 'MoreTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoreTabPage();
    },
  );
}

/// generated route for
/// [NewPasswordScreen]
class NewPasswordRoute extends PageRouteInfo<void> {
  const NewPasswordRoute({List<PageRouteInfo>? children})
    : super(NewPasswordRoute.name, initialChildren: children);

  static const String name = 'NewPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewPasswordScreen();
    },
  );
}

/// generated route for
/// [NewTimeOffRequestScreen]
class NewTimeOffRequestRoute extends PageRouteInfo<void> {
  const NewTimeOffRequestRoute({List<PageRouteInfo>? children})
    : super(NewTimeOffRequestRoute.name, initialChildren: children);

  static const String name = 'NewTimeOffRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewTimeOffRequestScreen();
    },
  );
}

/// generated route for
/// [OnboardingChecklistScreen]
class OnboardingChecklistRoute extends PageRouteInfo<void> {
  const OnboardingChecklistRoute({List<PageRouteInfo>? children})
    : super(OnboardingChecklistRoute.name, initialChildren: children);

  static const String name = 'OnboardingChecklistRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingChecklistScreen();
    },
  );
}

/// generated route for
/// [PasswordResetSuccessScreen]
class PasswordResetSuccessRoute extends PageRouteInfo<void> {
  const PasswordResetSuccessRoute({List<PageRouteInfo>? children})
    : super(PasswordResetSuccessRoute.name, initialChildren: children);

  static const String name = 'PasswordResetSuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PasswordResetSuccessScreen();
    },
  );
}

/// generated route for
/// [PayCycleContractsScreen]
class PayCycleContractsRoute extends PageRouteInfo<void> {
  const PayCycleContractsRoute({List<PageRouteInfo>? children})
    : super(PayCycleContractsRoute.name, initialChildren: children);

  static const String name = 'PayCycleContractsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PayCycleContractsScreen();
    },
  );
}

/// generated route for
/// [PayoutDetailScreen]
class PayoutDetailRoute extends PageRouteInfo<PayoutDetailRouteArgs> {
  PayoutDetailRoute({
    Key? key,
    required Payout payout,
    List<PageRouteInfo>? children,
  }) : super(
         PayoutDetailRoute.name,
         args: PayoutDetailRouteArgs(key: key, payout: payout),
         initialChildren: children,
       );

  static const String name = 'PayoutDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayoutDetailRouteArgs>();
      return PayoutDetailScreen(key: args.key, payout: args.payout);
    },
  );
}

class PayoutDetailRouteArgs {
  const PayoutDetailRouteArgs({this.key, required this.payout});

  final Key? key;

  final Payout payout;

  @override
  String toString() {
    return 'PayoutDetailRouteArgs{key: $key, payout: $payout}';
  }
}

/// generated route for
/// [PersonalDetailsScreen]
class PersonalDetailsRoute extends PageRouteInfo<void> {
  const PersonalDetailsRoute({List<PageRouteInfo>? children})
    : super(PersonalDetailsRoute.name, initialChildren: children);

  static const String name = 'PersonalDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PersonalDetailsScreen();
    },
  );
}

/// generated route for
/// [PinCodeScreen]
class PinCodeRoute extends PageRouteInfo<PinCodeRouteArgs> {
  PinCodeRoute({
    Key? key,
    required String userName,
    required BiometricType biometricType,
    List<PageRouteInfo>? children,
  }) : super(
         PinCodeRoute.name,
         args: PinCodeRouteArgs(
           key: key,
           userName: userName,
           biometricType: biometricType,
         ),
         initialChildren: children,
       );

  static const String name = 'PinCodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinCodeRouteArgs>();
      return PinCodeScreen(
        key: args.key,
        userName: args.userName,
        biometricType: args.biometricType,
      );
    },
  );
}

class PinCodeRouteArgs {
  const PinCodeRouteArgs({
    this.key,
    required this.userName,
    required this.biometricType,
  });

  final Key? key;

  final String userName;

  final BiometricType biometricType;

  @override
  String toString() {
    return 'PinCodeRouteArgs{key: $key, userName: $userName, biometricType: $biometricType}';
  }
}

/// generated route for
/// [PinCreatedScreen]
class PinCreatedRoute extends PageRouteInfo<void> {
  const PinCreatedRoute({List<PageRouteInfo>? children})
    : super(PinCreatedRoute.name, initialChildren: children);

  static const String name = 'PinCreatedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PinCreatedScreen();
    },
  );
}

/// generated route for
/// [ProcessingBvnRequestScreen]
class ProcessingBvnRequestRoute extends PageRouteInfo<void> {
  const ProcessingBvnRequestRoute({List<PageRouteInfo>? children})
    : super(ProcessingBvnRequestRoute.name, initialChildren: children);

  static const String name = 'ProcessingBvnRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProcessingBvnRequestScreen();
    },
  );
}

/// generated route for
/// [ProfileCreatedSucessScreen]
class ProfileCreatedSucessRoute extends PageRouteInfo<void> {
  const ProfileCreatedSucessRoute({List<PageRouteInfo>? children})
    : super(ProfileCreatedSucessRoute.name, initialChildren: children);

  static const String name = 'ProfileCreatedSucessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileCreatedSucessScreen();
    },
  );
}

/// generated route for
/// [ProvideBvnScreen]
class ProvideBvnRoute extends PageRouteInfo<void> {
  const ProvideBvnRoute({List<PageRouteInfo>? children})
    : super(ProvideBvnRoute.name, initialChildren: children);

  static const String name = 'ProvideBvnRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProvideBvnScreen();
    },
  );
}

/// generated route for
/// [QuickPayHomeScreen]
class QuickPayHomeRoute extends PageRouteInfo<void> {
  const QuickPayHomeRoute({List<PageRouteInfo>? children})
    : super(QuickPayHomeRoute.name, initialChildren: children);

  static const String name = 'QuickPayHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QuickPayHomeScreen();
    },
  );
}

/// generated route for
/// [ReceivePaymentDoneScreen]
class ReceivePaymentDoneRoute
    extends PageRouteInfo<ReceivePaymentDoneRouteArgs> {
  ReceivePaymentDoneRoute({
    Key? key,
    required ReceiveParams args,
    List<PageRouteInfo>? children,
  }) : super(
         ReceivePaymentDoneRoute.name,
         args: ReceivePaymentDoneRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'ReceivePaymentDoneRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReceivePaymentDoneRouteArgs>();
      return ReceivePaymentDoneScreen(key: args.key, args: args.args);
    },
  );
}

class ReceivePaymentDoneRouteArgs {
  const ReceivePaymentDoneRouteArgs({this.key, required this.args});

  final Key? key;

  final ReceiveParams args;

  @override
  String toString() {
    return 'ReceivePaymentDoneRouteArgs{key: $key, args: $args}';
  }
}

/// generated route for
/// [ReceivePaymentScreen]
class ReceivePaymentRoute extends PageRouteInfo<void> {
  const ReceivePaymentRoute({List<PageRouteInfo>? children})
    : super(ReceivePaymentRoute.name, initialChildren: children);

  static const String name = 'ReceivePaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReceivePaymentScreen();
    },
  );
}

/// generated route for
/// [ReceiveScreen]
class ReceiveRoute extends PageRouteInfo<void> {
  const ReceiveRoute({List<PageRouteInfo>? children})
    : super(ReceiveRoute.name, initialChildren: children);

  static const String name = 'ReceiveRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReceiveScreen();
    },
  );
}

/// generated route for
/// [RequestChangeScreen]
class RequestChangeRoute extends PageRouteInfo<void> {
  const RequestChangeRoute({List<PageRouteInfo>? children})
    : super(RequestChangeRoute.name, initialChildren: children);

  static const String name = 'RequestChangeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RequestChangeScreen();
    },
  );
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<void> {
  const ResetPasswordRoute({List<PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [ResubmitHoursScreen]
class ResubmitHoursRoute extends PageRouteInfo<ResubmitHoursRouteArgs> {
  ResubmitHoursRoute({
    Key? key,
    required SubmittedTimesheet timesheet,
    List<PageRouteInfo>? children,
  }) : super(
         ResubmitHoursRoute.name,
         args: ResubmitHoursRouteArgs(key: key, timesheet: timesheet),
         initialChildren: children,
       );

  static const String name = 'ResubmitHoursRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResubmitHoursRouteArgs>();
      return ResubmitHoursScreen(key: args.key, timesheet: args.timesheet);
    },
  );
}

class ResubmitHoursRouteArgs {
  const ResubmitHoursRouteArgs({this.key, required this.timesheet});

  final Key? key;

  final SubmittedTimesheet timesheet;

  @override
  String toString() {
    return 'ResubmitHoursRouteArgs{key: $key, timesheet: $timesheet}';
  }
}

/// generated route for
/// [SampleBottomSheetScreen]
class SampleBottomSheetRoute extends PageRouteInfo<void> {
  const SampleBottomSheetRoute({List<PageRouteInfo>? children})
    : super(SampleBottomSheetRoute.name, initialChildren: children);

  static const String name = 'SampleBottomSheetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SampleBottomSheetScreen();
    },
  );
}

/// generated route for
/// [SelectAssetScreen]
class SelectAssetRoute extends PageRouteInfo<SelectAssetRouteArgs> {
  SelectAssetRoute({
    Key? key,
    bool forReceive = false,
    List<PageRouteInfo>? children,
  }) : super(
         SelectAssetRoute.name,
         args: SelectAssetRouteArgs(key: key, forReceive: forReceive),
         initialChildren: children,
       );

  static const String name = 'SelectAssetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectAssetRouteArgs>(
        orElse: () => const SelectAssetRouteArgs(),
      );
      return SelectAssetScreen(key: args.key, forReceive: args.forReceive);
    },
  );
}

class SelectAssetRouteArgs {
  const SelectAssetRouteArgs({this.key, this.forReceive = false});

  final Key? key;

  final bool forReceive;

  @override
  String toString() {
    return 'SelectAssetRouteArgs{key: $key, forReceive: $forReceive}';
  }
}

/// generated route for
/// [SelectIdCountryScreen]
class SelectIdCountryRoute extends PageRouteInfo<void> {
  const SelectIdCountryRoute({List<PageRouteInfo>? children})
    : super(SelectIdCountryRoute.name, initialChildren: children);

  static const String name = 'SelectIdCountryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SelectIdCountryScreen();
    },
  );
}

/// generated route for
/// [SelectNetworkScreen]
class SelectNetworkRoute extends PageRouteInfo<SelectNetworkRouteArgs> {
  SelectNetworkRoute({
    Key? key,
    bool forDeposit = false,
    NetworkAsset? selectedAsset,
    List<PageRouteInfo>? children,
  }) : super(
         SelectNetworkRoute.name,
         args: SelectNetworkRouteArgs(
           key: key,
           forDeposit: forDeposit,
           selectedAsset: selectedAsset,
         ),
         initialChildren: children,
       );

  static const String name = 'SelectNetworkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectNetworkRouteArgs>(
        orElse: () => const SelectNetworkRouteArgs(),
      );
      return SelectNetworkScreen(
        key: args.key,
        forDeposit: args.forDeposit,
        selectedAsset: args.selectedAsset,
      );
    },
  );
}

class SelectNetworkRouteArgs {
  const SelectNetworkRouteArgs({
    this.key,
    this.forDeposit = false,
    this.selectedAsset,
  });

  final Key? key;

  final bool forDeposit;

  final NetworkAsset? selectedAsset;

  @override
  String toString() {
    return 'SelectNetworkRouteArgs{key: $key, forDeposit: $forDeposit, selectedAsset: $selectedAsset}';
  }
}

/// generated route for
/// [SentScreen]
class SentRoute extends PageRouteInfo<void> {
  const SentRoute({List<PageRouteInfo>? children})
    : super(SentRoute.name, initialChildren: children);

  static const String name = 'SentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SentScreen();
    },
  );
}

/// generated route for
/// [SubmitHoursScreen]
class SubmitHoursRoute extends PageRouteInfo<SubmitHoursRouteArgs> {
  SubmitHoursRoute({
    Key? key,
    required TimeTrackingContract contract,
    List<PageRouteInfo>? children,
  }) : super(
         SubmitHoursRoute.name,
         args: SubmitHoursRouteArgs(key: key, contract: contract),
         initialChildren: children,
       );

  static const String name = 'SubmitHoursRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubmitHoursRouteArgs>();
      return SubmitHoursScreen(key: args.key, contract: args.contract);
    },
  );
}

class SubmitHoursRouteArgs {
  const SubmitHoursRouteArgs({this.key, required this.contract});

  final Key? key;

  final TimeTrackingContract contract;

  @override
  String toString() {
    return 'SubmitHoursRouteArgs{key: $key, contract: $contract}';
  }
}

/// generated route for
/// [SubmittedHoursDetailScreen]
class SubmittedHoursDetailRoute
    extends PageRouteInfo<SubmittedHoursDetailRouteArgs> {
  SubmittedHoursDetailRoute({
    Key? key,
    required SubmittedTimesheet timesheet,
    List<PageRouteInfo>? children,
  }) : super(
         SubmittedHoursDetailRoute.name,
         args: SubmittedHoursDetailRouteArgs(key: key, timesheet: timesheet),
         initialChildren: children,
       );

  static const String name = 'SubmittedHoursDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SubmittedHoursDetailRouteArgs>();
      return SubmittedHoursDetailScreen(
        key: args.key,
        timesheet: args.timesheet,
      );
    },
  );
}

class SubmittedHoursDetailRouteArgs {
  const SubmittedHoursDetailRouteArgs({this.key, required this.timesheet});

  final Key? key;

  final SubmittedTimesheet timesheet;

  @override
  String toString() {
    return 'SubmittedHoursDetailRouteArgs{key: $key, timesheet: $timesheet}';
  }
}

/// generated route for
/// [TaxInformationScreen]
class TaxInformationRoute extends PageRouteInfo<void> {
  const TaxInformationRoute({List<PageRouteInfo>? children})
    : super(TaxInformationRoute.name, initialChildren: children);

  static const String name = 'TaxInformationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TaxInformationScreen();
    },
  );
}

/// generated route for
/// [TimeOffContractsScreen]
class TimeOffContractsRoute extends PageRouteInfo<TimeOffContractsRouteArgs> {
  TimeOffContractsRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        TimeOffContractsRoute.name,
        args: TimeOffContractsRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'TimeOffContractsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimeOffContractsRouteArgs>(
        orElse: () => const TimeOffContractsRouteArgs(),
      );
      return TimeOffContractsScreen(key: args.key);
    },
  );
}

class TimeOffContractsRouteArgs {
  const TimeOffContractsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'TimeOffContractsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [TimeOffDetailScreen]
class TimeOffDetailRoute extends PageRouteInfo<TimeOffDetailRouteArgs> {
  TimeOffDetailRoute({
    Key? key,
    required TimeOffDetail timeOffDetail,
    List<PageRouteInfo>? children,
  }) : super(
         TimeOffDetailRoute.name,
         args: TimeOffDetailRouteArgs(key: key, timeOffDetail: timeOffDetail),
         initialChildren: children,
       );

  static const String name = 'TimeOffDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimeOffDetailRouteArgs>();
      return TimeOffDetailScreen(
        key: args.key,
        timeOffDetail: args.timeOffDetail,
      );
    },
  );
}

class TimeOffDetailRouteArgs {
  const TimeOffDetailRouteArgs({this.key, required this.timeOffDetail});

  final Key? key;

  final TimeOffDetail timeOffDetail;

  @override
  String toString() {
    return 'TimeOffDetailRouteArgs{key: $key, timeOffDetail: $timeOffDetail}';
  }
}

/// generated route for
/// [TimeOffDetailsScreen]
class TimeOffDetailsRoute extends PageRouteInfo<TimeOffDetailsRouteArgs> {
  TimeOffDetailsRoute({
    Key? key,
    required String contractTitle,
    List<PageRouteInfo>? children,
  }) : super(
         TimeOffDetailsRoute.name,
         args: TimeOffDetailsRouteArgs(key: key, contractTitle: contractTitle),
         initialChildren: children,
       );

  static const String name = 'TimeOffDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimeOffDetailsRouteArgs>();
      return TimeOffDetailsScreen(
        key: args.key,
        contractTitle: args.contractTitle,
      );
    },
  );
}

class TimeOffDetailsRouteArgs {
  const TimeOffDetailsRouteArgs({this.key, required this.contractTitle});

  final Key? key;

  final String contractTitle;

  @override
  String toString() {
    return 'TimeOffDetailsRouteArgs{key: $key, contractTitle: $contractTitle}';
  }
}

/// generated route for
/// [TimeOffHistoryScreen]
class TimeOffHistoryRoute extends PageRouteInfo<void> {
  const TimeOffHistoryRoute({List<PageRouteInfo>? children})
    : super(TimeOffHistoryRoute.name, initialChildren: children);

  static const String name = 'TimeOffHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TimeOffHistoryScreen();
    },
  );
}

/// generated route for
/// [TimeOffScreen]
class TimeOffRoute extends PageRouteInfo<TimeOffRouteArgs> {
  TimeOffRoute({
    Key? key,
    required String contractTitle,
    List<PageRouteInfo>? children,
  }) : super(
         TimeOffRoute.name,
         args: TimeOffRouteArgs(key: key, contractTitle: contractTitle),
         initialChildren: children,
       );

  static const String name = 'TimeOffRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimeOffRouteArgs>();
      return TimeOffScreen(key: args.key, contractTitle: args.contractTitle);
    },
  );
}

class TimeOffRouteArgs {
  const TimeOffRouteArgs({this.key, required this.contractTitle});

  final Key? key;

  final String contractTitle;

  @override
  String toString() {
    return 'TimeOffRouteArgs{key: $key, contractTitle: $contractTitle}';
  }
}

/// generated route for
/// [TimeTrackingContractsScreen]
class TimeTrackingContractsRoute extends PageRouteInfo<void> {
  const TimeTrackingContractsRoute({List<PageRouteInfo>? children})
    : super(TimeTrackingContractsRoute.name, initialChildren: children);

  static const String name = 'TimeTrackingContractsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TimeTrackingContractsScreen();
    },
  );
}

/// generated route for
/// [TimeTrackingScreen]
class TimeTrackingRoute extends PageRouteInfo<TimeTrackingRouteArgs> {
  TimeTrackingRoute({
    Key? key,
    required TimeTrackingContract contract,
    List<PageRouteInfo>? children,
  }) : super(
         TimeTrackingRoute.name,
         args: TimeTrackingRouteArgs(key: key, contract: contract),
         initialChildren: children,
       );

  static const String name = 'TimeTrackingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TimeTrackingRouteArgs>();
      return TimeTrackingScreen(key: args.key, contract: args.contract);
    },
  );
}

class TimeTrackingRouteArgs {
  const TimeTrackingRouteArgs({this.key, required this.contract});

  final Key? key;

  final TimeTrackingContract contract;

  @override
  String toString() {
    return 'TimeTrackingRouteArgs{key: $key, contract: $contract}';
  }
}

/// generated route for
/// [TransactionScreen]
class TransactionRoute extends PageRouteInfo<TransactionRouteArgs> {
  TransactionRoute({
    Key? key,
    required QuickPayment args,
    List<PageRouteInfo>? children,
  }) : super(
         TransactionRoute.name,
         args: TransactionRouteArgs(key: key, args: args),
         initialChildren: children,
       );

  static const String name = 'TransactionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransactionRouteArgs>();
      return TransactionScreen(key: args.key, args: args.args);
    },
  );
}

class TransactionRouteArgs {
  const TransactionRouteArgs({this.key, required this.args});

  final Key? key;

  final QuickPayment args;

  @override
  String toString() {
    return 'TransactionRouteArgs{key: $key, args: $args}';
  }
}

/// generated route for
/// [TwoFaAuthScreen]
class TwoFaAuthRoute extends PageRouteInfo<void> {
  const TwoFaAuthRoute({List<PageRouteInfo>? children})
    : super(TwoFaAuthRoute.name, initialChildren: children);

  static const String name = 'TwoFaAuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TwoFaAuthScreen();
    },
  );
}

/// generated route for
/// [UnpaidTimeOffBalanceScreen]
class UnpaidTimeOffBalanceRoute
    extends PageRouteInfo<UnpaidTimeOffBalanceRouteArgs> {
  UnpaidTimeOffBalanceRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        UnpaidTimeOffBalanceRoute.name,
        args: UnpaidTimeOffBalanceRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'UnpaidTimeOffBalanceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UnpaidTimeOffBalanceRouteArgs>(
        orElse: () => const UnpaidTimeOffBalanceRouteArgs(),
      );
      return UnpaidTimeOffBalanceScreen(key: args.key);
    },
  );
}

class UnpaidTimeOffBalanceRouteArgs {
  const UnpaidTimeOffBalanceRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'UnpaidTimeOffBalanceRouteArgs{key: $key}';
  }
}

/// generated route for
/// [UpcomingPaymentsScreen]
class UpcomingPaymentsRoute extends PageRouteInfo<void> {
  const UpcomingPaymentsRoute({List<PageRouteInfo>? children})
    : super(UpcomingPaymentsRoute.name, initialChildren: children);

  static const String name = 'UpcomingPaymentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UpcomingPaymentsScreen();
    },
  );
}

/// generated route for
/// [VerificationInProgressScreen]
class VerificationInProgressRoute extends PageRouteInfo<void> {
  const VerificationInProgressRoute({List<PageRouteInfo>? children})
    : super(VerificationInProgressRoute.name, initialChildren: children);

  static const String name = 'VerificationInProgressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerificationInProgressScreen();
    },
  );
}

/// generated route for
/// [VerifyAccountScreen]
class VerifyAccountRoute extends PageRouteInfo<void> {
  const VerifyAccountRoute({List<PageRouteInfo>? children})
    : super(VerifyAccountRoute.name, initialChildren: children);

  static const String name = 'VerifyAccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerifyAccountScreen();
    },
  );
}

/// generated route for
/// [VerifyIdentityScreen]
class VerifyIdentityRoute extends PageRouteInfo<void> {
  const VerifyIdentityRoute({List<PageRouteInfo>? children})
    : super(VerifyIdentityRoute.name, initialChildren: children);

  static const String name = 'VerifyIdentityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerifyIdentityScreen();
    },
  );
}

/// generated route for
/// [VerifyOtpScreen]
class VerifyOtpRoute extends PageRouteInfo<void> {
  const VerifyOtpRoute({List<PageRouteInfo>? children})
    : super(VerifyOtpRoute.name, initialChildren: children);

  static const String name = 'VerifyOtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerifyOtpScreen();
    },
  );
}

/// generated route for
/// [Web3authTestScreen]
class Web3authTestRoute extends PageRouteInfo<void> {
  const Web3authTestRoute({List<PageRouteInfo>? children})
    : super(Web3authTestRoute.name, initialChildren: children);

  static const String name = 'Web3authTestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Web3authTestScreen();
    },
  );
}

/// generated route for
/// [WithdrawPreviewScreen]
class WithdrawPreviewRoute extends PageRouteInfo<WithdrawPreviewRouteArgs> {
  WithdrawPreviewRoute({
    Key? key,
    WithdrawDetailsModel? withdrawDetails,
    List<PageRouteInfo>? children,
  }) : super(
         WithdrawPreviewRoute.name,
         args: WithdrawPreviewRouteArgs(
           key: key,
           withdrawDetails: withdrawDetails,
         ),
         initialChildren: children,
       );

  static const String name = 'WithdrawPreviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WithdrawPreviewRouteArgs>(
        orElse: () => const WithdrawPreviewRouteArgs(),
      );
      return WithdrawPreviewScreen(
        key: args.key,
        withdrawDetails: args.withdrawDetails,
      );
    },
  );
}

class WithdrawPreviewRouteArgs {
  const WithdrawPreviewRouteArgs({this.key, this.withdrawDetails});

  final Key? key;

  final WithdrawDetailsModel? withdrawDetails;

  @override
  String toString() {
    return 'WithdrawPreviewRouteArgs{key: $key, withdrawDetails: $withdrawDetails}';
  }
}

/// generated route for
/// [WithdrawScreen]
class WithdrawRoute extends PageRouteInfo<void> {
  const WithdrawRoute({List<PageRouteInfo>? children})
    : super(WithdrawRoute.name, initialChildren: children);

  static const String name = 'WithdrawRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WithdrawScreen();
    },
  );
}

/// generated route for
/// [WorkspaceTabPage]
class WorkspaceTabRoute extends PageRouteInfo<void> {
  const WorkspaceTabRoute({List<PageRouteInfo>? children})
    : super(WorkspaceTabRoute.name, initialChildren: children);

  static const String name = 'WorkspaceTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WorkspaceTabPage();
    },
  );
}

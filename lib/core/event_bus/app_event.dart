abstract class AppEvent {
  const AppEvent();

  String get name;
  DateTime get timestamp => DateTime.now();
}

// Auth

class UserLoggedIn extends AppEvent {
  const UserLoggedIn({required this.userId});

  final String userId;

  @override
  String get name => 'UserLoggedIn';
}

class UserLoggedOut extends AppEvent {
  const UserLoggedOut();

  @override
  String get name => 'UserLoggedOut';
}

// Wallet

class WalletConnected extends AppEvent {
  const WalletConnected({required this.address});

  final String address;

  @override
  String get name => 'WalletConnected';
}

class WalletDisconnected extends AppEvent {
  const WalletDisconnected();

  @override
  String get name => 'WalletDisconnected';
}

// Finance

class PaymentCompleted extends AppEvent {
  const PaymentCompleted({required this.paymentId, required this.amount});

  final String paymentId;
  final double amount;

  @override
  String get name => 'PaymentCompleted';
}

class InvoiceStatusChanged extends AppEvent {
  const InvoiceStatusChanged({
    required this.invoiceId,
    required this.status,
  });

  final String invoiceId;
  final String status;

  @override
  String get name => 'InvoiceStatusChanged';
}

// Connectivity

class ConnectivityChanged extends AppEvent {
  const ConnectivityChanged({required this.isOnline});

  final bool isOnline;

  @override
  String get name => 'ConnectivityChanged';
}

class QueuedOperationSucceeded extends AppEvent {
  const QueuedOperationSucceeded({required this.operationId});

  final String operationId;

  @override
  String get name => 'QueuedOperationSucceeded';
}

class QueuedOperationFailed extends AppEvent {
  const QueuedOperationFailed({required this.operationId});

  final String operationId;

  @override
  String get name => 'QueuedOperationFailed';
}

// Workspace

class WorkspaceSwitched extends AppEvent {
  const WorkspaceSwitched({required this.workspaceId});

  final String workspaceId;

  @override
  String get name => 'WorkspaceSwitched';
}

import 'package:equatable/equatable.dart';
import 'package:web3auth_flutter/output.dart';

import '../../../core/enums/blockchain_type.dart';

enum AuthStatus {
  initial,
  initializing,
  initializationFailed,
  initialized,
  authenticating,
  authenticated,
  authenticationFailed,
  unauthenticated,
  signingMessage,
  messageSigned,
  signingFailed,
  providerId,
  loadingWallet, // Added for wallet loading state
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;
  final TorusUserInfo? userInfo;
  final BlockchainType selectedBlockchain;
  final String? walletAddress;
  final double? walletBalance;
  final String? providerId;
  final String? signature;

  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.userInfo,
    this.selectedBlockchain = BlockchainType.ethereum,
    this.walletAddress,
    this.walletBalance,
    this.signature,
    this.providerId,
  });

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isInitialized => status == AuthStatus.initialized || isAuthenticated;
  bool get isLoading =>
      status == AuthStatus.initializing ||
      status == AuthStatus.authenticating ||
      status == AuthStatus.signingMessage ||
      status == AuthStatus.loadingWallet;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    TorusUserInfo? userInfo,
    BlockchainType? selectedBlockchain,
    String? walletAddress,
    double? walletBalance,
    String? providerId,
    String? signature,
    bool clearError = false,
    bool clearSignature = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      userInfo: userInfo ?? this.userInfo,
      providerId: providerId ?? this.providerId,
      selectedBlockchain: selectedBlockchain ?? this.selectedBlockchain,
      walletAddress: walletAddress ?? this.walletAddress,
      walletBalance: walletBalance ?? this.walletBalance,
      signature: clearSignature ? null : signature ?? this.signature,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        userInfo,
        selectedBlockchain,
        walletAddress,
        walletBalance,
        signature
      ];
}

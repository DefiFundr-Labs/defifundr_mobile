import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:defifundr_mobile/modules/web3auth/domain/exceptions/web3auth_exception.dart';
import 'package:defifundr_mobile/modules/web3auth/domain/interfaces/web3_wallet.dart';
import 'package:defifundr_mobile/modules/web3auth/data/service/web3auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3auth_flutter/enums.dart';

import '../../../../core/config/web3auth_config.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Web3AuthService _web3AuthService;

  AuthBloc({
    required Web3AuthService web3AuthService,
  })  : _web3AuthService = web3AuthService,
        super(const AuthState()) {
    on<InitializeAuth>(_onInitializeAuth);
    on<LoginWithEmail>(_onLoginWithEmail);
    on<LoginWithGoogle>(_onLoginWithGoogle);
    on<LoginWithApple>(_onLoginWithApple);
    on<LogoutRequested>(_onLogoutRequested);
    on<ChangeBlockchain>(_onChangeBlockchain);
    on<SignMessage>(_onSignMessage);
    on<UpdateWalletInfo>(_onUpdateWalletInfo);
  }

  Future<void> _onInitializeAuth(
      InitializeAuth event, Emitter<AuthState> emit) async {
    if (state.status == AuthStatus.initializing) return;

    emit(state.copyWith(
      status: AuthStatus.initializing,
      clearError: true,
    ));

    try {
      // Determine redirect URL based on platform
      Uri redirectUrl;
      if (Platform.isAndroid) {
        // redirectUrl = Uri.parse('w3a://com.defifundr.app/auth');
        redirectUrl = Uri.parse('defifundr://auth');
        print("Using Android redirect URL: ${redirectUrl.toString()}");
      } else if (Platform.isIOS) {
        redirectUrl = Uri.parse('com.defifundr.app://auth');
        print("Using iOS redirect URL: ${redirectUrl.toString()}");
      } else {
        throw Exception('Unsupported platform');
      }

      final String web3AuthClientID = dotenv.env['WEB3AUTH_CLIENT_ID']!;

      // Configure Web3Auth
      final config = Web3AuthConfig(
        clientId: web3AuthClientID,
        redirectUrl: redirectUrl,
        network: Network.sapphire_devnet,
        sessionTime: 259200,
        enableLogging: true,
      );

      // Initialize the service
      await _web3AuthService.initialize(config);

      // Check session with our safe method
      final hasSession = await _web3AuthService.hasActiveSession();

      if (hasSession && _web3AuthService.isLoggedIn) {
        try {
          await _updateWalletInfo(emit);
          emit(state.copyWith(
            status: AuthStatus.authenticated,
            userInfo: _web3AuthService.userInfo,
          ));
        } catch (e) {
          // _log('Error updating wallet info: $e', isError: true);
          // Fall back to initialized state if wallet info update fails
          emit(state.copyWith(status: AuthStatus.initialized));
        }
      } else {
        emit(state.copyWith(status: AuthStatus.initialized));
      }
    } catch (e, stackTrace) {
      print("Failed to initialize Web3Auth: $e");
      print("Stack trace: $stackTrace");

      // Extract meaningful error message
      String errorMessage = "Failed to initialize Web3Auth";
      if (e is Web3AuthException) {
        errorMessage = e.message;
      } else if (e.toString().contains('No user found')) {
        errorMessage = "Please login to continue";
      }

      emit(state.copyWith(
        status: AuthStatus.initializationFailed,
        errorMessage: errorMessage,
      ));
    }
  }

  Future<void> _onLoginWithEmail(
      LoginWithEmail event, Emitter<AuthState> emit) async {
    await _login(
      emit,
      () => _web3AuthService.loginWithEmail(event.email),
    );
  }

  Future<void> _onLoginWithGoogle(
      LoginWithGoogle event, Emitter<AuthState> emit) async {
    await _login(
      emit,
      () => _web3AuthService.login(provider: Provider.google),
    );
  }

  Future<void> _onLoginWithApple(
      LoginWithApple event, Emitter<AuthState> emit) async {
    await _login(
      emit,
      () => _web3AuthService.login(provider: Provider.apple),
    );
  }

  Future<void> _login(
      Emitter<AuthState> emit, Future<void> Function() loginFunction) async {
    if (!state.isInitialized) {
      emit(state.copyWith(
        status: AuthStatus.authenticationFailed,
        errorMessage:
            "Web3Auth is not initialized yet. Please initialize first.",
      ));
      return;
    }

    emit(state.copyWith(
      status: AuthStatus.authenticating,
      clearError: true,
    ));

    try {
      await loginFunction();
      await _updateWalletInfo(emit);

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        userInfo: _web3AuthService.userInfo,
      ));
    } catch (e) {
      print("Login failed: $e");

      // Handle specific cases
      if (e.toString().contains('No user found')) {
        // Clear any stale session
        try {
          await _web3AuthService.logout();
        } catch (_) {}

        emit(state.copyWith(
          status: AuthStatus.authenticationFailed,
          errorMessage: "Session expired. Please login again.",
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.authenticationFailed,
          errorMessage: "Login failed: $e",
        ));
      }
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await _web3AuthService.logout();

      emit(const AuthState(status: AuthStatus.initialized));
    } catch (e) {
      print("Logout failed: $e");
      emit(state.copyWith(
        errorMessage: "Logout failed: $e",
      ));
    }
  }

  Future<void> _onChangeBlockchain(
      ChangeBlockchain event, Emitter<AuthState> emit) async {
    if (!state.isAuthenticated) return;

    // First update the selected blockchain type
    emit(state.copyWith(
      selectedBlockchain: event.blockchainType,
      status: AuthStatus.loadingWallet,
      walletAddress: null,
      walletBalance: null,
      clearError: true,
    ));

    // Then fetch wallet info for the new blockchain
    await _updateWalletInfo(emit);

    // Return to authenticated state
    emit(state.copyWith(
      status: AuthStatus.authenticated,
    ));
  }

  Future<void> _onSignMessage(
      SignMessage event, Emitter<AuthState> emit) async {
    if (!state.isAuthenticated) return;

    emit(state.copyWith(
      status: AuthStatus.signingMessage,
      clearError: true,
      clearSignature: true,
    ));

    try {
      final wallet =
          _web3AuthService.getWallet<Web3Wallet>(state.selectedBlockchain);
      final message = Uint8List.fromList(utf8.encode(event.message));
      final signature = await wallet.signMessage(message);

      emit(state.copyWith(
        status: AuthStatus.messageSigned,
        signature: signature,
      ));

      // Return to authenticated state after a short delay
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
        status: AuthStatus.authenticated,
      ));
    } catch (e) {
      print("Signing error: $e");
      emit(state.copyWith(
        status: AuthStatus.signingFailed,
        errorMessage: "Failed to sign message: $e",
      ));
    }
  }

  Future<void> _onUpdateWalletInfo(
      UpdateWalletInfo event, Emitter<AuthState> emit) async {
    await _updateWalletInfo(emit);
  }

  Future<void> _updateWalletInfo(Emitter<AuthState> emit) async {
    if (!_web3AuthService.isLoggedIn) return;

    try {
      final wallet =
          _web3AuthService.getWallet<Web3Wallet>(state.selectedBlockchain);
      final address = await wallet.getAddress();
      final balance = await wallet.getBalance();

      emit(state.copyWith(
        walletAddress: address,
        walletBalance: balance,
      ));
    } catch (e) {
      print("Failed to update wallet info: $e");
      emit(state.copyWith(
        errorMessage: "Failed to update wallet info: $e",
      ));
    }
  }
}

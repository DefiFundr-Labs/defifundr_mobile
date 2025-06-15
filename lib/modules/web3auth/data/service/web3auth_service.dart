import 'dart:async';
import 'dart:developer';

import 'package:defifundr_mobile/core/enums/blockchain_type.dart';
import 'package:defifundr_mobile/modules/web3auth/domain/exceptions/web3auth_exception.dart';
import 'package:defifundr_mobile/modules/web3auth/data/wallets/etherium_wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

import '../../../../core/config/web3auth_config.dart';
import '../../domain/interfaces/web3_wallet.dart';
import '../wallets/solana_wallet.dart';
import '../wallets/starknet_wallet.dart';

/// Main Web3Auth service class for handling authentication and blockchain interactions
class Web3AuthService {
  static final Web3AuthService _instance = Web3AuthService._internal();

  /// Factory constructor to return the same instance every time
  factory Web3AuthService() {
    return _instance;
  }

  Web3AuthService._internal();

  late Web3AuthConfig _config;
  bool _isInitialized = false;
  bool _isLoggedIn = false;
  String? _privateKey;
  TorusUserInfo? _userInfo;

  // Wallet instances
  final Map<BlockchainType, Web3Wallet> _wallets = {};

  // Getters
  bool get isInitialized => _isInitialized;
  bool get isLoggedIn => _isLoggedIn;
  TorusUserInfo? get userInfo => _userInfo;

  /// Initialize the Web3Auth service with the provided configuration
  /// Initialize the Web3Auth service with the provided configuration
  Future<void> initialize(Web3AuthConfig config) async {
    if (_isInitialized) {
      _log('Web3Auth already initialized');
      return;
    }

    _config = config;

    try {
      await Web3AuthFlutter.init(Web3AuthOptions(
        clientId: _config.clientId,
        network: _config.network,
        redirectUrl: _config.redirectUrl,
        buildEnv: _config.buildEnv,
        sessionTime: _config.sessionTime,
      ));

      // Don't call initialize() immediately after init()
      // This is where the "No user found" error is likely thrown
      // We'll handle session checking separately
      _isInitialized = true;
      _log('Web3Auth initialized successfully');

      // Try to check for existing session safely
      try {
        final privateKey = await Web3AuthFlutter.getPrivKey();
        if (privateKey.isNotEmpty) {
          _privateKey = privateKey;
          _isLoggedIn = true;
          _userInfo = await Web3AuthFlutter.getUserInfo();

          // Initialize wallets
          await _initializeWallets();
          _log('User is already logged in');
        }
      } catch (sessionError) {
        // If getting session fails, continue with unlogged state
        _log('No active session found: $sessionError');
        _isLoggedIn = false;
        _privateKey = null;
        _userInfo = null;
      }
    } catch (e) {
      _log('Failed to initialize Web3Auth: $e', isError: true);
      _isInitialized = false;
      throw Web3AuthException('Failed to initialize Web3Auth: $e');
    }
  }

  /// Safely check if there's an active session
  Future<bool> hasActiveSession() async {
    try {
      final privateKey = await Web3AuthFlutter.getPrivKey();
      return privateKey.isNotEmpty;
    } catch (e) {
      _log('Session check failed: $e');
      return false;
    }
  }

  /// Safely get private key without throwing exceptions
  Future<String?> getSafePrivateKey() async {
    try {
      final privateKey = await Web3AuthFlutter.getPrivKey();
      return privateKey.isNotEmpty ? privateKey : null;
    } catch (e) {
      _log('Failed to get private key: $e');
      return null;
    }
  }

  /// Login with email passwordless authentication
  Future<void> loginWithEmail(String email) async {
    return login(
      provider: Provider.email_passwordless,
      extraLoginOptions: ExtraLoginOptions(login_hint: email),
    );
  }

  /// Login with specified provider
  Future<void> login({
    required Provider provider,
    ExtraLoginOptions? extraLoginOptions,
    Map<String, dynamic>? loginParams,
  }) async {
    _assertInitialized();

    if (_isLoggedIn) {
      _log('User is already logged in');
      return;
    }

    try {
      final params = LoginParams(
        loginProvider: provider,
        extraLoginOptions: extraLoginOptions,
        mfaLevel: MFALevel.NONE,
        dappShare: '',
      );

      _log('Attempting login with provider: $provider');
      final Web3AuthResponse response = await Web3AuthFlutter.login(params);

      _privateKey = response.privKey;
      _userInfo = response.userInfo;
      _isLoggedIn = true;
      print('response: $response');

      // Save private key to persistent storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('privateKey', _privateKey!);

      // Initialize wallets
      await _initializeWallets();

      _log('Login successful with provider: $provider');
    } on UserCancelledException {
      _log('Login cancelled by user', isError: true);
      throw Web3AuthException('Login cancelled by user', 'user_cancelled');
    } catch (e) {
      _log('Login failed with provider $provider: $e', isError: true);
      throw Web3AuthException('Login failed: $e');
    }
  }

  /// Logout from the current session
  Future<void> logout() async {
    _assertInitialized();

    if (!_isLoggedIn) {
      _log('User is not logged in');
      return;
    }

    try {
      await Web3AuthFlutter.logout();

      _privateKey = null;
      _userInfo = null;
      _isLoggedIn = false;
      _wallets.clear();

      // Remove private key from persistent storage
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('privateKey');

      _log('Logout successful');
    } catch (e) {
      _log('Logout failed: $e', isError: true);
      throw Web3AuthException('Logout failed: $e');
    }
  }

  /// Get wallet for the specified blockchain type
  T getWallet<T extends Web3Wallet>(BlockchainType type) {
    _assertLoggedIn();

    if (!_wallets.containsKey(type)) {
      throw Web3AuthException('Wallet for $type is not initialized');
    }

    final wallet = _wallets[type];
    if (wallet is! T) {
      throw Web3AuthException(
        'Wallet type mismatch. Expected $T, got ${wallet.runtimeType}',
      );
    }

    return wallet;
  }

  /// Initialize wallets for each supported blockchain
  Future<void> _initializeWallets() async {
    if (_privateKey == null || _privateKey!.isEmpty) {
      _log('Private key is not available', isError: true);
      return;
    }

    try {
      // Initialize Ethereum wallet
      _wallets[BlockchainType.ethereum] = EthereumWallet(
        privateKey: _privateKey!,
        rpcUrl: _config.rpcUrls[BlockchainType.ethereum]!,
      );

      _wallets[BlockchainType.solana] = SolanaWallet(
        privateKey: _privateKey!,
        rpcUrl: _config.rpcUrls[BlockchainType.solana]!,
      );

      // Initialize StarkNet wallet
      _wallets[BlockchainType.starknet] = StarkNetWallet(
        privateKey: _privateKey!,
        rpcUrl: _config.rpcUrls[BlockchainType.starknet]!,
      );

      _log('Wallets initialized successfully');
    } catch (e) {
      _log('Failed to initialize wallets: $e', isError: true);
      throw Web3AuthException('Failed to initialize wallets: $e');
    }
  }

  /// Assert that Web3Auth is initialized
  void _assertInitialized() {
    if (!_isInitialized) {
      throw Web3AuthException('Web3Auth is not initialized');
    }
  }

  /// Assert that user is logged in
  void _assertLoggedIn() {
    if (!_isLoggedIn) {
      throw Web3AuthException('User is not logged in');
    }
  }

  /// Log a message if logging is enabled
  void _log(String message, {bool isError = false}) {
    if (_config.enableLogging) {
      if (isError) {
        log('⛔ Web3Auth: $message');
      } else {
        log('🔐 Web3Auth: $message');
      }
    }
  }
}

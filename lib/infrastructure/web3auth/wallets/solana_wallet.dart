import 'dart:math' as Math;
import 'dart:typed_data';

import 'package:solana/solana.dart';

import '../exceptions/web3auth_exception.dart';
import '../interfaces/web3_wallet.dart';

/// Implementation of Solana wallet
class SolanaWallet extends Web3Wallet {
  final String privateKey;
  final String rpcUrl;
  late final SolanaClient _client;
  late final Ed25519HDKeyPair _keypair;

  // Solana constants
  static const int tokenDecimals = 9;

  SolanaWallet({
    required this.privateKey,
    required this.rpcUrl,
  }) {
    // Initialize Solana client
    _client = SolanaClient(
      rpcUrl: Uri.parse(rpcUrl),
      websocketUrl: Uri.parse(rpcUrl.replaceFirst('https', 'wss')),
    );

    // Initialize keypair from private key
    _initializeKeypair();
    print("Solana wallet initialized");
  }

  /// Initialize keypair from private key
  Future<void> _initializeKeypair() async {
    try {
      // For Ed25519, we only need the first 32 bytes of the private key
      final privateKeyBytes = _hexToBytes(privateKey);

      _keypair = await Ed25519HDKeyPair.fromPrivateKeyBytes(
        privateKey: privateKeyBytes.take(32).toList(),
      );

      print("Solana keypair initialized with address: ${_keypair.address}");
    } catch (e) {
      print("Error initializing Solana keypair: $e");
      throw Web3AuthException('Failed to initialize Solana keypair: $e');
    }
  }

  @override
  Future<String> getAddress() async {
    return _keypair.address;
  }

  @override
  Future<double> getBalance() async {
    try {
      final balanceResponse = await _client.rpcClient.getBalance(
        _keypair.address,
        commitment: Commitment.finalized,
      );

      // Convert lamports to SOL (1 SOL = 10^9 lamports)
      final balance = balanceResponse.value / Math.pow(10, tokenDecimals);

      print("Solana balance: $balance SOL");
      return balance;
    } catch (e) {
      print("Error getting Solana balance: $e");
      throw Web3AuthException('Failed to get Solana balance: $e');
    }
  }

  @override
  Future<String> sendTransaction({
    required String to,
    required double amount,
  }) async {
    try {
      // Convert SOL to lamports
      final lamports = (amount * Math.pow(10, tokenDecimals)).toInt();

      print("Sending $amount SOL ($lamports lamports) to $to");

      // Create a Solana transaction
      final transactionHash = await _client.transferLamports(
        source: _keypair,
        destination: Ed25519HDPublicKey.fromBase58(to),
        lamports: lamports,
      );

      print("Solana transaction sent: $transactionHash");
      return transactionHash;
    } catch (e) {
      print("Error sending Solana transaction: $e");
      throw Web3AuthException('Failed to send Solana transaction: $e');
    }
  }

  @override
  Future<String> signMessage(Uint8List message) async {
    try {
      // Sign the message using the keypair
      final signature = await _keypair.sign(message);

      print("Message signed with Solana wallet");
      return signature.toString();
    } catch (e) {
      print("Error signing message with Solana wallet: $e");
      throw Web3AuthException('Failed to sign message with Solana wallet: $e');
    }
  }

  /// Get latest blockhash using the available method
  Future<String> _getLatestBlockhash() async {
    try {
      // Use getLatestBlockhash if available
      final response = await _client.rpcClient.getLatestBlockhash();
      return response.value.blockhash;
    } catch (e) {
      // Fallback to a different method or use a mock value for testing
      print("Error getting latest blockhash: $e");
      throw Web3AuthException('Failed to get latest blockhash: $e');
    }
  }

  /// Convert hex string to bytes
  Uint8List _hexToBytes(String hex) {
    final String cleanHex = hex.startsWith('0x') ? hex.substring(2) : hex;
    final int len = cleanHex.length;
    final Uint8List result = Uint8List(len ~/ 2);

    for (int i = 0; i < len; i += 2) {
      final int value = int.parse(cleanHex.substring(i, i + 2), radix: 16);
      result[i ~/ 2] = value;
    }

    return result;
  }

  /// Base58 encode
  String base58encode(Uint8List bytes) {
    const alphabet =
        '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz';

    BigInt integer = BigInt.zero;
    for (final byte in bytes) {
      integer = integer * BigInt.from(256) + BigInt.from(byte);
    }

    String result = '';
    while (integer > BigInt.zero) {
      final remainder = (integer % BigInt.from(58)).toInt();
      integer = integer ~/ BigInt.from(58);
      result = alphabet[remainder] + result;
    }

    // Add leading 1s for leading zeros
    for (int i = 0; i < bytes.length && bytes[i] == 0; i++) {
      result = '1$result';
    }

    return result;
  }
}

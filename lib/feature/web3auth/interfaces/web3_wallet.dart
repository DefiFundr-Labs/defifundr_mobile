import 'dart:typed_data';

/// Base abstract class for wallet implementations
abstract class Web3Wallet {
  /// Gets the public address for this wallet
  Future<String> getAddress();

  /// Gets the balance for this wallet
  Future<double> getBalance();

  /// Sends a transaction from this wallet
  Future<String> sendTransaction({
    required String to,
    required double amount,
  });

  /// Signs a message with this wallet's private key
  Future<String> signMessage(Uint8List message);
}

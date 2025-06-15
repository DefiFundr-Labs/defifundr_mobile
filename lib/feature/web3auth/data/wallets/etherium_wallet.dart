import 'dart:typed_data';

import 'package:defifundr_mobile/feature/web3auth/domain/exceptions/web3auth_exception.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../../domain/interfaces/web3_wallet.dart';

/// Implementation of Ethereum wallet
class EthereumWallet extends Web3Wallet {
  final String privateKey;
  final String rpcUrl;
  late final Web3Client _client;
  late final EthPrivateKey _credentials;

  EthereumWallet({
    required this.privateKey,
    required this.rpcUrl,
  }) {
    _client = Web3Client(rpcUrl, http.Client());
    _credentials = EthPrivateKey.fromHex(privateKey);
  }

  @override
  Future<String> getAddress() async {
    final address = _credentials.address;
    return address.hexEip55;
  }

  @override
  Future<double> getBalance() async {
    final address = _credentials.address;
    final weiBalance = await _client.getBalance(address);

    // Convert wei to ether
    final etherAmount = EtherAmount.fromBigInt(
      EtherUnit.ether,
      weiBalance.getInWei,
    );

    return etherAmount.getValueInUnit(EtherUnit.ether);
  }

  @override
  Future<String> sendTransaction({
    required String to,
    required double amount,
  }) async {
    try {
      final receipt = await _client.sendTransaction(
        _credentials,
        Transaction(
          to: EthereumAddress.fromHex(to),
          value: EtherAmount.fromUnitAndValue(
            EtherUnit.ether,
            (amount * 1e18).toInt(),
          ),
        ),
        chainId: 11155111, // Sepolia testnet
      );

      return receipt;
    } catch (e) {
      throw Web3AuthException('Failed to send transaction: $e');
    }
  }

  @override
  Future<String> signMessage(Uint8List message) async {
    final signature = await _credentials.signPersonalMessage(message);
    return _bytesToHex(signature);
  }

  /// Convert bytes to hexadecimal string
  String _bytesToHex(List<int> bytes) {
    return '0x${bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('')}';
  }

  /// Get transaction history for the address
  Future<List<Map<String, dynamic>>> getTransactionHistory() async {
    final address = await getAddress();

    // This would typically use an explorer API like Etherscan
    // For simplicity, we'll return a placeholder
    return [
      {
        'hash': '0x...',
        'from': address,
        'to': '0xeaA8Af602b2eDE45922818AE5f9f7FdE50cFa1A8',
        'value': '0.001',
        'timestamp':
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      }
    ];
  }

  /// Dispose resources
  void dispose() {
    _client.dispose();
  }
}

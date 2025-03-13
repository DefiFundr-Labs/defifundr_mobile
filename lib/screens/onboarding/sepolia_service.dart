import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class SepoliaService {
  late Web3Client _client;
  late EthPrivateKey _credentials;

  // Initialize with private key and connect to Sepolia
  Future<void> initialize(String privateKey) async {
    _credentials = EthPrivateKey.fromHex(privateKey);

    // Connect to Sepolia testnet
    _client = Web3Client(
      'https://sepolia.infura.io/v3/72161e5e7aeb402fa09330f046462e30', // Replace with your provider
      http.Client(),
    );
  }

  // Get ETH balance
  Future<double> getEthBalance() async {
    try {
      final balance = await _client.getBalance(_credentials.address);
      // Convert from Wei to ETH (1 ETH = 10^18 Wei)
      return balance.getValueInUnit(EtherUnit.ether);
    } catch (e) {
      print('Error getting ETH balance: $e');
      return 0.0;
    }
  }

  // Send ETH transaction
  Future<String> sendEth(String to, double amountInEth) async {
    try {
      // Convert double to BigInt
      // First multiply by 10^18 to get the amount in wei
      final amountInWei = BigInt.from(amountInEth * 1e18);

      final txHash = await _client.sendTransaction(
        _credentials,
        Transaction(
          gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 1),
          to: EthereumAddress.fromHex(to),
          value: EtherAmount.fromBigInt(EtherUnit.wei, amountInWei),
        ),
        chainId: 11155111, // Sepolia chain ID
      );
      return txHash;
    } catch (e) {
      print('Error sending ETH: $e');
      rethrow;
    }
  }

  // Dispose client when done
  void dispose() {
    _client.dispose();
  }
}

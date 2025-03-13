import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class TokenService {
  late Web3Client _client;
  late EthPrivateKey _credentials;

  // Token Contract Addresses (Ethereum Mainnet)
  final String usdtAddress = '0xdAC17F958D2ee523a2206206994597C13D831ec7';
  final String usdcAddress = '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48';

  // Initialize with private key
  Future<void> initialize(String privateKey) async {
    _credentials = EthPrivateKey.fromHex(privateKey);
    _client = Web3Client(
      'https://mainnet.infura.io/v3/72161e5e7aeb402fa09330f046462e30',
      http.Client(),
    );
  }

// Update your getTokenBalance method to handle empty results
  Future<double> getTokenBalance(String tokenAddress) async {
    try {
      // ERC-20 balanceOf function signature
      final function = ContractFunction(
          'balanceOf', [FunctionParameter('owner', AddressType())]);

      // Create contract
      final contract = DeployedContract(
        ContractAbi.fromJson(erc20Abi, 'ERC20'),
        EthereumAddress.fromHex(tokenAddress),
      );

      // Make the call to the token contract
      final result = await _client.call(
        contract: contract,
        function: contract.function('balanceOf'),
        params: [_credentials.address],
      );

      // Add error checking for empty results
      if (result.isEmpty) {
        print('Empty result from balanceOf call');
        return 0.0;
      }

      // Convert the result based on token decimals
      final decimals =
          tokenAddress.toLowerCase() == usdtAddress.toLowerCase() ||
                  tokenAddress.toLowerCase() == usdcAddress.toLowerCase()
              ? 6
              : 18;

      final balance = BigInt.parse(result[0].toString());
      return balance / BigInt.from(10).pow(decimals);
    } catch (e) {
      print('Error getting token balance: $e');
      return 0.0;
    }
  }

  // Transfer ERC-20 tokens
  Future<String> transferToken(
      String tokenAddress, String to, double amount) async {
    // Determine token decimals (USDT and USDC use 6 decimals)
    final decimals = tokenAddress.toLowerCase() == usdtAddress.toLowerCase() ||
            tokenAddress.toLowerCase() == usdcAddress.toLowerCase()
        ? 6
        : 18;

    // Convert amount to token units with proper decimals
    final amountInTokenUnits = BigInt.from(amount * pow(10, decimals));

    // Create contract instance
    final contract = DeployedContract(
      ContractAbi.fromJson(erc20Abi, 'ERC20'),
      EthereumAddress.fromHex(tokenAddress),
    );

    // Get the transfer function
    final transferFunction = contract.function('transfer');

    // Execute the transaction
    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: contract,
        function: transferFunction,
        parameters: [EthereumAddress.fromHex(to), amountInTokenUnits],
      ),
      chainId: 1,
    );

    return txHash;
  }

  Future<String> transferUSDTOptimized(String to, double amount) async {
    // USDT contract on Ethereum
    const usdtAddress = '0xdAC17F958D2ee523a2206206994597C13D831ec7';

    // Create contract instance
    final contract = DeployedContract(
      ContractAbi.fromJson(erc20Abi, 'USDT'),
      EthereumAddress.fromHex(usdtAddress),
    );

    // Convert amount (USDT has 6 decimals)
    final amountInTokenUnits = BigInt.from(amount * 1000000);

    // Get current gas price
    final gasPrice = await _client.getGasPrice();
    // Optionally reduce it slightly for a "slower" but cheaper transaction
    final optimizedGasPrice = EtherAmount.fromBigInt(
        EtherUnit.wei,
        (gasPrice.getInWei * BigInt.from(90)) ~/
            BigInt.from(100) // 90% of current gas price
        );

    // Send the transaction with optimized gas settings
    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: contract,
        function: contract.function('transfer'),
        parameters: [EthereumAddress.fromHex(to), amountInTokenUnits],
        gasPrice: optimizedGasPrice,
        maxGas:
            75000, // Slightly higher than typical needed to ensure it completes
      ),
      chainId: 1, // Change this for other networks
    );

    return txHash;
  }

  // Get both USDT and USDC balances
  Future<Map<String, double>> getStablecoinBalances() async {
    final usdtBalance = await getTokenBalance(usdtAddress);
    final usdcBalance = await getTokenBalance(usdcAddress);

    return {
      'USDT': usdtBalance,
      'USDC': usdcBalance,
    };
  }

  // Don't forget to dispose the client
  void dispose() {
    _client.dispose();
  }
}

const String erc20Abi = '''
[
  {
    "constant": true,
    "inputs": [{"name": "_owner", "type": "address"}],
    "name": "balanceOf",
    "outputs": [{"name": "balance", "type": "uint256"}],
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {"name": "_to", "type": "address"},
      {"name": "_value", "type": "uint256"}
    ],
    "name": "transfer",
    "outputs": [{"name": "", "type": "bool"}],
    "type": "function"
  }
]
''';

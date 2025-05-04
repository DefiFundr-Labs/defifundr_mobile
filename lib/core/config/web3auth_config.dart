import 'package:defifundr_mobile/core/enums/blockchain_type.dart';
import 'package:web3auth_flutter/enums.dart';

class Web3AuthConfig {
  final String clientId;
  final Uri redirectUrl;
  final Network network;
  final BuildEnv buildEnv;
  final int sessionTime;
  final Map<BlockchainType, String> rpcUrls;
  final bool enableLogging;

  Web3AuthConfig({
    required this.clientId,
    required this.redirectUrl,
    this.network = Network.sapphire_mainnet,
    this.buildEnv = BuildEnv.production,
    this.sessionTime = 86400, // Default 1 day
    this.rpcUrls = const {
      BlockchainType.ethereum: 'https://1rpc.io/sepolia',
      BlockchainType.solana: 'https://api.mainnet-beta.solana.com',
      BlockchainType.starknet: 'https://rpc.sepolia.org',
    },
    this.enableLogging = false,
  });
}

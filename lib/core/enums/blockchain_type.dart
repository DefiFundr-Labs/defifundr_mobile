enum BlockchainType {
  ethereum,
  solana,
  starknet;

  String get displayName => switch (this) {
    BlockchainType.ethereum => 'Ethereum',
    BlockchainType.solana => 'Solana',
    BlockchainType.starknet => 'StarkNet',
  };
}
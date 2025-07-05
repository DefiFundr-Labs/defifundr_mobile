import 'package:defifundr_mobile/core/gen/assets.gen.dart';

class Network {
  final String iconPath;
  final String name;
  final String subtitle;
  final String balance;
  final String balanceCurrency;

  Network({
    required this.iconPath,
    required this.name,
    required this.subtitle,
    required this.balance,
    required this.balanceCurrency,
  });

  static List<Network> supportedNetworks = [
    Network(
      iconPath: Assets.images.ethPng.path,
      name: 'Ethereum',
      subtitle: 'Ethereum',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.starknet.path,
      name: 'Starknet',
      subtitle: 'Starknet',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.base.path,
      name: 'Base',
      subtitle: 'Base',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.optimism.path,
      name: 'Optimism',
      subtitle: 'Optimism',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.arbitrum.path,
      name: 'Arbitrum',
      subtitle: 'Arbitrum',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.bnb.path,
      name: 'BNB Chain',
      subtitle: 'BNB Chain',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.matic.path,
      name: 'Polygon',
      subtitle: 'Polygon',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.gnosis.path,
      name: 'Gnosis Chain',
      subtitle: 'Gnosis Chain',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.zksync.path,
      name: 'zkSync Era',
      subtitle: 'zkSync Era',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    Network(
      iconPath: Assets.images.celo.path,
      name: 'Celo',
      subtitle: 'Celo',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
  ];
}

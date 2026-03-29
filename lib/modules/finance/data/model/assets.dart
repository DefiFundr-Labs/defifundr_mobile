import 'package:defifundr_mobile/core/gen/assets.gen.dart';
import 'package:defifundr_mobile/modules/finance/data/model/network.dart';

class NetworkAsset {
  final String iconPath;
  final String name;
  final String price;
  final String change;
  final String balance;
  final String balanceCurrency;
  final Network? network;

  const NetworkAsset({
    required this.iconPath,
    required this.name,
    required this.price,
    required this.change,
    required this.balance,
    required this.balanceCurrency,
    this.network,
  });

  static List<NetworkAsset> supportedAssets = [
    NetworkAsset(
      iconPath: Assets.images.ethPng.path,
      name: 'ETH',
      price: 'Ethereum',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 ETH',
    ),
    NetworkAsset(
      iconPath: Assets.images.usdtPng.path,
      name: 'USDC',
      price: 'USD Coin',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 USDC',
    ),
    NetworkAsset(
      iconPath: Assets.images.usdtPng.path,
      name: 'USDT',
      price: 'Tether USD',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 USDT',
    ),
    NetworkAsset(
      iconPath: Assets.images.dai.path,
      name: 'DAI',
      price: 'Dai Stablecoin',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 DAI',
    ),
    NetworkAsset(
      iconPath: Assets.images.usdd.path,
      name: 'USDD',
      price: 'Decentralized USD',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 USDD',
    ),
    NetworkAsset(
      iconPath: Assets.images.lusd.path,
      name: 'LUSD',
      price: 'Liquity USD',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 LUSD',
    ),
    NetworkAsset(
      iconPath: Assets.images.eurt.path,
      name: 'EURt',
      price: 'Euro Tether',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 EURt',
    ),
    NetworkAsset(
      iconPath: Assets.images.starknet.path,
      name: 'STARK',
      price: 'Starknet',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 STARK',
    ),
    NetworkAsset(
      iconPath: Assets.images.xdai.path,
      name: 'xDAI',
      price: 'Gnosis Chain',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 xDAI',
    ),
    NetworkAsset(
      iconPath: Assets.images.bnb.path,
      name: 'BNB',
      price: 'BNB Chain',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 BNB',
    ),
    NetworkAsset(
      iconPath: Assets.images.matic.path,
      name: 'POL',
      price: 'Polygon',
      change: '',
      balance: '\$0.00',
      balanceCurrency: '0 POL',
    ),
  ];
}

final List<NetworkAsset> dummyAssets = NetworkAsset.supportedAssets;

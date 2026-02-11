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
}

const List<NetworkAsset> dummyAssets = [
  NetworkAsset(
    iconPath: 'assets/images/usdt.png',
    name: 'Tether USD',
    price: '\$1.00',
    change: '-0.0018%',
    balance: '\$476.19',
    balanceCurrency: '581 USDT',
  ),
  NetworkAsset(
    iconPath: 'assets/images/usdc.png',
    name: 'USD Coin',
    price: '\$0.99',
    change: '-0.005%',
    balance: '\$381.19',
    balanceCurrency: '381 USDC',
  ),
];

class Asset {
  final String symbol;
  final int decimals;
  final String logoUrl;

  const Asset({
    required this.symbol,
    required this.decimals,
    required this.logoUrl,
  });

  @override
  String toString() => symbol;
}

class CoinAssets {
  final String coinName;
  final List<Asset> assets;
  final String logoUrl;

  const CoinAssets({
    required this.coinName,
    required this.assets,
    required this.logoUrl,
  });

  @override
  String toString() => '$coinName: ${assets.map((a) => a.symbol).join(', ')}';
}

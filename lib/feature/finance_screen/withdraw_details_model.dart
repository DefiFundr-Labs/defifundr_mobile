class WithdrawDetails {
  final String amount;
  final String assetName;
  final String assetIconPath;
  final String networkName;
  final String networkIconPath;
  final String recipientAddress;
  final String fee;
  final String feeCurrency;

  WithdrawDetails({
    required this.amount,
    required this.assetName,
    required this.assetIconPath,
    required this.networkName,
    required this.networkIconPath,
    required this.recipientAddress,
    required this.fee,
    required this.feeCurrency,
  });
}

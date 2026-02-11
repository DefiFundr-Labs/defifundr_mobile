import 'package:equatable/equatable.dart';

class WithdrawDetailsModel extends Equatable {
  final double amount;
  final String assetName;
  final String assetIconPath;
  final String networkName;
  final String networkIconPath;
  final double fee;
  final String feeCurrency;
  final String address;
  final String recipientAddress;
  final String memo;

  const WithdrawDetailsModel({
    required this.amount,
    required this.assetName,
    required this.assetIconPath,
    required this.networkName,
    required this.networkIconPath,
    required this.fee,
    required this.feeCurrency,
    required this.address,
    required this.recipientAddress,
    required this.memo,
  });

  @override
  List<Object?> get props => [
        amount,
        assetName,
        assetIconPath,
        networkName,
        networkIconPath,
        fee,
        feeCurrency,
        address,
        recipientAddress,
        memo,
      ];

  WithdrawDetailsModel copyWith({
    double? amount,
    String? assetName,
    String? assetIconPath,
    String? networkName,
    String? networkIconPath,
    double? fee,
    String? feeCurrency,
    String? address,
    String? recipientAddress,
    String? memo,
  }) {
    return WithdrawDetailsModel(
      amount: amount ?? this.amount,
      assetName: assetName ?? this.assetName,
      assetIconPath: assetIconPath ?? this.assetIconPath,
      networkName: networkName ?? this.networkName,
      networkIconPath: networkIconPath ?? this.networkIconPath,
      fee: fee ?? this.fee,
      feeCurrency: feeCurrency ?? this.feeCurrency,
      address: address ?? this.address,
      recipientAddress: recipientAddress ?? this.recipientAddress,
      memo: memo ?? this.memo,
    );
  }
}

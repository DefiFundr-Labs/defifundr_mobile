import 'package:equatable/equatable.dart';
import 'package:defifundr_mobile/modules/finance/presentation/withdraw/withdraw_details_model.dart';

enum WithdrawStatus {
  initial,
  loading,
  success,
  failure,
}

class WithdrawState extends Equatable {
  final WithdrawStatus status;
  final WithdrawDetailsModel? withdrawDetails;
  final String? errorMessage;

  const WithdrawState({
    this.status = WithdrawStatus.initial,
    this.withdrawDetails,
    this.errorMessage,
  });

  WithdrawState copyWith({
    WithdrawStatus? status,
    WithdrawDetailsModel? withdrawDetails,
    String? errorMessage,
    bool clearError = false,
  }) {
    return WithdrawState(
      status: status ?? this.status,
      withdrawDetails: withdrawDetails ?? this.withdrawDetails,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, withdrawDetails, errorMessage];
}

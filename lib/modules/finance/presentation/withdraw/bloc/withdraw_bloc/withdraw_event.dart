import 'package:equatable/equatable.dart';
import 'package:defifundr_mobile/modules/finance/data/model/withdraw_details_model.dart';

abstract class WithdrawEvent extends Equatable {
  const WithdrawEvent();

  @override
  List<Object?> get props => [];
}

class SetWithdrawDetails extends WithdrawEvent {
  final WithdrawDetailsModel withdrawDetails;

  const SetWithdrawDetails(this.withdrawDetails);

  @override
  List<Object?> get props => [withdrawDetails];
}

class ClearWithdrawDetails extends WithdrawEvent {
  const ClearWithdrawDetails();
}

class ProcessWithdraw extends WithdrawEvent {
  const ProcessWithdraw();
}

class CompleteWithdraw extends WithdrawEvent {
  const CompleteWithdraw();
}

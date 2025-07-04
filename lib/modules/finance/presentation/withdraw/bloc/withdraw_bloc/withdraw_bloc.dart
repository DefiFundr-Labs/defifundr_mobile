import 'package:flutter_bloc/flutter_bloc.dart';
import 'withdraw_event.dart';
import 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  WithdrawBloc() : super(const WithdrawState()) {
    on<SetWithdrawDetails>(_onSetWithdrawDetails);
    on<ClearWithdrawDetails>(_onClearWithdrawDetails);
    on<ProcessWithdraw>(_onProcessWithdraw);
    on<CompleteWithdraw>(_onCompleteWithdraw);
  }

  void _onSetWithdrawDetails(
    SetWithdrawDetails event,
    Emitter<WithdrawState> emit,
  ) {
    emit(state.copyWith(
      status: WithdrawStatus.initial,
      withdrawDetails: event.withdrawDetails,
      clearError: true,
    ));
  }

  void _onClearWithdrawDetails(
    ClearWithdrawDetails event,
    Emitter<WithdrawState> emit,
  ) {
    emit(const WithdrawState());
  }

  Future<void> _onProcessWithdraw(
    ProcessWithdraw event,
    Emitter<WithdrawState> emit,
  ) async {
    if (state.withdrawDetails == null) {
      emit(state.copyWith(
        status: WithdrawStatus.failure,
        errorMessage: 'No withdraw details available',
      ));
      return;
    }

    emit(state.copyWith(status: WithdrawStatus.loading));

    try {
      // TODO: Implement actual withdraw processing logic here
      // For now, we'll just simulate a successful withdraw
      await Future.delayed(const Duration(seconds: 2));

      // Keep the withdraw details in state while processing
      emit(state.copyWith(
        status: WithdrawStatus.success,
        withdrawDetails: state.withdrawDetails,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WithdrawStatus.failure,
        errorMessage: e.toString(),
        withdrawDetails: state.withdrawDetails, // Keep details even on error
      ));
    }
  }

  Future<void> _onCompleteWithdraw(
    CompleteWithdraw event,
    Emitter<WithdrawState> emit,
  ) async {
    if (state.withdrawDetails == null) {
      emit(state.copyWith(
        status: WithdrawStatus.failure,
        errorMessage: 'No withdraw details available',
      ));
      return;
    }

    try {
      // TODO: Implement actual withdraw completion logic here
      // For now, we'll just simulate a successful completion
      await Future.delayed(const Duration(seconds: 1));

      // Keep the withdraw details until explicitly cleared
      emit(state.copyWith(
        status: WithdrawStatus.success,
        withdrawDetails: state.withdrawDetails,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WithdrawStatus.failure,
        errorMessage: e.toString(),
        withdrawDetails: state.withdrawDetails, // Keep details even on error
      ));
    }
  }
}

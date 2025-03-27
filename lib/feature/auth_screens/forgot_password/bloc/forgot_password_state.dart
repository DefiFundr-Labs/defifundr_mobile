// forgot_password_state.dart
part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  const ForgotPasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  const ForgotPasswordError(this.error);

  @override
  List<Object> get props => [error];
}

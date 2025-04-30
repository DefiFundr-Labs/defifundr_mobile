// forgot_password_event.dart
part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class SubmitEmail extends ForgotPasswordEvent {
  final String email;
  const SubmitEmail(this.email);

  @override
  List<Object> get props => [email];
}

class EnterPasswordString extends ForgotPasswordEvent {
  final String passwordString;
  const EnterPasswordString(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class EnterConfirmPasswordString extends ForgotPasswordEvent {
  final String passwordString;
  const EnterConfirmPasswordString(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class TogglePasswordVisibility extends ForgotPasswordEvent {
  const TogglePasswordVisibility();

  @override
  List<Object> get props => [];
}

class ToggleConfirmPasswordVisibility extends ForgotPasswordEvent {
  const ToggleConfirmPasswordVisibility();

  @override
  List<Object> get props => [];
}

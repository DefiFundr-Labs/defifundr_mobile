part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SubmitEmail extends AuthEvent {
  final String email;
  const SubmitEmail(this.email);

  @override
  List<Object> get props => [email];
}

class EnterForgotPasswordString extends AuthEvent {
  final String passwordString;
  const EnterForgotPasswordString(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class EnterForgotConfirmPasswordString extends AuthEvent {
  final String passwordString;
  const EnterForgotConfirmPasswordString(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class ToggleForgotPasswordVisibility extends AuthEvent {
  const ToggleForgotPasswordVisibility();

  @override
  List<Object> get props => [];
}

class ToggleForgotConfirmPasswordVisibility extends AuthEvent {
  const ToggleForgotConfirmPasswordVisibility();

  @override
  List<Object> get props => [];
}

class ResendForgotPasswordOtpEvent extends AuthEvent {
  const ResendForgotPasswordOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyForgotPasswordOtpEvent extends AuthEvent {
  final String otpCode;
  const VerifyForgotPasswordOtpEvent(this.otpCode);

  @override
  List<Object> get props => [];
}

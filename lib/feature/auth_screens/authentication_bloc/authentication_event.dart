part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SubmitEmail extends AuthenticationEvent {
  final String email;
  const SubmitEmail(this.email);

  @override
  List<Object> get props => [email];
}

class EnterForgotPasswordString extends AuthenticationEvent {
  final String passwordString;
  const EnterForgotPasswordString(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class EnterForgotConfirmPasswordString extends AuthenticationEvent {
  final String passwordString;
  const EnterForgotConfirmPasswordString(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class ToggleForgotPasswordVisibility extends AuthenticationEvent {
  const ToggleForgotPasswordVisibility();

  @override
  List<Object> get props => [];
}

class ToggleForgotConfirmPasswordVisibility extends AuthenticationEvent {
  const ToggleForgotConfirmPasswordVisibility();

  @override
  List<Object> get props => [];
}

class ResendForgotPasswordOtpEvent extends AuthenticationEvent {
  const ResendForgotPasswordOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyForgotPasswordOtpEvent extends AuthenticationEvent {
  final String otpCode;
  const VerifyForgotPasswordOtpEvent(this.otpCode);

  @override
  List<Object> get props => [];
}

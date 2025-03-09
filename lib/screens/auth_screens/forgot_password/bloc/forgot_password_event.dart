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

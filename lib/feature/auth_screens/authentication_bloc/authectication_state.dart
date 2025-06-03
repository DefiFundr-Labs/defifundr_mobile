part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final ForgotPasswordState? forgotPasswordState;
  @override
  List<Object?> get props => [forgotPasswordState];
  const AuthenticationState({this.forgotPasswordState});
}

class AuthInitialState extends AuthenticationState {
  const AuthInitialState({super.forgotPasswordState});
}

class AuthSuccessState extends AuthenticationState {
  final String message;

  const AuthSuccessState(this.message, {super.forgotPasswordState});

  @override
  List<Object?> get props => super.props..add(message);
}

class AuthErrorState extends AuthenticationState {
  final String error;

  const AuthErrorState(this.error, {super.forgotPasswordState});

  @override
  List<Object?> get props => super.props..add(error);
}

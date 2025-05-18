part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final ForgotPasswordState? forgotPasswordState;
  @override
  List<Object?> get props => [forgotPasswordState];
  const AuthState({this.forgotPasswordState});
}

class AuthInitialState extends AuthState {
  const AuthInitialState({super.forgotPasswordState});
}

class AuthSuccessState extends AuthState {
  final String message;

  const AuthSuccessState(this.message, {super.forgotPasswordState});

  @override
  List<Object?> get props => super.props..add(message);
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState(this.error, {super.forgotPasswordState});

  @override
  List<Object?> get props => super.props..add(error);
}

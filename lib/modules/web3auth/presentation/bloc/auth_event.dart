import 'package:defifundr_mobile/core/enums/blockchain_type.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class InitializeAuth extends AuthEvent {
  const InitializeAuth();
}

class LoginWithEmail extends AuthEvent {
  final String email;

  const LoginWithEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginWithGoogle extends AuthEvent {
  const LoginWithGoogle();
}

class LoginWithApple extends AuthEvent {
  const LoginWithApple();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class ChangeBlockchain extends AuthEvent {
  final BlockchainType blockchainType;

  const ChangeBlockchain(this.blockchainType);

  @override
  List<Object?> get props => [blockchainType];
}

class SignMessage extends AuthEvent {
  final String message;

  const SignMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateWalletInfo extends AuthEvent {
  const UpdateWalletInfo();
}

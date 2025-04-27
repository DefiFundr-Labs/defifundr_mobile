part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  final NewPasswordState? newPasswordState;
  @override
  List<Object?> get props => [newPasswordState];
  const ForgotPasswordState({this.newPasswordState});
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial({super.newPasswordState});
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPasswordSuccess(this.message);

  @override
  List<Object?> get props => super.props..add(message);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;

  const ForgotPasswordError(this.error);

  @override
  List<Object?> get props => super.props..add(error);
}

class NewPasswordState {
  final String password;
  final String confirmPassword;
  final bool showPassword;
  final bool showConfirmPassword;

  bool get has8Characters => password.length >= 8;

  bool get hasNumber => RegExp(r'[0-9]+').hasMatch(password);

  bool get hasUppercaseCharacter => RegExp(r'[A-Z]+').hasMatch(password);

  bool get hasLowercaseCharacter => RegExp(r'[a-z]+').hasMatch(password);

  bool get hasSpecialCharacter => RegExp(r"[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:',<>\./\?]+").hasMatch(password);

  bool get passwordConfirmed => password == confirmPassword;

  bool get isVerificationPassed => has8Characters && hasNumber && hasUppercaseCharacter && hasLowercaseCharacter && hasSpecialCharacter && passwordConfirmed;

  const NewPasswordState({required this.password, this.confirmPassword = '', this.showPassword = false, this.showConfirmPassword = false});

  NewPasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? showPassword,
    bool? showConfirmPassword,
  }) {
    return NewPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
    );
  }
}

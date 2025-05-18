import 'new_password_state.dart';

class ForgotPasswordState {
  final NewPasswordState? newPasswordState;
  final String? emailAddress;

  const ForgotPasswordState({this.emailAddress, this.newPasswordState});

  @override
  int get hashCode => emailAddress.hashCode ^ newPasswordState.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! ForgotPasswordState) return false;
    return hashCode == other.hashCode;
  }

  ForgotPasswordState copyWith({
    String? emailAddress,
    NewPasswordState? newPasswordState,
  }) {
    return ForgotPasswordState(
      emailAddress: emailAddress ?? this.emailAddress,
      newPasswordState: newPasswordState ?? this.newPasswordState,
    );
  }
}

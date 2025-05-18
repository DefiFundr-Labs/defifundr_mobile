class NewPasswordState {
  final String password;
  final String confirmPassword;
  final bool hidePassword;
  final bool hideConfirmPassword;

  bool get has8Characters => password.length >= 8;

  bool get hasNumber => RegExp(r'[0-9]+').hasMatch(password);

  bool get hasUppercaseCharacter => RegExp(r'[A-Z]+').hasMatch(password);

  bool get hasLowercaseCharacter => RegExp(r'[a-z]+').hasMatch(password);

  bool get hasSpecialCharacter => RegExp(r"[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:',<>\./\?]+").hasMatch(password);

  bool get passwordConfirmed => password == confirmPassword;

  bool get isVerificationPassed => has8Characters && hasNumber && hasUppercaseCharacter && hasLowercaseCharacter && hasSpecialCharacter && passwordConfirmed;

  const NewPasswordState({required this.password, this.confirmPassword = '', this.hidePassword = true, this.hideConfirmPassword = true});

  @override
  int get hashCode => password.hashCode ^ confirmPassword.hashCode ^ hidePassword.hashCode ^ hideConfirmPassword.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! NewPasswordState) return false;
    return hashCode == other.hashCode;
  }
}

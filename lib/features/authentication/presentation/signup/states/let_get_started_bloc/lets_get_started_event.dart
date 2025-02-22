// sign_up_event.dart
part of 'lets_get_started_bloc.dart';



abstract class LetsGetStartedEvent extends Equatable {
  const LetsGetStartedEvent();
}

class ValidateSignUp extends LetsGetStartedEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final bool agreeToTerms;

  const ValidateSignUp({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.agreeToTerms,
  });

  @override
  List<Object> get props => [email, firstName, lastName, gender, agreeToTerms];
}

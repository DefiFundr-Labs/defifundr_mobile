// sign_up_state.dart
part of 'lets_get_to_know_you_bloc.dart';

abstract class LetsGetToKnowYouState extends Equatable {
  const LetsGetToKnowYouState();
}

class LetsGetToKnowYouInitial extends LetsGetToKnowYouState {
  @override
  List<Object> get props => [];
}

class LetsGetToKnowYouValid extends LetsGetToKnowYouState {
  final String email;
  final String firstName;
  final String lastName;
  final String gender;

  const LetsGetToKnowYouValid(
      this.email, this.firstName, this.lastName, this.gender);

  @override
  List<Object> get props => [email, firstName, lastName, gender];
}

class LetsGetToKnowYouError extends LetsGetToKnowYouState {
  final String message;

  const LetsGetToKnowYouError(this.message);

  @override
  List<Object> get props => [message];
}

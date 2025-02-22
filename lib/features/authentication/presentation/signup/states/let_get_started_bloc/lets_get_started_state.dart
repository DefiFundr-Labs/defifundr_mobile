// sign_up_state.dart
part of 'lets_get_started_bloc.dart';

abstract class LetsGetStartedState extends Equatable {
  const LetsGetStartedState();
}

class LetsGetStartedInitial extends LetsGetStartedState {
  @override
  List<Object> get props => [];
}

class  LetsGetStartedValid extends LetsGetStartedState {
  final String email;
  final String firstName;
  final String lastName;
  final String gender;

  const LetsGetStartedValid(this.email, this.firstName, this.lastName, this.gender);

  @override
  List<Object> get props => [email, firstName, lastName, gender];
}

class LetsGetStartedError extends LetsGetStartedState {
  final String message;

  const LetsGetStartedError(this.message);

  @override
  List<Object> get props => [message];
}
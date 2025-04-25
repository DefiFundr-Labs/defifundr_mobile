import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:email_validator/email_validator.dart';

part 'lets_get_to_know_you_event.dart';
part 'lets_get_to_know_you_state.dart';

class LetsGetToKnowYouBloc
    extends Bloc<LetsGetToKnowYouEvent, LetsGetToKnowYouState> {
  LetsGetToKnowYouBloc() : super(LetsGetToKnowYouInitial()) {
    on<ValidateSignUp>((event, emit) {
      if (!EmailValidator.validate(event.email)) {
        emit(LetsGetToKnowYouError("Invalid email format"));
        return;
      }
      if (event.firstName.length < 3) {
        emit(LetsGetToKnowYouError("First name must be at least 3 characters"));
        return;
      }
      if (event.lastName.length < 3) {
        emit(LetsGetToKnowYouError("Last name must be at least 3 characters"));
        return;
      }
      if (event.gender.isEmpty) {
        emit(LetsGetToKnowYouError("Please enter your gender"));
        return;
      }
      if (!event.agreeToTerms) {
        emit(LetsGetToKnowYouError(
            "You must agree to the terms and conditions"));
        return;
      }

      emit(LetsGetToKnowYouValid(
          event.email, event.firstName, event.lastName, event.gender));
      print(
          "Email: \${event.email}, First Name: \${event.firstName}, Last Name: \${event.lastName}, Gender: \${event.gender}, Agreed to Terms: \${event.agreeToTerms}");
    });
  }
}

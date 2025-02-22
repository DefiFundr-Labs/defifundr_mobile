import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:email_validator/email_validator.dart';



part 'lets_get_started_event.dart';
part 'lets_get_started_state.dart';


class LetsGetStartedBloc extends Bloc<LetsGetStartedEvent, LetsGetStartedState> {
  LetsGetStartedBloc() : super(LetsGetStartedInitial()) {
    on<ValidateSignUp>((event, emit) {
      if (!EmailValidator.validate(event.email)) {
        emit(LetsGetStartedError("Invalid email format"));
        return;
      }
      if (event.firstName.length < 3) {
        emit(LetsGetStartedError("First name must be at least 3 characters"));
        return;
      }
      if (event.lastName.length < 3) {
        emit(LetsGetStartedError("Last name must be at least 3 characters"));
        return;
      }
      if (event.gender.isEmpty || (event.gender != "Male" && event.gender != "Female")) {
        emit(LetsGetStartedError("Please select a valid gender"));
        return;
      }
      if (!event.agreeToTerms) {
        emit(LetsGetStartedError("You must agree to the terms and conditions"));
        return;
      }
      
      emit(LetsGetStartedValid(event.email, event.firstName, event.lastName, event.gender));
      print("Email: \${event.email}, First Name: \${event.firstName}, Last Name: \${event.lastName}, Gender: \${event.gender}, Agreed to Terms: \${event.agreeToTerms}");
    });
  }
}

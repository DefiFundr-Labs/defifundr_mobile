import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:email_validator/email_validator.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SubmitEmail>((event, emit) {
      if (!EmailValidator.validate(event.email)) {
        emit(ForgotPasswordError("Invalid email format"));
        return;
      }
      emit(ForgotPasswordSuccess(
          "A reset link has been sent to ${event.email}"));
    });
  }
}

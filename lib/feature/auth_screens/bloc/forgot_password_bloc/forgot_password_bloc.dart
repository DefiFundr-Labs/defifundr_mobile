import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SubmitEmail>((event, emit) {
      if (!EmailValidator.validate(event.email)) {
        emit(ForgotPasswordError("Invalid email format"));
        return;
      }
      emit(ForgotPasswordSuccess("A reset link has been sent to ${event.email}"));
    });

    on<EnterPasswordString>(
      (event, emit) async {
        // Adding a delay to prevent overloading the UI with state changes
        // This is a simple way to debounce the event and prevent rapid state changes
        await Future.delayed(Duration(milliseconds: 300));
        emit(
          ForgotPasswordInitial(
            newPasswordState:
                (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(password: event.passwordString),
          ),
        );
      },
      // Use the `restartable` transformer to prevent multiple rapid state changes
      // that can occur when the user rapidly toggles the password visibility
      // This will ensure that only the last event is processed after the delay
      transformer: restartable(),
    );
    on<EnterConfirmPasswordString>(
      (event, emit) async {
        // Adding a delay to prevent overloading the UI with state changes
        // This is a simple way to debounce the event and prevent rapid state changes
        await Future.delayed(Duration(milliseconds: 300));
        emit(
          ForgotPasswordInitial(
            newPasswordState:
                (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(confirmPassword: event.passwordString),
          ),
        );
      },
      // Use the `restartable` transformer to prevent multiple rapid state changes
      // that can occur when the user rapidly toggles the password visibility
      // This will ensure that only the last event is processed after the delay
      transformer: restartable(),
    );
    on<TogglePasswordVisibility>((event, emit) {
      emit(ForgotPasswordInitial(
          newPasswordState: (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? ''))
              .copyWith(showPassword: !(state.newPasswordState?.hidePassword ?? false))));
    });
    on<ToggleConfirmPasswordVisibility>(
      (event, emit) {
        emit(
          ForgotPasswordInitial(
            newPasswordState: (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(
              showConfirmPassword: !(state.newPasswordState?.hideConfirmPassword ?? false),
            ),
          ),
        );
      },
    );
  }
}

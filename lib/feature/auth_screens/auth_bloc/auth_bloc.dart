import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:defifundr_mobile/feature/auth_screens/models/forgot_password_state.dart';
import 'package:defifundr_mobile/feature/auth_screens/models/new_password_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SubmitEmail>(_submitEmailHandler);

    on<EnterForgotPasswordString>(
      _enterForgotPasswordStringHandler,
      // Use the `restartable` transformer to prevent multiple rapid state changes
      // that can occur when the user rapidly toggles the password visibility
      // This will ensure that only the last event is processed after the delay
      transformer: restartable(),
    );
    on<EnterForgotConfirmPasswordString>(
      _enterForgotConfirmPasswordStringHandler,
      // Use the `restartable` transformer to prevent multiple rapid state changes
      // that can occur when the user rapidly toggles the password visibility
      // This will ensure that only the last event is processed after the delay
      transformer: restartable(),
    );
    on<ToggleForgotPasswordVisibility>(_toggleForgotPasswordVisibilityHandler);
    on<ToggleForgotConfirmPasswordVisibility>(_toggleForgotConfirmPasswordVisibilityHandler);
    on<ResendForgotPasswordOtpEvent>(_resendForgotPasswordOtpHandler);
    on<VerifyForgotPasswordOtpEvent>(_verifyForgotPasswordOtpHandler);
  }

  void _submitEmailHandler(SubmitEmail event, Emitter<AuthState> emit) {
    if (!EmailValidator.validate(event.email)) {
      emit(AuthErrorState("Invalid email format"));
      return;
    }
    emit(AuthSuccessState("A reset link has been sent to ${event.email}"));
  }

  Future<void> _enterForgotPasswordStringHandler(EnterForgotPasswordString event, Emitter<AuthState> emit) async {
    // Adding a delay to prevent overloading the UI with state changes
    // This is a simple way to debounce the event and prevent rapid state changes
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      AuthInitialState(
        forgotPasswordState: (state.forgotPasswordState ?? ForgotPasswordState()).copyWith(
          newPasswordState: NewPasswordState(
            password: event.passwordString,
            confirmPassword: state.forgotPasswordState?.newPasswordState?.confirmPassword ?? '',
            hidePassword: state.forgotPasswordState?.newPasswordState?.hidePassword ?? true,
            hideConfirmPassword: state.forgotPasswordState?.newPasswordState?.hideConfirmPassword ?? true,
          ),
        ),
      ),
    );
  }

  Future<void> _enterForgotConfirmPasswordStringHandler(EnterForgotConfirmPasswordString event, Emitter<AuthState> emit) async {
    // Adding a delay to prevent overloading the UI with state changes
    // This is a simple way to debounce the event and prevent rapid state changes
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      AuthInitialState(
        forgotPasswordState: (state.forgotPasswordState ?? ForgotPasswordState()).copyWith(
          newPasswordState: NewPasswordState(
            password: state.forgotPasswordState?.newPasswordState?.password ?? '',
            confirmPassword: event.passwordString,
            hidePassword: state.forgotPasswordState?.newPasswordState?.hidePassword ?? true,
            hideConfirmPassword: state.forgotPasswordState?.newPasswordState?.hideConfirmPassword ?? true,
          ),
        ),
      ),
    );
  }

  void _toggleForgotPasswordVisibilityHandler(ToggleForgotPasswordVisibility event, Emitter<AuthState> emit) {
    emit(
      AuthInitialState(
        forgotPasswordState: (state.forgotPasswordState ?? ForgotPasswordState()).copyWith(
          newPasswordState: NewPasswordState(
            password: state.forgotPasswordState?.newPasswordState?.password ?? '',
            confirmPassword: state.forgotPasswordState?.newPasswordState?.confirmPassword ?? '',
            hidePassword: !(state.forgotPasswordState?.newPasswordState?.hidePassword ?? false),
            hideConfirmPassword: state.forgotPasswordState?.newPasswordState?.hideConfirmPassword ?? true,
          ),
        ),
      ),
    );
  }

  void _toggleForgotConfirmPasswordVisibilityHandler(ToggleForgotConfirmPasswordVisibility event, Emitter<AuthState> emit) {
    emit(
      AuthInitialState(
        forgotPasswordState: (state.forgotPasswordState ?? ForgotPasswordState()).copyWith(
          newPasswordState: NewPasswordState(
            password: state.forgotPasswordState?.newPasswordState?.password ?? '',
            confirmPassword: state.forgotPasswordState?.newPasswordState?.confirmPassword ?? '',
            hidePassword: state.forgotPasswordState?.newPasswordState?.hidePassword ?? true,
            hideConfirmPassword: !(state.forgotPasswordState?.newPasswordState?.hideConfirmPassword ?? false),
          ),
        ),
      ),
    );
  }

  void _resendForgotPasswordOtpHandler(ResendForgotPasswordOtpEvent event, Emitter<AuthState> emit) {}

  void _verifyForgotPasswordOtpHandler(VerifyForgotPasswordOtpEvent event, Emitter<AuthState> emit) {
    emit(AuthErrorState(AppTexts.invalidOTPCode));
    emit(AuthInitialState());
  }
}

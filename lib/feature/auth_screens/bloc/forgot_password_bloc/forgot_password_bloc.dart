import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:defifundr_mobile/core/constants/app_texts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/services/snackbar_service.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final _snackbarService = SnackbarService();

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SubmitEmail>(_submitEmailHandler);

    on<EnterPasswordString>(
      _enterPasswordStringHandler,
      // Use the `restartable` transformer to prevent multiple rapid state changes
      // that can occur when the user rapidly toggles the password visibility
      // This will ensure that only the last event is processed after the delay
      transformer: restartable(),
    );
    on<EnterConfirmPasswordString>(
      _enterConfirmPasswordStringHandler,
      // Use the `restartable` transformer to prevent multiple rapid state changes
      // that can occur when the user rapidly toggles the password visibility
      // This will ensure that only the last event is processed after the delay
      transformer: restartable(),
    );
    on<TogglePasswordVisibility>(_togglePasswordVisibilityHandler);
    on<ToggleConfirmPasswordVisibility>(_toggleConfirmPasswordVisibilityHandler);
    on<ResendOtpEvent>(_resendOtpHandler);
    on<VerifyOtp>(_verifyOtpHandler);
  }

  void _submitEmailHandler(SubmitEmail event, Emitter<ForgotPasswordState> emit) {
    if (!EmailValidator.validate(event.email)) {
      emit(ForgotPasswordError("Invalid email format"));
      return;
    }
    emit(ForgotPasswordSuccess("A reset link has been sent to ${event.email}"));
  }

  Future<void> _enterPasswordStringHandler(EnterPasswordString event, Emitter<ForgotPasswordState> emit) async {
    // Adding a delay to prevent overloading the UI with state changes
    // This is a simple way to debounce the event and prevent rapid state changes
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      ForgotPasswordInitial(
        newPasswordState:
            (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(password: event.passwordString),
      ),
    );
  }

  Future<void> _enterConfirmPasswordStringHandler(EnterConfirmPasswordString event, Emitter<ForgotPasswordState> emit) async {
    // Adding a delay to prevent overloading the UI with state changes
    // This is a simple way to debounce the event and prevent rapid state changes
    await Future.delayed(Duration(milliseconds: 300));
    emit(
      ForgotPasswordInitial(
        newPasswordState:
            (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(confirmPassword: event.passwordString),
      ),
    );
  }

  void _togglePasswordVisibilityHandler(TogglePasswordVisibility event, Emitter<ForgotPasswordState> emit) {
    emit(
      ForgotPasswordInitial(
        newPasswordState: (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(
          showPassword: !(state.newPasswordState?.hidePassword ?? false),
        ),
      ),
    );
  }

  void _toggleConfirmPasswordVisibilityHandler(ToggleConfirmPasswordVisibility event, Emitter<ForgotPasswordState> emit) {
    emit(
      ForgotPasswordInitial(
        newPasswordState: (state.newPasswordState ?? NewPasswordState(password: state.newPasswordState?.password ?? '')).copyWith(
          showConfirmPassword: !(state.newPasswordState?.hideConfirmPassword ?? false),
        ),
      ),
    );
  }

  void _resendOtpHandler(ResendOtpEvent event, Emitter<ForgotPasswordState> emit) {
    _snackbarService.showSuccessSnackbar(title: AppTexts.otpCodeResent, message: AppTexts.otpCodeResentDesc);
  }

  void _verifyOtpHandler(VerifyOtp event, Emitter<ForgotPasswordState> emit) {
    _snackbarService.showErrorSnackbar(title: AppTexts.invalidOTPCode, message: AppTexts.invalidOTPCodeDesc);
    emit(ForgotPasswordError(AppTexts.invalidOTPCode));
  }
}

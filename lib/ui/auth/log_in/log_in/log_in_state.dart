class LogInState {
  bool? shouldRememberPassword = false;

  String? email = "";
  String? password = "";
  String? errorMessage = "";

  String? emailValidationErrorText = "";

  LogInState(
    this.shouldRememberPassword,
    this.email,
    this.password,
    this.errorMessage,
    this.emailValidationErrorText,
  );

  bool isEmailValid() => emailValidationErrorText?.isNotEmpty ?? false;

  LogInState init() {
    return LogInState(false, "", "", "", "");
  }
}

LogInState cloneLogInState(LogInState state) {
  return LogInState(
    state.shouldRememberPassword,
    state.email,
    state.password,
    state.errorMessage,
    state.emailValidationErrorText,
  );
}

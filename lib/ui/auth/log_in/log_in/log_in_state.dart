class LogInState {
  bool? shouldRememberPassword = false;

  String? email = "";
  String? password = "";
  Status status = Status.notAuthenticated;

  String? error = "";

  LogInState(
    this.shouldRememberPassword,
    this.email,
    this.password,
    this.error,
    this.status,
  );

  bool isEmailValid() => error?.isNotEmpty ?? false;

  LogInState init() {
    return LogInState(false, "", "", "", Status.notAuthenticated);
  }
}

LogInState cloneLogInState(LogInState state) {
  return LogInState(
    state.shouldRememberPassword,
    state.email,
    state.password,
    state.error,
    state.status,
  );
}

enum Status {
  authenticated,
  notAuthenticated,
  needsSignUp,
  needResetPassword,
}

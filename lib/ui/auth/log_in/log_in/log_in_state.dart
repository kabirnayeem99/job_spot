import 'package:job_spot/domain/entity/user_message.dart';

class LogInState {
  bool? shouldRememberPassword = false;

  String? email = "";
  String? password = "";
  Status status = Status.notAuthenticated;

  var userMessages = <UserMessage>[];

  LogInState(
    this.shouldRememberPassword,
    this.email,
    this.password,
    this.userMessages,
    this.status,
  );

  LogInState init() {
    return LogInState(
        false, "", "", List.empty(growable: true), Status.notAuthenticated);
  }
}

LogInState cloneLogInState(LogInState state) {
  return LogInState(
    state.shouldRememberPassword,
    state.email,
    state.password,
    state.userMessages,
    state.status,
  );
}

enum Status {
  authenticated,
  notAuthenticated,
  needsSignUp,
  needResetPassword,
}

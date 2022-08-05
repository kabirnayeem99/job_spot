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

  @override
  String toString() {
    return 'LogInState{shouldRememberPassword: $shouldRememberPassword, email: '
        '$email, password: $password, status: $status, userMessages: '
        '$userMessages}';
  }

  LogInState init() {
    return LogInState(
        false, "", "", List.empty(growable: true), Status.notAuthenticated);
  }
}

enum Status {
  authenticated,
  notAuthenticated,
  needsSignUp,
  needResetPassword,
}

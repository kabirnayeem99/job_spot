import 'package:job_spot/domain/entity/user_message.dart';

class LogInState {
  bool? shouldRememberPassword = false;

  String? email = "";
  String? password = "";
  Status status = Status.notAuthenticated;
  bool? isLoading = false;

  var userMessages = <UserMessage>[];

  LogInState(this.shouldRememberPassword,
      this.email,
      this.password,
      this.userMessages,
      this.status,
      this.isLoading,);

  @override
  String toString() {
    return 'LogInState{shouldRememberPassword: $shouldRememberPassword, email: '
        '$email, password: $password, status: $status, userMessages: '
        '$userMessages}';
  }

  static LogInState init() {
    return LogInState(false, "", "", [], Status.notAuthenticated, false);
  }
}

enum Status {
  authenticated,
  notAuthenticated,
  needsSignUp,
  needResetPassword,
}

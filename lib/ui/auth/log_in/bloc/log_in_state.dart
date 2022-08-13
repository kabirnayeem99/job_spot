import 'package:equatable/equatable.dart';

import '../../../../domain/entity/user_message.dart';

class LogInState extends Equatable {
  bool? shouldRememberPassword = false;

  String? email = "";
  String? password = "";
  Status status = Status.notAuthenticated;
  bool? isLoading = false;

  var userMessages = <UserMessage>[];

  LogInState(
    this.shouldRememberPassword,
    this.email,
    this.password,
    this.userMessages,
    this.status,
    this.isLoading,
  );

  @override
  String toString() {
    return 'LogInState{shouldRememberPassword: $shouldRememberPassword, email: '
        '$email, password: $password, status: $status, userMessages: '
        '$userMessages}';
  }

  static LogInState init() {
    return LogInState(false, "", "", [], Status.notAuthenticated, false);
  }

  LogInState copyWith({
    bool? shouldRememberPassword,
    String? email,
    String? password,
    List<UserMessage>? userMessages,
    Status? status,
    bool? isLoading,
  }) {
    return LogInState(
      shouldRememberPassword ?? this.shouldRememberPassword,
      email ?? this.email,
      password ?? this.password,
      userMessages ?? this.userMessages,
      status ?? this.status,
      isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        shouldRememberPassword,
        email,
        password,
        userMessages,
        status,
        isLoading,
      ];
}

enum Status {
  authenticated,
  notAuthenticated,
  needsSignUp,
  needResetPassword,
}

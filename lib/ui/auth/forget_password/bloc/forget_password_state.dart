import 'package:equatable/equatable.dart';

import '../../../../domain/entity/user_message.dart';

class ForgetPasswordState extends Equatable {
  bool? isLoading = false;
  String? email = "";
  ForgetPasswordStatus? status;
  var userMessages = <UserMessage>[];

  ForgetPasswordState(
    this.isLoading,
    this.email,
    this.status,
    this.userMessages,
  );

  static ForgetPasswordState init() {
    return ForgetPasswordState(
      false,
      "",
      ForgetPasswordStatus.needForgotPasswordMail,
      const [],
    );
  }

  ForgetPasswordState copyWith({
    bool? isLoading,
    String? email,
    ForgetPasswordStatus? status,
    List<UserMessage>? userMessages,
  }) {
    return ForgetPasswordState(
      isLoading ?? this.isLoading,
      email ?? this.email,
      status ?? this.status,
      userMessages ?? this.userMessages,
    );
  }

  @override
  List<Object?> get props => [isLoading, email, status, userMessages];
}

enum ForgetPasswordStatus {
  sentForgotPasswordRecoveryMail,
  needForgotPasswordMail,
}

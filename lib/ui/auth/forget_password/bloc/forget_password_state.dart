import '../../../../domain/entity/user_message.dart';

class ForgetPasswordState {
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
      ForgetPasswordStatus.launchForgetPasswordScreen,
      [],
    );
  }
}

enum ForgetPasswordStatus {
  launchForgetPasswordScreen,
  navigateBackToSignInScreen,
  navigateToCheckEmailScreen,
}

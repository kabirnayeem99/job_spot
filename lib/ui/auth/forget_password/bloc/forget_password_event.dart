abstract class ForgetPasswordEvent {}

class LoadForgetPasswordScreen extends ForgetPasswordEvent {}

class ResetPasswordEvent extends ForgetPasswordEvent {
  String? emailAddress;

  ResetPasswordEvent({this.emailAddress});
}

class GoBackToSignInScreeEvent extends ForgetPasswordEvent {}

class SaveEmailEvent extends ForgetPasswordEvent {
  final String emailAsTyping;

  SaveEmailEvent({required this.emailAsTyping});
}

class UserMessageShown extends ForgetPasswordEvent {
  final int id;

  UserMessageShown(this.id);
}

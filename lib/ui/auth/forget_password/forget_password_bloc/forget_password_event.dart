abstract class ForgetPasswordEvent {}

class LoadForgetPasswordScreen extends ForgetPasswordEvent {}

class ResetPasswordEvent extends ForgetPasswordEvent {
  String? emailAddress;

  ResetPasswordEvent({this.emailAddress});
}

class SaveEmailEvent extends ForgetPasswordEvent{
  final String emailAsTyping;
  SaveEmailEvent({required this.emailAsTyping});
}

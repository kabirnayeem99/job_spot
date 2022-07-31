abstract class ForgetPasswordEvent {}

class InitialLoadEvent extends ForgetPasswordEvent {}

class ResetPasswordEvent extends ForgetPasswordEvent {
  String? emailAddress;

  ResetPasswordEvent({this.emailAddress});
}

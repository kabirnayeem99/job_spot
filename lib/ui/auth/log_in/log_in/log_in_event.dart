abstract class LogInEvent {}

class LoadLogInScreenEvent extends LogInEvent {}

class ToggleRememberPassword extends LogInEvent {
  ToggleRememberPassword();
}

class CacheEmailEvent extends LogInEvent {
  final String email;

  CacheEmailEvent(this.email);
}

class CachePasswordEvent extends LogInEvent {
  final String password;

  CachePasswordEvent(this.password);
}

class LogInWithEmailAndPassword extends LogInEvent {}

class LogInWithGoogle extends LogInEvent {}

class NeedSignUp extends LogInEvent {}

class NeedForgetPassword extends LogInEvent {}

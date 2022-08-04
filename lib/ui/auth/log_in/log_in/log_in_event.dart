abstract class LogInEvent {}

class LoadLogInScreenEvent extends LogInEvent {}

class ToggleRememberPassword extends LogInEvent {
  final bool shouldRemember;

  ToggleRememberPassword(this.shouldRemember);
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

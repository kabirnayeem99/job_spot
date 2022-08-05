import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'log_in_event.dart';
import 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc()
      : super(LogInState(false, "", "", "", Status.notAuthenticated).init()) {
    on<LoadLogInScreenEvent>(_loadLogInScreen);
    on<ToggleRememberPassword>(_togglePasswordRemember);
    on<CacheEmailEvent>(_cacheEmail);
    on<CachePasswordEvent>(_cachePassword);
    on<LogInWithEmailAndPassword>(_loginWithEmailAndPassword);
    on<LogInWithGoogle>(_logInWithGoogle);
    on<NeedSignUp>(_needSignUp);
    on<NeedForgetPassword>(_needForgetPassword);
  }

  /// _loadLogInScreen() is a function that takes in an event and an emitter, and
  /// emits a state with a status of notAuthenticated
  ///
  /// Args:
  ///   event (LoadLogInScreenEvent): The event that was emitted from the UI.
  ///   emit (Emitter<LogInState>): This is the function that you use to emit a new
  /// state.
  void _loadLogInScreen(LoadLogInScreenEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.notAuthenticated);
    emit(_state);
  }

  /// _togglePasswordRemember is a function that takes in a ToggleRememberPassword
  /// event and an Emitter<LogInState> emit and returns void
  ///
  /// Args:
  ///   event (ToggleRememberPassword): The event that was emitted.
  ///   emit (Emitter<LogInState>): This is the function that you use to emit a new
  /// state.
  void _togglePasswordRemember(
      ToggleRememberPassword event, Emitter<LogInState> emit) {
    final _state = cloneLogInState(state);
    _state.shouldRememberPassword = !(state.shouldRememberPassword ?? false);
    print("should remember -> ${_state.shouldRememberPassword}");
    emit(_state);
  }

  /// _cacheEmail() is a function that takes in an event and an emitter, and emits a
  /// new state with the email from the event
  ///
  /// Args:
  ///   event (CacheEmailEvent): The event that was emitted from the UI.
  ///   emit (Emitter<LogInState>): This is the function that you use to emit a new
  /// state.
  void _cacheEmail(CacheEmailEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState(email: event.email);
    emit(_state);
  }

  /// _cachePassword() is a function that takes in a CachePasswordEvent and an
  /// Emitter<LogInState> and returns nothing
  ///
  /// Args:
  ///   event (CachePasswordEvent): The event that was emitted from the UI.
  ///   emit (Emitter<LogInState>): This is the function that you use to emit a new
  /// state.
  void _cachePassword(CachePasswordEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState(password: event.password);
    emit(_state);
  }

  /// _loginWithEmailAndPassword() is a function that takes in an event and an
  /// emitter, and emits a new state
  ///
  /// Args:
  ///   event (LogInWithEmailAndPassword): The event that was emitted from the UI.
  ///   emit (Emitter<LogInState>): This is the function that you use to emit a new
  /// state.
  void _loginWithEmailAndPassword(
      LogInWithEmailAndPassword event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.notAuthenticated);

    final email = _state.email ?? "";
    final password = _state.password ?? "";

    String error = "";
    if (email.isEmpty) error = error + " " + "Your email is empty.";
    if (password.isEmpty) error = error + " " + "Your password is empty";
    _state.error = error;
    if (kDebugMode) print("Error -> $error\n");

    if (error.isEmpty) {
      final _state = _cloneState(status: Status.authenticated);
      emit(_state);
    } else {
      emit(_state);
    }
  }

  void _logInWithGoogle(LogInWithGoogle event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.authenticated);
    emit(_state);
  }

  /// If any of the arguments are null, use the value from the current state.
  ///
  /// Args:
  ///   shouldRememberPassword (bool): Whether the user wants to remember their
  /// password.
  ///   email (String): The email address the user has entered.
  ///   password (String): The password the user has entered.
  ///   emailValidationErrorText (String): The error text to display if the email is
  /// invalid.
  ///   status (Status): The status of the current state.
  ///
  /// Returns:
  ///   A new instance of the LogInState class.
  LogInState _cloneState({
    bool? shouldRememberPassword,
    String? email,
    String? password,
    String? error,
    Status? status,
  }) {
    return LogInState(
      shouldRememberPassword ?? state.shouldRememberPassword,
      email ?? state.email,
      password ?? state.password,
      error ?? state.error,
      status ?? state.status,
    );
  }

  void _needSignUp(NeedSignUp event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.needsSignUp);
    emit(_state);
  }

  void _needForgetPassword(NeedForgetPassword event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.needResetPassword);
    emit(_state);
  }
}

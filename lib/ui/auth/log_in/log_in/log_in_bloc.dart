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
  }

  void _loadLogInScreen(LoadLogInScreenEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState();
    emit(_state);
  }

  void _togglePasswordRemember(
      ToggleRememberPassword event, Emitter<LogInState> emit) {
    final newState = cloneLogInState(state);
    newState.shouldRememberPassword = event.shouldRemember;
    emit(newState);
  }

  void _cacheEmail(CacheEmailEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState(email: event.email);
    emit(_state);
  }

  void _cachePassword(CachePasswordEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState(password: event.password);
    emit(_state);
  }

  void _loginWithEmailAndPassword(
      LogInWithEmailAndPassword event, Emitter<LogInState> emit) {
    final _state = _cloneState();

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
    }

    emit(_state);
  }

  void _logInWithGoogle(LogInWithGoogle event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.authenticated);
    emit(_state);
  }

  LogInState _cloneState({
    bool? shouldRememberPassword,
    String? email,
    String? password,
    String? emailValidationErrorText,
    Status? status,
  }) {
    return LogInState(
      shouldRememberPassword ?? state.shouldRememberPassword,
      email ?? state.email,
      password ?? state.password,
      emailValidationErrorText ?? state.error,
      status ?? state.status,
    );
  }
}

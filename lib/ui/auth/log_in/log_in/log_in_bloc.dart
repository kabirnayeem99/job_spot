import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'log_in_event.dart';
import 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInState(false, "", "", "", "").init()) {
    on<LoadLogInScreenEvent>(_loadLogInScreen);
    on<ToggleRememberPassword>(_togglePasswordRemember);
    on<CacheEmailEvent>(_cacheEmail);
    on<CachePasswordEvent>(_cachePassword);
    on<LogInWithEmailAndPassword>(_loginWithEmailAndPassword);
  }

  void _loadLogInScreen(LoadLogInScreenEvent event, Emitter<LogInState> emit) {
    emit(cloneLogInState(state));
  }

  void _togglePasswordRemember(
      ToggleRememberPassword event, Emitter<LogInState> emit) {
    final newState = cloneLogInState(state);
    newState.shouldRememberPassword = event.shouldRemember;
    emit(newState);
  }

  void _cacheEmail(CacheEmailEvent event, Emitter<LogInState> emit) {
    final newState = cloneLogInState(state);
    newState.email = event.email;
    emit(state);
  }

  void _cachePassword(CachePasswordEvent event, Emitter<LogInState> emit) {
    final newState = cloneLogInState(state);
    newState.email = event.password;
    emit(state);
  }

  void _loginWithEmailAndPassword(
      LogInWithEmailAndPassword event, Emitter<LogInState> emit) {
    final _state = _cloneState();
    final email = _state.email;
    final password = _state.password;
    _state.emailValidationErrorText = email;
    if (kDebugMode) {
      print(
          "email -> $email, password -> $password, state -> ${_state.emailValidationErrorText}");
    }
    emit(_state);
  }

  LogInState _cloneState({
    bool? shouldRememberPassword,
    String? email,
    String? password,
    String? errorMessage,
    String? emailValidationErrorText,
  }) {
    return LogInState(
      shouldRememberPassword ?? state.shouldRememberPassword,
      email ?? state.email,
      password ?? state.password,
      errorMessage ?? state.errorMessage,
      emailValidationErrorText ?? state.emailValidationErrorText,
    );
  }
}

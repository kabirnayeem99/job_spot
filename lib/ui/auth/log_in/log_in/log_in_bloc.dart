import 'package:bloc/bloc.dart';

import '../../../../domain/entity/user_message.dart';
import 'log_in_event.dart';
import 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc()
      : super(LogInState(false, "", "", List.empty(growable: true),
                Status.notAuthenticated)
            .init()) {
    on<LoadLogInScreenEvent>(_loadLogInScreen);
    on<ToggleRememberPassword>(_togglePasswordRemember);
    on<CacheEmailEvent>(_cacheEmail);
    on<CachePasswordEvent>(_cachePassword);
    on<LogInWithEmailAndPassword>(_loginWithEmailAndPassword);
    on<LogInWithGoogle>(_logInWithGoogle);
    on<NeedSignUp>(_needSignUp);
    on<NeedForgetPassword>(_needForgetPassword);
    on<UserMessageShown>(_onUserMessageShown);
  }

  void _loadLogInScreen(LoadLogInScreenEvent event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.notAuthenticated);
    emit(_state);
  }

  void _togglePasswordRemember(
      ToggleRememberPassword event, Emitter<LogInState> emit) {
    final _state = cloneLogInState(state);
    _state.shouldRememberPassword = !(state.shouldRememberPassword ?? false);
    print("should remember -> ${_state.shouldRememberPassword}");
    emit(_state);
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
    final _state = _cloneState(status: Status.notAuthenticated);

    final email = _state.email ?? "";
    final password = _state.password ?? "";

    String error = "";
    if (email.isEmpty) error = error + " " + "Your email is empty.";
    if (password.isEmpty) error = error + " " + "Your password is empty";

    _addErrorMessage(error, emit);

    if (error.isEmpty) {
      final _state = _cloneState(status: Status.authenticated);
      emit(_state);
    } else {
      emit(_state);
    }
  }

  void _addErrorMessage(String message, Emitter<LogInState> emit) {
    if (message.isEmpty) return;
    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.add(UserMessage(DateTime.now().second, message));
    final _state = _cloneState(userMessages: messages);
    emit(_state);
  }

  void _onUserMessageShown(UserMessageShown event, Emitter<LogInState> emit) {
    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.removeWhere((element) => element.id == event.id);
    final _state = _cloneState(userMessages: messages);
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
    List<UserMessage>? userMessages,
    Status? status,
  }) {
    return LogInState(
      shouldRememberPassword ?? state.shouldRememberPassword,
      email ?? state.email,
      password ?? state.password,
      userMessages ?? state.userMessages,
      status ?? Status.notAuthenticated,
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

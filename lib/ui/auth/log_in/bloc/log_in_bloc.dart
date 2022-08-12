import 'package:bloc/bloc.dart';

import '../../../../common/utility/utility.dart';
import '../../../../domain/entity/user_message.dart';
import '../../../../domain/use_case/auth/log_in/check_if_authenticated.dart';
import '../../../../domain/use_case/auth/log_in/log_in_with_email_and_password_use_case.dart';
import '../../../../domain/use_case/auth/log_in/log_in_with_google_use_case.dart';
import 'log_in_event.dart';
import 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc() : super(LogInState.init()) {
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

  void _loadLogInScreen(
    LoadLogInScreenEvent event,
    Emitter<LogInState> emit,
  ) async {
    emit(_cloneState(status: Status.notAuthenticated, isLoading: true));

    final status = await CheckIfAuthenticated.isAuthenticated()
        ? Status.authenticated
        : Status.notAuthenticated;

    logger.d(state);
    logger.d("is authenticated -> $status");

    emit(
      _cloneState(status: status, isLoading: false),
    );
  }

  void _togglePasswordRemember(
      ToggleRememberPassword event, Emitter<LogInState> emit) {
    final _state = _cloneState();
    _state.shouldRememberPassword = !(state.shouldRememberPassword ?? false);
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
      LogInWithEmailAndPassword event, Emitter<LogInState> emit) async {
    emit(_cloneState(status: Status.notAuthenticated, isLoading: true));

    final _state = _cloneState();

    final useCase =
        await LogInWithEmailAndPasswordUseCase.logInWithEmailAndPassword(
            _state.email, _state.password);

    useCase.fold(
      (error) {
        _addErrorMessage(error, emit);
      },
      (success) {
        final _state =
            _cloneState(status: Status.authenticated, isLoading: false);
        emit(_state);
      },
    );
  }

  Future<void> _logInWithGoogle(
      LogInWithGoogle event, Emitter<LogInState> emit) async {
    var _state = _cloneState(status: Status.notAuthenticated, isLoading: true);
    emit(_state);
    final useCase = await LogInWithGoogleUseCase.logInWithGoogle();
    useCase.fold(
      (error) {
        _addErrorMessage(error, emit);
      },
      (success) {
        final _state = _cloneState(
          status: Status.authenticated,
          isLoading: false,
        );
        emit(_state);
      },
    );
    emit(_state);
  }

  void _addErrorMessage(String message, Emitter<LogInState> emit) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    final _state = _cloneState(userMessages: messages, isLoading: false);
    emit(_state);
  }

  void _onUserMessageShown(UserMessageShown event, Emitter<LogInState> emit) {
    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.removeWhere((element) => element.id == event.id);

    final _state = _cloneState(userMessages: messages);
    emit(_state);
  }



  void _needSignUp(NeedSignUp event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.needsSignUp);
    emit(_state);
  }

  void _needForgetPassword(NeedForgetPassword event, Emitter<LogInState> emit) {
    final _state = _cloneState(status: Status.needResetPassword);
    emit(_state);
  }

  LogInState _cloneState({
    bool? shouldRememberPassword,
    String? email,
    String? password,
    List<UserMessage>? userMessages,
    Status? status,
    bool? isLoading,
  }) {
    return LogInState(
      shouldRememberPassword ?? state.shouldRememberPassword,
      email ?? state.email,
      password ?? state.password,
      userMessages ?? state.userMessages,
      status ?? Status.notAuthenticated,
      isLoading ?? state.isLoading,
    );
  }
}

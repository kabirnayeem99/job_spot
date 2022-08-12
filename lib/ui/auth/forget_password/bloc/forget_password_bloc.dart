import 'package:bloc/bloc.dart';
import 'package:job_spot/domain/entity/user_message.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState.init()) {
    on<LoadForgetPasswordScreen>(_loadForgetPasswordScreen);
    on<ResetPasswordEvent>(_resetPassword);
    on<SaveEmailEvent>(_cacheEmail);
    on<GoBackToSignInScreeEvent>(_goBackToSignInScreen);
    on<UserMessageShown>(_onUserMessageShown);
  }

  Future<void> _cacheEmail(
    SaveEmailEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    final _state = _cloneState(email: event.emailAsTyping);
    emit(_state);
  }

  Future<void> _goBackToSignInScreen(
    GoBackToSignInScreeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    final _state =
        _cloneState(status: ForgetPasswordStatus.navigateBackToSignInScreen);
    emit(_state);
  }

  Future<void> _loadForgetPasswordScreen(
    LoadForgetPasswordScreen event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(_cloneState(isLoading: true));
  }

  Future<void> _resetPassword(
    ResetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(_cloneState(isLoading: false));
    Future.delayed(const Duration(seconds: 2));
    _addErrorMessage("Sent user message to your email ${state.email}", emit);
    Future.delayed(const Duration(seconds: 2));
    emit(_cloneState(status: ForgetPasswordStatus.navigateToCheckEmailScreen));
  }

  void _addErrorMessage(
    String message,
    Emitter<ForgetPasswordState> emit,
  ) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    final _state = _cloneState(userMessages: messages);
    emit(_state);
  }

  void _onUserMessageShown(
    UserMessageShown event,
    Emitter<ForgetPasswordState> emit,
  ) {
    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.removeWhere((element) => element.id == event.id);

    final _state = _cloneState(userMessages: messages);
    emit(_state);
  }

  ForgetPasswordState _cloneState({
    bool? isLoading,
    String? email,
    ForgetPasswordStatus? status,
    List<UserMessage>? userMessages,
  }) {
    return ForgetPasswordState(
      isLoading ?? state.isLoading,
      email ?? state.email,
      status ?? ForgetPasswordStatus.launchForgetPasswordScreen,
      userMessages ?? <UserMessage>[],
    );
  }
}

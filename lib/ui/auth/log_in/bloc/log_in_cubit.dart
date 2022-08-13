import 'package:bloc/bloc.dart';

import '../../../../common/utility/utility.dart';
import '../../../../domain/entity/user_message.dart';
import '../../../../domain/use_case/auth/log_in/check_if_authenticated.dart';
import '../../../../domain/use_case/auth/log_in/log_in_with_email_and_password_use_case.dart';
import '../../../../domain/use_case/auth/log_in/log_in_with_google_use_case.dart';
import 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInState.init());

  Future<void> loadLogInScreen() async {
    emit(state.copyWith(status: Status.notAuthenticated, isLoading: true));

    final status = await CheckIfAuthenticated.isAuthenticated()
        ? Status.authenticated
        : Status.notAuthenticated;

    logger.d(state);
    logger.d("is authenticated -> $status");

    emit(state.copyWith(status: status, isLoading: false));
  }

  Future<void> togglePasswordRemember(bool? isToggled) async {
    emit(state.copyWith(shouldRememberPassword: isToggled ?? false));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> loginWithEmailAndPassword() async {
    emit(state.copyWith(status: Status.notAuthenticated, isLoading: true));

    final useCase =
        await LogInWithEmailAndPasswordUseCase.logInWithEmailAndPassword(
            state.email, state.password);

    useCase.fold(
      (error) {
        _addUserMessage(error);
      },
      (success) {
        final _state =
            state.copyWith(status: Status.authenticated, isLoading: false);
        emit(_state);
        _addUserMessage("You are successfully logged in with ${state.email}.");
      },
    );
  }

  Future<void> logInWithGoogle() async {
    var _state =
        state.copyWith(status: Status.notAuthenticated, isLoading: true);
    emit(_state);
    final useCase = await LogInWithGoogleUseCase.logInWithGoogle();
    useCase.fold(
      (error) {
        _addUserMessage(error);
      },
      (success) {
        final _state = state.copyWith(
          status: Status.authenticated,
          isLoading: false,
        );
        emit(_state);
      },
    );
    emit(_state);
  }

  void _addUserMessage(String message) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    final _state = state.copyWith(userMessages: messages, isLoading: false);
    emit(_state);
  }

  void userMessageShown(int id) {
    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.removeWhere((element) => element.id == id);

    final _state = state.copyWith(userMessages: messages);
    emit(_state);
  }
}

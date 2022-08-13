import 'package:bloc/bloc.dart';

import '../../../../domain/entity/user_message.dart';
import '../../../../domain/use_case/auth/forget_password/send_recovery_email_use_case.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordState.init());

  Future<void> emailChanged(String? email) async {
    final _state = state.copyWith(email: email);
    emit(_state);
  }

  Future<void> resetPassword() async {
    emit(state.copyWith(isLoading: true));
    final useCase =
        await SendRecoveryEmailUseCase.sendRecoveryEmail(state.email);
    useCase.fold(
      (error) {
        _addUserMessage(error);
      },
      (success) {
        emit(state.copyWith(
          status: ForgetPasswordStatus.sentForgotPasswordRecoveryMail,
          isLoading: false,
        ));
        _addUserMessage("Successfully sent email to ${state.email}.");
      },
    );
  }

  void _addUserMessage(String message) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages, growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    final _state = state.copyWith(userMessages: messages);
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

import 'package:bloc/bloc.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  String? email;

  ForgetPasswordBloc() : super(ForgetPasswordState().init()) {
    on<LoadForgetPasswordScreen>(_loadForgetPasswordScreen);
    on<ResetPasswordEvent>(_resetPassword);
    on<SaveEmailEvent>(_cacheEmail);
  }

  void _cacheEmail(
      SaveEmailEvent event, Emitter<ForgetPasswordState> emit) async {
    email = event.emailAsTyping;
  }

  void _loadForgetPasswordScreen(
      LoadForgetPasswordScreen event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordState(isLoading: true));
  }

  void _resetPassword(
      ResetPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordState(isLoading: true));
  }
}

import 'package:bloc/bloc.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState().init()) {
    on<InitialLoadEvent>(_init);
    on<ResetPasswordEvent>(_restPassword);
  }

  void _init(InitialLoadEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordState(isLoading: true));
  }

  void _restPassword(
      ResetPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetPasswordState(isLoading: true));
  }
}

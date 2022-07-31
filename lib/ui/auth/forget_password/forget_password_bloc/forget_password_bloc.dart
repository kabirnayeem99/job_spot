import 'package:bloc/bloc.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(state.clone());
  }
}

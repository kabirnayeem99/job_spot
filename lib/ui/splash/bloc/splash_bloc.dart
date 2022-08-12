import 'package:bloc/bloc.dart';
import 'package:job_spot/domain/use_case/auth/log_in/check_if_authenticated.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.init()) {
    on<CheckAuthenticationSplashEvent>(_onCheckAuthentication);
  }

  Future<void> _onCheckAuthentication(
    CheckAuthenticationSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    final isAuthenticated = await CheckIfAuthenticated.isAuthenticated();
    emit(SplashState(isAuthenticated));
  }
}

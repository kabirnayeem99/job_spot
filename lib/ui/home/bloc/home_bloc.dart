import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(LoadingHomeState()) {
    on<HomeEvent>(_onLoadHomeScreen);
  }

  Future<void> _onLoadHomeScreen(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {

  }
}

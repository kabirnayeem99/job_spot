import 'package:bloc/bloc.dart';
import 'package:job_spot/domain/use_case/home/fetch_offers_use_case.dart';
import 'package:job_spot/domain/use_case/home/fetch_user_data_use_case.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/offer.dart';
import '../../../domain/entity/user_message.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<LoadHomeScreenDataEvent>(_onLoadHomeScreen);
    on<UserMessageShown>(_onUserMessageShown);
  }

  Future<void> _onLoadHomeScreen(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(_cloneState(isLoading: true));

    final _state = _cloneState(isLoading: false);

    final fetchUserDataUseCase = await FetchUserDataUseCase.fetchUserData();
    fetchUserDataUseCase.fold(
      (error) => _addErrorMessage(error, emit),
      (profile) => {
        _state.fullUserName = profile.fullName,
        _state.userProfilePictureUrl = profile.profileImageUrl,
      },
    );

    final fetchOffersUseCase = await FetchOffersUseCase.fetchOffers();
    fetchOffersUseCase.fold(
      (error) => _addErrorMessage(error, emit),
      (offers) => {_state.offers = offers},
    );

    emit(_state);
  }

  void _addErrorMessage(String message, Emitter<HomeState> emit) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages!, growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    final _state = _cloneState(userMessages: messages, isLoading: false);
    emit(_state);
  }

  void _onUserMessageShown(UserMessageShown event, Emitter<HomeState> emit) {
    final currentMessages = state.userMessages;
    final messages = List<UserMessage>.from(currentMessages!, growable: true);
    messages.removeWhere((element) => element.id == event.id);

    final _state = _cloneState(userMessages: messages);
    emit(_state);
  }

  HomeState _cloneState({
    List<UserMessage>? userMessages,
    String? fullUserName,
    String? userProfilePictureUrl,
    bool? isLoading,
  }) {
    return HomeState(
      userMessages: userMessages ?? state.userMessages,
      fullUserName: fullUserName ?? state.fullUserName,
      userProfilePictureUrl:
          userProfilePictureUrl ?? state.userProfilePictureUrl,
      isLoading: isLoading ?? state.isLoading,
    );
  }
}

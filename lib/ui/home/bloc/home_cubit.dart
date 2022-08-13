import 'package:bloc/bloc.dart';
import 'package:job_spot/domain/use_case/home/fetch_recent_job_list_use_case.dart';

import '../../../domain/entity/user_message.dart';
import '../../../domain/use_case/home/fetch_offers_use_case.dart';
import '../../../domain/use_case/home/fetch_user_data_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    loadHomeScreenData();
  }

  Future<void> loadHomeScreenData() async {
    emit(state.copyWith(isLoading: true));

    final _state = state.copyWith(isLoading: false);

    final fetchUserDataUseCase = await FetchUserDataUseCase.fetchUserData();
    fetchUserDataUseCase.fold(
      (error) => _addUserMessage(error),
      (profile) => {
        _state.fullUserName = profile.fullName,
        _state.userProfilePictureUrl = profile.profileImageUrl,
      },
    );

    final fetchOffersUseCase = await FetchOffersUseCase.fetchOffers();
    fetchOffersUseCase.fold(
      (error) => _addUserMessage(error),
      (offers) {
        _state.offers = offers;
      },
    );

    final fetchRecentJobListUseCase =
        await FetchRecentJobListUseCase.fetchRecentJobList();
    fetchRecentJobListUseCase.fold(
      (error) => _addUserMessage(error),
      (recentJobs) => {
        _state.recentJobs = recentJobs,
      },
    );

    emit(_state);
  }

  void _addUserMessage(String message) {
    if (message.isEmpty) return;

    final currentMessages = state.userMessages;
    final messages =
        List<UserMessage>.from(currentMessages ?? [], growable: true);
    messages.add(UserMessage(DateTime.now().second, message));

    final _state = state.copyWith(userMessages: messages);
    emit(_state);
  }

  void userMessageShown(int id) {
    final currentMessages = state.userMessages;
    final messages =
        List<UserMessage>.from(currentMessages ?? [], growable: true);
    messages.removeWhere((element) => element.id == id);

    final _state = state.copyWith(userMessages: messages);
    emit(_state);
  }
}

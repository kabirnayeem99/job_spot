part of 'home_bloc.dart';

class HomeState {
  List<UserMessage>? userMessages;
  String? fullUserName;
  String? userProfilePictureUrl;
  bool? isLoading;
  List<Offer>? offers;

  HomeState({
    List<UserMessage>? userMessages,
    String? fullUserName,
    String? userProfilePictureUrl,
    bool? isLoading,
    List<Offer>? offers,
  }) {
    this.userMessages = userMessages ?? List.empty();
    this.fullUserName = fullUserName ?? "";
    this.userProfilePictureUrl = userProfilePictureUrl ?? "";
    this.isLoading = isLoading ?? false;
    this.offers = offers ?? List.empty();
  }
}

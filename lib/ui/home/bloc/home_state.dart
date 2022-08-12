part of 'home_bloc.dart';

class HomeState {
  List<UserMessage>? userMessages;
  String? fullUserName;
  String? userProfilePictureUrl;
  bool? isLoading;

  HomeState({
    List<UserMessage>? userMessages,
    String? fullUserName,
    String? userProfilePictureUrl,
    bool? isLoading,
  }) {
    this.userMessages = userMessages ?? List.empty();
    this.fullUserName = fullUserName ?? "";
    this.userProfilePictureUrl = userProfilePictureUrl ?? "";
    this.isLoading = isLoading ?? false;
  }
}

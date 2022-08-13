import 'package:equatable/equatable.dart';

import '../../../domain/entity/job_preview.dart';
import '../../../domain/entity/offer.dart';
import '../../../domain/entity/user_message.dart';

class HomeState extends Equatable {
  List<UserMessage>? userMessages;
  String? fullUserName;
  String? userProfilePictureUrl;
  bool? isLoading;
  List<Offer>? offers;
  List<JobPreview>? recentJobs;

  HomeState({
    List<UserMessage>? userMessages,
    String? fullUserName,
    String? userProfilePictureUrl,
    bool? isLoading,
    List<Offer>? offers,
    List<JobPreview>? recentJobs,
  }) {
    this.userMessages = userMessages ?? List.empty();
    this.fullUserName = fullUserName ?? "";
    this.userProfilePictureUrl = userProfilePictureUrl ?? "";
    this.isLoading = isLoading ?? true;
    this.offers = offers ?? List.empty();
    this.recentJobs = recentJobs ?? [];
  }

  @override
  List<Object?> get props => [
        userMessages,
        fullUserName,
        userProfilePictureUrl,
        isLoading,
        offers,
        recentJobs,
      ];

  @override
  String toString() {
    return 'HomeState{userMessages: $userMessages, fullUserName: $fullUserName, '
        'userProfilePictureUrl: $userProfilePictureUrl, isLoading: $isLoading, '
        'offers: $offers} recent jobs: $recentJobs';
  }

  HomeState copyWith({
    List<UserMessage>? userMessages,
    String? fullUserName,
    String? userProfilePictureUrl,
    bool? isLoading,
    List<Offer>? offers,
    List<JobPreview>? recentJobs,
  }) {
    return HomeState(
      userMessages: userMessages ?? this.userMessages,
      fullUserName: fullUserName ?? this.fullUserName,
      userProfilePictureUrl:
          userProfilePictureUrl ?? this.userProfilePictureUrl,
      isLoading: isLoading ?? this.isLoading,
      offers: offers ?? this.offers,
      recentJobs: recentJobs ?? this.recentJobs,
    );
  }
}

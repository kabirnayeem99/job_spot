import 'package:job_spot/domain/entity/profile.dart';

class ProfileDto {
  String? username;
  String? firstName;
  String? lastName;
  String? profileImageUrl;
  String? userId;

  ProfileDto({
    String? username,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    String? userId,
  }) {
    this.username = username ?? "";
    this.firstName = firstName ?? "";
    this.lastName = lastName ?? "";
    this.profileImageUrl = profileImageUrl ?? "";
    this.userId = userId ?? "";
  }

  ProfileDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_image_url'] = profileImageUrl;
    return data;
  }

  Profile toProfileEntity() {
    return Profile(
      "$firstName $lastName",
      userId ?? "",
      profileImageUrl ?? "",
      username ?? "",
    );
  }

  @override
  String toString() {
    return 'ProfileDto{username: $username, firstName: $firstName, lastName: $lastName, profileImageUrl: $profileImageUrl, userId: $userId}';
  }
}

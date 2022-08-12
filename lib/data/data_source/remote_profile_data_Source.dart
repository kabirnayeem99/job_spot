import 'package:faker_dart/faker_dart.dart';
import 'package:job_spot/data/dto/profile_dto.dart';

class RemoteProfileDataSource {
  final _faker = Faker.instance;

  Future<ProfileDto> getProfileData(String? userId) async {
    if (userId == null || userId.isEmpty) return ProfileDto();
    final name = _faker.name;
    return ProfileDto(
      username: name.lastName().toLowerCase(),
      firstName: name.firstName(),
      lastName: name.lastName(),
      profileImageUrl: _faker.image.loremPicsum.image(),
    );
  }
}

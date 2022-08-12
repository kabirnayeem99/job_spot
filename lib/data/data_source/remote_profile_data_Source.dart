import 'package:faker_dart/faker_dart.dart';
import 'package:job_spot/data/dto/profile_dto.dart';

import '../../common/utility/utility.dart';

class RemoteProfileDataSource {
  final _faker = Faker.instance;

  Future<ProfileDto> getProfileData(String? userId) async {
    await Future.delayed(const Duration(seconds: 2));
    if (userId == null || userId.isEmpty) return ProfileDto();
    final name = _faker.name;
    final dto = ProfileDto(
      username: name.lastName().toLowerCase(),
      firstName: name.firstName(),
      lastName: name.lastName(),
      profileImageUrl: _faker.image.loremPicsum.image(),
    );
    logger.d(dto);
    return dto;
  }
}

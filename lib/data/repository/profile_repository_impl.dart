import 'package:either_dart/either.dart';
import '../../common/utility/utility.dart';
import '../data_source/remote_profile_data_Source.dart';
import '../../domain/entity/profile.dart';
import '../../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final _profileRemoteDataSource = RemoteProfileDataSource();

  @override
  Future<Either<String, Profile>> getProfileData() async {
    try {
      final profileDto = await _profileRemoteDataSource.getProfileData("abcd");
      logger.d(profileDto);
      final profile = profileDto.toProfileEntity();
      return Right(profile);
    } on Exception catch (e) {
      logger.e(e);
      return const Left("Failed to get user data.");
    }
  }
}

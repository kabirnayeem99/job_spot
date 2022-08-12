import 'package:either_dart/either.dart';
import 'package:job_spot/common/utility/utility.dart';
import 'package:job_spot/data/data_source/remote_profile_data_Source.dart';
import 'package:job_spot/domain/entity/profile.dart';
import 'package:job_spot/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final _profileRemoteDataSource = RemoteProfileDataSource();

  @override
  Future<Either<String, Profile>> getProfileData() async {
    try {
      final profileDto = await _profileRemoteDataSource.getProfileData("");
      final profile = profileDto.toProfileEntity();
      return Right(profile);
    } on Exception catch (e) {
      logger.e(e);
      return const Left("Failed to get user data.");
    }
  }
}

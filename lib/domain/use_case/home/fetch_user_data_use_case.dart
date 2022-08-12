import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/profile_repository_impl.dart';
import 'package:job_spot/domain/entity/profile.dart';
import 'package:job_spot/domain/repository/profile_repository.dart';

class FetchUserDataUseCase {
  static Future<Either<String, Profile>> fetchUserData() async {
    final ProfileRepository _profileRepository = ProfileRepositoryImpl();
    return _profileRepository.getProfileData();
  }
}

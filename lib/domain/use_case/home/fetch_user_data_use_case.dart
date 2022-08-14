import 'package:either_dart/either.dart';
import '../../../data/repository/profile_repository_impl.dart';
import '../../entity/profile.dart';
import '../../repository/profile_repository.dart';

class FetchUserDataUseCase {
  static Future<Either<String, Profile>> fetchUserData() async {
    final ProfileRepository profileRepository = ProfileRepositoryImpl();
    return profileRepository.getProfileData();
  }
}

import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';

import '../../entity/profile.dart';
import '../../repository/profile_repository.dart';

class FetchUserDataUseCase {
  static Future<Either<String, Profile>> fetchUserData() async {
    final repository = GetIt.I.get<ProfileRepository>();
    return repository.getProfileData();
  }
}

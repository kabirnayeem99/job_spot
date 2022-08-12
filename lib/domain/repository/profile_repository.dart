import 'package:either_dart/either.dart';
import 'package:job_spot/domain/entity/profile.dart';

abstract class ProfileRepository {
  Future<Either<String, Profile>> getProfileData();
}

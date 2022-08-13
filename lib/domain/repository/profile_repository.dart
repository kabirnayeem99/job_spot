import 'package:either_dart/either.dart';
import '../entity/profile.dart';

abstract class ProfileRepository {
  Future<Either<String, Profile>> getProfileData();
}

import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isUserAuthenticated() async {
    return Random().nextBool();
  }

  @override
  Future<Either<String, bool>> logInWithGoogle() async {
    final success = Random().nextBool();
    if (success) {
      return Right(success);
    } else {
      return const Left("Your log in was not successful.");
    }
  }

  @override
  Future<Either<String, bool>> logInWithEmailAndPassword(
      String email, String password) async {
    final success = Random().nextBool();
    if (success) {
      return Right(success);
    } else {
      return const Left("Your log in was not successful.");
    }
  }
}

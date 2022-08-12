import 'dart:math';

import 'package:either_dart/either.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isUserAuthenticated() async {
    await Future.delayed(Duration(microseconds: Random().nextInt(1200)));
    return Random().nextBool();
  }

  @override
  Future<Either<String, bool>> logInWithGoogle() async {
    final success = Random().nextBool();
    await Future.delayed(Duration(microseconds: Random().nextInt(1200)));
    if (success) {
      return Right(success);
    } else {
      return const Left("Your log in was not successful.");
    }
  }

  @override
  Future<Either<String, bool>> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final success = Random().nextBool();
    await Future.delayed(Duration(microseconds: Random().nextInt(1200)));
    if (success) {
      return Right(success);
    } else {
      return const Left("Your log in was not successful.");
    }
  }

  @override
  Future<Either<String, bool>> sendRecoveryEmail(String email) async {
    final success = Random().nextBool();
    if (success) {
      return Right(success);
    } else {
      return const Left("We couldn't send a recovery email to your account.");
    }
  }
}

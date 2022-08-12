import 'package:either_dart/either.dart';

abstract class AuthRepository {
  Future<bool> isUserAuthenticated();

  Future<Either<String, bool>> logInWithEmailAndPassword(
      String email, String password);

  Future<Either<String, bool>> logInWithGoogle();

  Future<Either<String, bool>> sendRecoveryEmail(String email);
}

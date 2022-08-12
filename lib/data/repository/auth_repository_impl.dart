import 'package:either_dart/either.dart';
import 'package:job_spot/common/utility/utility.dart';
import 'package:job_spot/data/data_source/remote_auth_data_source.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final authRemoteDataSource = RemoteAuthDataSource();

  @override
  Future<bool> isUserAuthenticated() async {
    return authRemoteDataSource.isUserAuthenticated();
  }

  @override
  Future<Either<String, bool>> logInWithGoogle() async {
    try {
      authRemoteDataSource.logInWithGoogle();
      return const Right(true);
    } catch (e) {
      logger.e(e);
      return const Left("Failed to log in with google.");
    }
  }

  @override
  Future<Either<String, bool>> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      authRemoteDataSource.logInWithEmailAndPassword(email, password);
      return const Right(true);
    } catch (e) {
      logger.e(e);
      return const Left("Email or password is wrong.");
    }
  }

  @override
  Future<Either<String, bool>> sendRecoveryEmail(String email) async {
    try {
      authRemoteDataSource.sendRecoveryEmail(email);
      return const Right(true);
    } catch (e) {
      logger.e(e);
      return const Left("Could not send recovery email.");
    }
  }
}

import 'package:either_dart/either.dart';

import '../../common/utility/utility.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/remote_auth_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final RemoteAuthDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<bool> isUserAuthenticated() async {
    return _authRemoteDataSource.isUserAuthenticated();
  }

  @override
  Future<Either<String, bool>> logInWithGoogle() async {
    try {
      _authRemoteDataSource.logInWithGoogle();
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
      _authRemoteDataSource.logInWithEmailAndPassword(email, password);
      return const Right(true);
    } catch (e) {
      logger.e(e);
      return const Left("Email or password is wrong.");
    }
  }

  @override
  Future<Either<String, bool>> sendRecoveryEmail(String email) async {
    try {
      _authRemoteDataSource.sendRecoveryEmail(email);
      return const Right(true);
    } on Exception catch (e) {
      logger.e(e);
      return const Left("Could not send recovery email.");
    }
  }
}

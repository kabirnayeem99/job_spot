import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/auth_repository_impl.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

import '../../../../common/utility/utility.dart';

class LogInWithEmailAndPasswordUseCase {
  static Future<Either<String, bool>> logInWithEmailAndPassword(
    String? email,
    String? password,
  ) async {
    final AuthRepository repository = AuthRepositoryImpl();

    if (email == null || email.isEmpty) {
      return const Left("Your email field is empty");
    }

    if (password == null || password.isEmpty) {
      return const Left("Your password field is empty.");
    }

    if (!isEmailValid(email)) return const Left("Your email is not valid.");

    if (!isPasswordValid(password)) {
      return const Left("Please choose a more complicated password.");
    }

    return repository.logInWithEmailAndPassword(email, password);
  }
}

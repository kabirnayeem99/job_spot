import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/auth_repository_impl.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

import '../../../../common/utility/validator.dart';

class LogInWithEmailAndPasswordUseCase {
  static Future<Either<String, bool>> logInWithEmailAndPassword(
    String? email,
    String? password,
  ) async {
    final AuthRepository repository = AuthRepositoryImpl();

    final emailValidator = isEmailValid(email);
    final emailValid = emailValidator.isRight;

    final passwordValidator = isPasswordValid(password);
    final passwordValid = passwordValidator.isRight;

    if (emailValid && passwordValid) {
      return await repository.logInWithEmailAndPassword(email!, password!);
    } else {
      return const Left("Something went wrong.");
    }
  }
}

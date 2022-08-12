import 'package:either_dart/either.dart';

import '../../../../common/utility/validator.dart';
import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

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

    if (!emailValid) return emailValidator;
    if (!passwordValid) return passwordValidator;

    if (emailValid && passwordValid) {
      return await repository.logInWithEmailAndPassword(email!, password!);
    } else {
      return const Left("Something went wrong.");
    }
  }
}

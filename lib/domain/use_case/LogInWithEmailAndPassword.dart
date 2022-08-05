import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/auth_repository_impl.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

class LogInWithEmailAndPasswordUseCase {
  final AuthRepository repository = AuthRepositoryImpl();

  Future<Either<String, bool>> logInWithEmailAndPassword(
    String? email,
    String? password,
  ) async {
    if (email == null || email.isEmpty) {
      return const Left("Your email field is empty");
    }
    if (password == null || password.isEmpty) {
      return const Left("Your password field is empty.");
    }

    if (!_isEmailValid(email)) return const Left("Your email is not valid.");
    if (!_isPasswordValid(password)) {
      return const Left("Please choose a more complicated password.");
    }

    return repository.logInWithEmailAndPassword(email, password);
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }
}

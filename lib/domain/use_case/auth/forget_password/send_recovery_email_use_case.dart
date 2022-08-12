import 'package:either_dart/either.dart';

import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class SendRecoveryEmailUseCase {
  final AuthRepository repository = AuthRepositoryImpl();

  Future<Either<String, bool>> sendRecoveryEmail(String? email) async {
    if (email == null || email.isEmpty) {
      return const Left("Your email is empty");
    }
    if (!_isEmailValid(email)) {
      return const Left("Your email is not valid");
    }
    return repository.sendRecoveryEmail(email);
  }

  bool _isEmailValid(String email) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

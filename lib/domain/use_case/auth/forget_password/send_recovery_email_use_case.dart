import 'package:either_dart/either.dart';

import '../../../../common/utility/utility.dart';
import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class SendRecoveryEmailUseCase {
  static Future<Either<String, bool>> sendRecoveryEmail(String? email) async {
    final AuthRepository repository = AuthRepositoryImpl();

    if (email == null || email.isEmpty) {
      return const Left("Your email is empty");
    }
    if (!isEmailValid(email)) {
      return const Left("Your email is not valid");
    }
    return repository.sendRecoveryEmail(email);
  }
}

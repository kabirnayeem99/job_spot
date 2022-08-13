import 'package:either_dart/either.dart';
import '../../../../common/utility/validator.dart';

import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class SendRecoveryEmailUseCase {
  static Future<Either<String, bool>> sendRecoveryEmail(String? email) async {
    final AuthRepository repository = AuthRepositoryImpl();
    return isEmailValid(email).fold(
      (warning) => Left(warning),
      (valid) async => await repository.sendRecoveryEmail(email!),
    );
  }
}

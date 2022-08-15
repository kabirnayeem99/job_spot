import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';

import '../../../../common/utility/validator.dart';
import '../../../repository/auth_repository.dart';

class SendRecoveryEmailUseCase {
  static Future<Either<String, bool>> sendRecoveryEmail(String? email) async {
    final repository = GetIt.I.get<AuthRepository>();
    return isEmailValid(email).fold(
      (warning) => Left(warning),
      (valid) async => await repository.sendRecoveryEmail(email!),
    );
  }
}

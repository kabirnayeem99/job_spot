import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';

import '../../../repository/auth_repository.dart';

class LogInWithGoogleUseCase {
  static Future<Either<String, bool>> logInWithGoogle() async {
    final repository = GetIt.I.get<AuthRepository>();
    return repository.logInWithGoogle();
  }
}

import 'package:either_dart/either.dart';

import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class LogInWithGoogleUseCase {
  static Future<Either<String, bool>> logInWithGoogle() async {
    final AuthRepository repository = AuthRepositoryImpl();
    return repository.logInWithGoogle();
  }
}

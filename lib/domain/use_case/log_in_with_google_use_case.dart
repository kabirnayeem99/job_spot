import 'package:either_dart/either.dart';

import '../../data/repository/auth_repository_impl.dart';
import '../repository/auth_repository.dart';

class LogInWithGoogleUseCase {
  final AuthRepository repository = AuthRepositoryImpl();

  Future<Either<String, bool>> logInWithGoogle() async {
    return repository.logInWithGoogle();
  }
}

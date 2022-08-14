import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class CheckIfAuthenticated {
  static Future<bool> isAuthenticated() async {
    final AuthRepository repo = AuthRepositoryImpl();
    return repo.isUserAuthenticated();
  }
}

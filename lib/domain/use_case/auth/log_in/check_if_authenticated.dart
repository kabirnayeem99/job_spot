import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class CheckIfAuthenticated {
  static Future<bool> isAuthenticated() async {
    final AuthRepository _repo = AuthRepositoryImpl();
    return _repo.isUserAuthenticated();
  }
}

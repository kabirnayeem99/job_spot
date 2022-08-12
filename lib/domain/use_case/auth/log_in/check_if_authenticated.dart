import 'package:job_spot/data/repository/auth_repository_impl.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';

class CheckIfAuthenticated {
  static Future<bool> isAuthenticated() async {
    final AuthRepository _repo = AuthRepositoryImpl();
    return _repo.isUserAuthenticated();
  }
}

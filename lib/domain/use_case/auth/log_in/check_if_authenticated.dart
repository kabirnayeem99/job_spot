import 'package:get_it/get_it.dart';

import '../../../../data/repository/auth_repository_impl.dart';
import '../../../repository/auth_repository.dart';

class CheckIfAuthenticated {
  static Future<bool> isAuthenticated() async {
    final repo = GetIt.I.get<AuthRepository>();
    return repo.isUserAuthenticated();
  }
}

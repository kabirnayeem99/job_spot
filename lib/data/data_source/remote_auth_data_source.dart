import 'dart:math';

class RemoteAuthDataSource {
  Future<bool> isUserAuthenticated() async {
    await Future.delayed(const Duration(microseconds: 2000));
    return Random().nextBool();
  }

  Future<void> logInWithGoogle() async {
    final success = Random().nextBool();
    await Future.delayed(const Duration(seconds: 2));
    if (!success) {
      throw Exception("Your log in was not successful.");
    }
  }

  Future<void> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final success = Random().nextBool();
    await Future.delayed(const Duration(microseconds: 2000));
    if (!success) {
      throw Exception("Your log in was not successful.");
    }
  }

  Future<void> sendRecoveryEmail(String email) async {
    final success = Random().nextBool();
    await Future.delayed(const Duration(microseconds: 2000));
    if (!success) {
      throw Exception("We couldn't send a recovery email to your account.");
    }
  }
}

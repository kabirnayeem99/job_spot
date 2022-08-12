part of 'splash_bloc.dart';

class SplashState {
  final bool? isAuthenticated;

  SplashState(this.isAuthenticated);

  static SplashState init() {
    return SplashState(null);
  }
}

part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final bool? isAuthenticated;

  const SplashState(this.isAuthenticated);

  static SplashState init() {
    return const SplashState(null);
  }

  SplashState copyWith(bool? isAuthenticated) {
    return SplashState(isAuthenticated ?? this.isAuthenticated);
  }

  @override
  List<Object?> get props => [isAuthenticated];
}

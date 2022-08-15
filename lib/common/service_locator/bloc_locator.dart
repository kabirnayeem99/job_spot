import 'package:get_it/get_it.dart';
import '../../ui/auth/forget_password/bloc/forget_password_cubit.dart';
import '../../ui/auth/log_in/bloc/log_in_cubit.dart';
import '../../ui/home/bloc/home_cubit.dart';
import '../../ui/job_description/bloc/job_description_cubit.dart';
import '../../ui/splash/bloc/splash_bloc.dart';

Future<void> initialiseBlocServices() async {
  GetIt.I
    ..registerFactory(() => HomeCubit())
    ..registerFactory(() => LogInCubit())
    ..registerFactory(() => ForgetPasswordCubit())
    ..registerFactory(() => JobDescriptionCubit())
    ..registerFactory(() => SplashBloc());
}

import 'package:get_it/get_it.dart';
import 'package:job_spot/domain/use_case/auth/forget_password/send_recovery_email_use_case.dart';

Future<void> initialiseUseCaseServices() async => GetIt.I
  ..registerFactory<SendRecoveryEmailUseCase>(
    () => SendRecoveryEmailUseCase(),
  );

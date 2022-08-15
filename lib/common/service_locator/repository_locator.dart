import 'package:get_it/get_it.dart';
import 'package:job_spot/data/data_source/remote_auth_data_source.dart';
import 'package:job_spot/data/data_source/remote_job_data_source.dart';
import 'package:job_spot/data/data_source/remote_offer_data_source.dart';
import 'package:job_spot/data/data_source/remote_profile_data_Source.dart';
import 'package:job_spot/data/repository/auth_repository_impl.dart';
import 'package:job_spot/data/repository/job_repository_impl.dart';
import 'package:job_spot/data/repository/profile_repository_impl.dart';
import 'package:job_spot/domain/repository/auth_repository.dart';
import 'package:job_spot/domain/repository/job_repository.dart';
import 'package:job_spot/domain/repository/offer_repository.dart';
import 'package:job_spot/domain/repository/profile_repository.dart';

import '../../data/repository/offer_repository_impl.dart';

Future<void> initialiseRepositoryServices() async {
  GetIt.I
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(GetIt.I<RemoteAuthDataSource>()),
    )
    ..registerLazySingleton<OfferRepository>(
      () => OfferRepositoryImpl(GetIt.I<RemoteOfferDataSource>()),
    )
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(GetIt.I<RemoteProfileDataSource>()),
    )
    ..registerLazySingleton<JobRepository>(
      () => JobRepositoryImpl(GetIt.I<RemoteJobDataSource>()),
    );
}

import 'package:get_it/get_it.dart';
import 'package:job_spot/data/data_source/remote_auth_data_source.dart';
import 'package:job_spot/data/data_source/remote_job_data_source.dart';
import 'package:job_spot/data/data_source/remote_offer_data_source.dart';
import 'package:job_spot/data/data_source/remote_profile_data_Source.dart';

Future<void> initialiseDataSourceServices() async {
  GetIt.I
    ..registerFactory<RemoteJobDataSource>(() => RemoteJobDataSource())
    ..registerFactory<RemoteOfferDataSource>(() => RemoteOfferDataSource())
    ..registerFactory<RemoteProfileDataSource>(() => RemoteProfileDataSource())
    ..registerFactory<RemoteAuthDataSource>(() => RemoteAuthDataSource());
}

import 'package:job_spot/common/service_locator/bloc_locator.dart';
import 'package:job_spot/common/service_locator/data_source_locator.dart';
import 'package:job_spot/common/service_locator/repository_locator.dart';

Future<void> initialiseServices() async {
  await initialiseDataSourceServices();
  await initialiseRepositoryServices();
  await initialiseBlocServices();
}

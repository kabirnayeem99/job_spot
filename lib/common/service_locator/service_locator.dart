import 'bloc_locator.dart';
import 'data_source_locator.dart';
import 'repository_locator.dart';

Future<void> initialiseServices() async {
  await initialiseDataSourceServices();
  await initialiseRepositoryServices();
  await initialiseBlocServices();
}

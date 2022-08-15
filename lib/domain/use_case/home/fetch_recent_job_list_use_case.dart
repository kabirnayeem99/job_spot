import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import 'package:job_spot/domain/repository/job_repository.dart';

import '../../entity/job_preview.dart';

class FetchRecentJobListUseCase {
  static Future<Either<String, List<JobPreview>>> fetchRecentJobList() async {
    final repository = GetIt.I.get<JobRepository>();
    return repository.getRecentJobList();
  }
}

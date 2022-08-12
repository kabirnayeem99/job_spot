import 'package:either_dart/either.dart';

import '../../../data/repository/job_repository_impl.dart';
import '../../entity/job_preview.dart';

class FetchRecentJobListUseCase {
  static Future<Either<String, List<JobPreview>>> fetchRecentJobList() async {
    final _jobRepo = JobRepositoryImpl();
    return _jobRepo.getRecentJobList();
  }
}

import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/job_repository_impl.dart';
import 'package:job_spot/domain/entity/job_preview.dart';

class FetchRecentJobListUseCase {
  static Future<Either<String, List<JobPreview>>> fetchRecentJobList() async {
    final _jobRepo = JobRepositoryImpl();
    return _jobRepo.getRecentJobList();
  }
}

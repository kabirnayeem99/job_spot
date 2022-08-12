import 'package:either_dart/either.dart';
import 'package:job_spot/domain/entity/job_preview.dart';

abstract class JobRepository {
  Future<Either<String, int>> getRemoteJobCount();

  Future<Either<String, int>> getFullTimeJobCount();

  Future<Either<String, int>> getPartTimeJobCount();

  Future<Either<String, List<JobPreview>>> getRecentJobList();
}
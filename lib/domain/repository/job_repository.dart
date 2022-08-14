import 'package:either_dart/either.dart';
import 'package:job_spot/domain/entity/company_description.dart';
import 'package:job_spot/domain/entity/job_description.dart';

import '../entity/job_preview.dart';

abstract class JobRepository {
  Future<Either<String, int>> getRemoteJobCount();

  Future<Either<String, int>> getFullTimeJobCount();

  Future<Either<String, int>> getPartTimeJobCount();

  Future<Either<String, List<JobPreview>>> getRecentJobList();

  Future<Either<String, JobDescription>> getJobDescriptionById(String id);

  Future<Either<String, CompanyDescription>> getCompanyInformationById(
      String id);
}

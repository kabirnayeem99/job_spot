import 'dart:math';

import 'package:either_dart/either.dart';
import '../../domain/entity/company_description.dart';
import '../../domain/entity/job_description.dart';

import '../../common/utility/utility.dart';
import '../../domain/entity/job_preview.dart';
import '../../domain/repository/job_repository.dart';
import '../data_source/remote_job_data_source.dart';
import '../dto/recent_job_list_dto.dart';

class JobRepositoryImpl extends JobRepository {
  final RemoteJobDataSource _remoteJobDataSource;

  JobRepositoryImpl(this._remoteJobDataSource);

  @override
  Future<Either<String, int>> getFullTimeJobCount() async {
    try {
      final count = await _remoteJobDataSource.getFullTimeJobCount();
      return Right(count);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, int>> getRemoteJobCount() async {
    try {
      final count = await _remoteJobDataSource.getRemoteJobCount();
      return Right(count);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, int>> getPartTimeJobCount() async {
    try {
      final count = await _remoteJobDataSource.getPartTimeJobCount();
      return Right(count);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<JobPreview>>> getRecentJobList() async {
    try {
      final RecentJobListDto dto =
          await _remoteJobDataSource.getRecentJobList();
      final recentJobList = dto
          .toJobPreviewList()
          .map((j) => j.copyWith(isSaved: Random().nextBool()))
          .toList();
      return Right(recentJobList);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CompanyDescription>> getCompanyInformationById(
      String id) async {
    try {
      final companyInfo = CompanyDescription.generateMockCompanyDescription();
      logger.d(companyInfo);
      return Right(companyInfo);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, JobDescription>> getJobDescriptionById(
      String id) async {
    try {
      final jobDescription = JobDescription.generateMockJobDescription();
      logger.d(jobDescription);
      return Right(jobDescription);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }
}

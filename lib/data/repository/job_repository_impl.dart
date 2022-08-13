import 'package:either_dart/src/either.dart';
import '../../common/utility/utility.dart';
import '../data_source/remote_job_data_source.dart';
import '../dto/recent_job_list_dto.dart';
import '../../domain/entity/job_preview.dart';
import '../../domain/repository/job_repository.dart';

class JobRepositoryImpl extends JobRepository {
  final _remoteJobDataSource = RemoteJobDataSource();

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
      final recentJobList = dto.toJobPreviewList();
      return Right(recentJobList);
    } on Exception catch (e) {
      logger.e(e);
      return Left(e.toString());
    }
  }
}

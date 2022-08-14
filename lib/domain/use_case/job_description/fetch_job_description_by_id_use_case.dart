import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/job_repository_impl.dart';
import 'package:job_spot/domain/entity/job_description.dart';

class FetchJobDescriptionByIdUseCase {
  final String _id;
  final _repo = JobRepositoryImpl();

  FetchJobDescriptionByIdUseCase(this._id);

  Future<Either<String, JobDescription>> _fetchJobDescription() async {
    if (_id.isEmpty) return const Left("Could not load the job description");
    return _repo.getJobDescriptionById(_id);
  }

  static Future<Either<String, JobDescription>> invoke(String id) async {
    return FetchJobDescriptionByIdUseCase(id)._fetchJobDescription();
  }
}

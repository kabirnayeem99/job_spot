import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import '../../entity/job_description.dart';

import '../../repository/job_repository.dart';

class FetchJobDescriptionByIdUseCase {
  final String _id;
  final _repo = GetIt.I.get<JobRepository>();

  FetchJobDescriptionByIdUseCase(this._id);

  Future<Either<String, JobDescription>> _fetchJobDescription() async {
    if (_id.isEmpty) return const Left("Could not load the job description");
    return _repo.getJobDescriptionById(_id);
  }

  static Future<Either<String, JobDescription>> invoke(String id) async {
    return FetchJobDescriptionByIdUseCase(id)._fetchJobDescription();
  }
}

import 'package:either_dart/either.dart';
import 'package:get_it/get_it.dart';
import '../../entity/company_description.dart';
import '../../repository/job_repository.dart';

class FetchCompanyInformationByIdUseCase {
  final _repo = GetIt.I.get<JobRepository>();
  final String id;

  FetchCompanyInformationByIdUseCase(this.id);

  Future<Either<String, CompanyDescription>> _fetchCompanyInformation(
      String id) async {
    if (id.isEmpty) return const Left("Failed to load.");
    return _repo.getCompanyInformationById(id);
  }

  static Future<Either<String, CompanyDescription>> invoke(String id) async {
    return FetchCompanyInformationByIdUseCase(id)._fetchCompanyInformation(id);
  }
}

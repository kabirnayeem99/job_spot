import 'package:either_dart/either.dart';
import 'package:job_spot/data/repository/job_repository_impl.dart';
import 'package:job_spot/domain/entity/company_description.dart';
import 'package:job_spot/domain/repository/job_repository.dart';

class FetchCompanyInformationByIdUseCase {
  final JobRepository repo = JobRepositoryImpl();
  final String id;

  FetchCompanyInformationByIdUseCase(this.id);

  Future<Either<String, CompanyDescription>> _fetchCompanyInformation(
      String id) async {
    if (id.isEmpty) return const Left("Failed to load.");
    return repo.getCompanyInformationById(id);
  }

  static Future<Either<String, CompanyDescription>> invoke(String id) async {
    return FetchCompanyInformationByIdUseCase(id)._fetchCompanyInformation(id);
  }
}

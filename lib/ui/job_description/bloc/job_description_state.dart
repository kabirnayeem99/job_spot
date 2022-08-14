part of 'job_description_cubit.dart';

class JobDescriptionState extends Equatable {
  final JobDescription? jobDescription;
  final CompanyDescription? companyDescription;
  final JobDescriptionPageState pageState;
  final File? file;

  const JobDescriptionState({
    required this.jobDescription,
    required this.companyDescription,
    required this.pageState,
    required this.file,
  });

  static JobDescriptionState init() {
    return const JobDescriptionState(
      jobDescription: null,
      companyDescription: null,
      file: null,
      pageState: JobDescriptionPageState.description,
    );
  }

  @override
  List<Object?> get props => [jobDescription, companyDescription, pageState];

  JobDescriptionState copyWith({
    JobDescription? jobDescription,
    CompanyDescription? companyDescription,
    JobDescriptionPageState? pageState,
    File? file,
  }) {
    return JobDescriptionState(
      jobDescription: jobDescription ?? this.jobDescription,
      companyDescription: companyDescription ?? this.companyDescription,
      pageState: pageState ?? this.pageState,
      file: file ?? this.file,
    );
  }

  @override
  String toString() {
    return 'JobDescriptionState{jobDescription: $jobDescription, '
        'companyDescription: $companyDescription, '
        'pageState: $pageState, file: $file}';
  }
}

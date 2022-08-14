part of 'job_description_cubit.dart';

class JobDescriptionState extends Equatable {
  final JobDescription? jobDescription;
  final CompanyDescription? companyDescription;
  final JobDescriptionPageState pageState;
  final File? file;
  final List<UserMessage>? userMessages;

  const JobDescriptionState({
    required this.jobDescription,
    required this.companyDescription,
    required this.pageState,
    required this.file,
    required this.userMessages,
  });

  static JobDescriptionState init() {
    return const JobDescriptionState(
      jobDescription: null,
      companyDescription: null,
      file: null,
      pageState: JobDescriptionPageState.description,
      userMessages: [],
    );
  }

  @override
  List<Object?> get props => [jobDescription, companyDescription, pageState];

  JobDescriptionState copyWith({
    JobDescription? jobDescription,
    CompanyDescription? companyDescription,
    JobDescriptionPageState? pageState,
    File? file,
    List<UserMessage>? userMessages,
  }) {
    return JobDescriptionState(
      jobDescription: jobDescription ?? this.jobDescription,
      companyDescription: companyDescription ?? this.companyDescription,
      pageState: pageState ?? this.pageState,
      file: file ?? this.file,
      userMessages: userMessages ?? this.userMessages,
    );
  }

  @override
  String toString() {
    return 'JobDescriptionState{jobDescription: $jobDescription, '
        'companyDescription: $companyDescription, '
        'pageState: $pageState, file: $file}';
  }
}

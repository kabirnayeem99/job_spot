class JobPreview {
  final String companyLogo;
  final String jobPostName;
  final String companyName;
  final bool isSaved;
  final String salary;
  final String location;
  final List<String> tags;
  final SalaryType salaryType;

  JobPreview({
    required this.companyLogo,
    required this.jobPostName,
    required this.companyName,
    required this.salary,
    required this.location,
    required this.tags,
    required this.salaryType,
    this.isSaved = false,
  });

  JobPreview copyWith({
    String? companyLogo,
    String? jobPostName,
    String? companyName,
    String? jobType,
    bool? isSaved,
    String? monthlySalary,
    String? location,
    List<String>? tags,
    SalaryType? salaryType,
  }) {
    return JobPreview(
      companyLogo: companyLogo ?? this.companyLogo,
      jobPostName: jobPostName ?? this.jobPostName,
      companyName: companyName ?? this.companyName,
      isSaved: isSaved ?? this.isSaved,
      salary: monthlySalary ?? salary,
      location: location ?? this.location,
      tags: tags ?? this.tags,
      salaryType: salaryType ?? SalaryType.monthly,
    );
  }

  @override
  String toString() {
    return 'JobPreview{companyLogo: $companyLogo, jobPostName: $jobPostName, '
        'companyName: $companyName'
        ' isSaved: $isSaved, salary: $salary, location: $location, tags: $tags,'
        ' salaryType: $salaryType}';
  }
}

enum SalaryType {
  monthly,
  yearly,
}

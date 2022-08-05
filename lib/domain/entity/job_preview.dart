class JobPreview {
  final String companyLogo;
  final String jobPostName;
  final String companyName;
  final String jobCategory;
  final String jobType;
  final bool isSaved;
  final String monthlySalary;
  final String location;

  JobPreview({
    required this.companyLogo,
    required this.jobPostName,
    required this.companyName,
    required this.jobCategory,
    required this.jobType,
    required this.monthlySalary,
    required this.location,
    this.isSaved = false,
  });

  @override
  String toString() {
    return 'JobPreview{companyLogo: $companyLogo, jobPostName: $jobPostName, companyName: $companyName, jobCategory: $jobCategory, jobType: $jobType, isSaved: $isSaved, monthlySalary: $monthlySalary, location: $location}';
  }

  JobPreview copyWith({
    String? companyLogo,
    String? jobPostName,
    String? companyName,
    String? jobCategory,
    String? jobType,
    bool? isSaved,
    String? monthlySalary,
    String? location,
  }) {
    return JobPreview(
      companyLogo: companyLogo ?? this.companyLogo,
      jobPostName: jobPostName ?? this.jobPostName,
      companyName: companyName ?? this.companyName,
      jobCategory: jobCategory ?? this.jobCategory,
      jobType: jobType ?? this.jobType,
      isSaved: isSaved ?? this.isSaved,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      location: location ?? this.location,
    );
  }
}

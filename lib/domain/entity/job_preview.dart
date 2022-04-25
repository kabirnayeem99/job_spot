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
}

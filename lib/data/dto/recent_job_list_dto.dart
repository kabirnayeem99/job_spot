import 'package:job_spot/domain/entity/job_preview.dart';

class RecentJobListDto {
  List<JobSummary>? jobs;

  RecentJobListDto({this.jobs});

  RecentJobListDto.fromJson(Map<String, dynamic> json) {
    if (json['jobs'] != null) {
      jobs = <JobSummary>[];
      json['jobs'].forEach((job) {
        jobs?.add(JobSummary.fromJson(job));
      });
    }
  }

  List<JobPreview> toJobPreviewList() {
    return jobs?.map((j) => j.toJobPreview()).toList() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobSummary {
  String? title;
  String? companyName;
  String? salary;
  String? salaryType;
  String? companyLogoUrl;
  List<String>? tags;
  String? location;

  JobSummary({
    this.title,
    this.companyName,
    this.salary,
    this.salaryType,
    this.tags,
    this.location,
    this.companyLogoUrl,
  });

  JobSummary.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    companyName = json['company_name'];
    companyLogoUrl = json['company_logo_url'];
    salary = json['salary'];
    salaryType = json['salary_type'];
    tags = json['tags'].cast<String>();
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['company_name'] = companyName;
    data['salary'] = salary;
    data['salary_type'] = salaryType;
    data['company_logo_url'] = companyLogoUrl;
    data['tags'] = tags;
    data['location'] = location;
    return data;
  }

  @override
  String toString() {
    return 'JobSummary{title: $title, companyName: $companyName, '
        'salary: $salary, salaryType: $salaryType, companyLogoUrl: $companyLogoUrl,'
        ' tags: $tags, location: $location}';
  }

  JobPreview toJobPreview() {
    return JobPreview(
      jobPostName: title ?? "",
      companyName: companyName ?? "",
      salary: salary ?? "\$0",
      location: location ?? "Unknown",
      companyLogo: companyLogoUrl ?? "",
      tags: tags ?? [],
      salaryType:
          salaryType == "Monthly" ? SalaryType.monthly : SalaryType.yearly,
    );
  }
}

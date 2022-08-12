import 'dart:math';

import 'package:faker_dart/faker_dart.dart';
import 'package:job_spot/domain/entity/job_preview.dart';

import '../dto/recent_job_list_dto.dart';

class RemoteJobDataSource {
  final _faker = Faker.instance;

  Future<int> getRemoteJobCount() async {
    return 44000;
  }

  Future<int> getFullTimeJobCount() async {
    return 32000;
  }

  Future<int> getPartTimeJobCount() async {
    return 12000;
  }

  Future<RecentJobListDto> getRecentJobList() async {
    final tags = [
      _faker.lorem.word(),
      _faker.lorem.word(),
      _faker.lorem.word(),
    ];

    final List<JobSummary> jobs = List.empty(growable: true);

    for (int i = 0; i < 12; i++) {
      final job = JobSummary(
        title: _faker.hacker.noun(),
        companyName: _faker.company.companyName(),
        salaryType: "Monthly",
        salary: "\$250/K",
        tags: tags,
        location: _faker.address.toString(),
        companyLogoUrl: _faker.image.loremPixel.image(),
      );
      jobs.add(job);
    }

    return RecentJobListDto(jobs: jobs);
  }

  static JobPreview getRandomJobPreview() {
    final _faker = Faker.instance;
    final tags = [
      _faker.lorem.word(),
      _faker.lorem.word(),
      _faker.lorem.word(),
    ];
    final _address = _faker.address;

    return JobSummary(
      title: "Software Engineer",
      companyName: _faker.company.companyName(),
      salaryType: "Monthly",
      salary: "${Random().nextInt(500)}K",
      tags: tags,
      location: " ${_address.cityName()}, ${_address.country()}",
      companyLogoUrl: _faker.image.unsplash.technology(),
    ).toJobPreview();
  }
}

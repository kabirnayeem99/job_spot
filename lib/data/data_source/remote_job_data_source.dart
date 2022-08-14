import 'dart:math';

import 'package:faker_dart/faker_dart.dart';
import 'package:job_spot/common/utility/utility.dart';

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

    for (int i = 0; i < 10 + Random().nextInt(20); i++) {
      final address = _faker.address;
      final job = JobSummary(
        title: "Low-level Software Developer",
        companyName: _faker.company.companyName(),
        salaryType: Random().nextBool() ? "Monthly" : "Yearly",
        salary: "${Random().nextInt(580)}K",
        tags: tags,
        location: "${address.cityName()}, ${address.country()}",
        companyLogoUrl:
            Random().nextBool() ? "" : _faker.image.unsplash.image(),
      );
      jobs.add(job);
    }

    logger.d(jobs);

    return RecentJobListDto(jobs: jobs);
  }
}

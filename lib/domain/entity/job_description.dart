import 'package:equatable/equatable.dart';
import 'job_type.dart';

import 'location.dart';

class JobDescription extends Equatable {
  final String? title;
  final String? timePassed;
  final String? companyName;
  final String? companyLogoImageUrl;
  final String? shortDescription;
  final String? longDescription;
  final String? requirements;
  final Location? location;
  final JobType? jobType;
  final String? facilities;
  final String? qualification;
  final String? specialisation;
  final String? city;

  const JobDescription({
    this.title,
    this.timePassed,
    this.companyName,
    this.companyLogoImageUrl,
    this.shortDescription,
    this.longDescription,
    this.requirements,
    this.location,
    this.jobType,
    this.facilities,
    this.qualification,
    this.specialisation,
    this.city,
  });

  @override
  String toString() {
    return 'JobDescription{title: $title, timePassed: $timePassed, '
        'companyName: $companyName, companyLogoImageUrl: $companyLogoImageUrl, '
        'shortDescription: $shortDescription, longDescription: $longDescription,'
        ' requirements: $requirements, location: $location, jobType: $jobType,'
        ' facilities: $facilities, qualification: $qualification}';
  }

  JobDescription copyWith({
    String? title,
    String? timePassed,
    String? companyName,
    String? companyLogoImageUrl,
    String? shortDescription,
    String? longDescription,
    String? requirements,
    Location? location,
    JobType? jobType,
    String? facilities,
    String? qualification,
    String? specialisation,
    String? city,
  }) {
    return JobDescription(
      title: title ?? this.title,
      timePassed: timePassed ?? this.timePassed,
      companyName: companyName ?? this.companyName,
      companyLogoImageUrl: companyLogoImageUrl ?? this.companyLogoImageUrl,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      requirements: requirements ?? this.requirements,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      facilities: facilities ?? this.facilities,
      qualification: qualification ?? this.qualification,
      specialisation: specialisation ?? this.specialisation,
      city: city ?? this.city,
    );
  }

  static JobDescription generateMockJobDescription() {
    return JobDescription(
      title: "System Development Engineer",
      timePassed: "2 days ago",
      companyName: "Red Hat Linux",
      companyLogoImageUrl:
          "https://cbsnews1.cbsistatic.com/hub/i/2002/03/25/caffe037-a642-11e2-a3f0-029118418759/image504572x.jpg",
      shortDescription:
          "Low-Level System Developer program in low-level languages like C or Assembly, writing software that requires the absolute fastest performance for uses, such as high frequency ",
      longDescription:
          "Low-Level System Developer program in low-level languages like C or Assembly, writing software that requires the absolute fastest performance for uses, such as high frequency trading, graphics rendering, or high volume applications, like network servers and databases.",
      requirements:
          "Low-level System Developer need to know the language they're working in, like C, C++, or Rust. They will have a deep understanding of how the language really works down to how the code gets turned into the individual instructions that are executed by the computer. They'll often need to understand the capabilities of the specific hardware their code will run on, as well as any other systems that it interacts with, like disks or networks.",
      location: Location(
        34.543896,
        69.160652,
        "G43Q+W8V, Technik Street, کابل، Afghanistan",
      ),
      facilities:
          "Create the collaborative work environments that help us succeed. A diverse squad, ranging from analysts and civil engineers to real estate managers and security officers, our team designs and maintains the surroundings that energize and inspire us. We handle state-of-the-art green construction projects in London, maintenance of Mountain View’s resident T. Rex skeleton, and supervision of food services programs in Singapore. Pushing the boundaries of what’s possible in a workspace, we set modern standards for workplace innovation and productivity.",
      specialisation: "Low-level development",
      qualification: "OOP Design, Linux, System Design",
      city: "Kabul",
      jobType: JobType.partTime,
    );
  }

  @override
  List<Object?> get props => [
        title,
        timePassed,
        companyName,
        companyLogoImageUrl,
        shortDescription,
        longDescription,
        requirements,
        location,
        jobType,
        facilities,
        qualification,
        specialisation,
        city,
      ];
}

enum JobType {
  fullTime,
  partTime,
  remote,
}

String getJobTypeDisplayNameByEnum(JobType jobType) {
  String displayName = "";

  switch (jobType) {
    case JobType.fullTime:
      displayName = "Full Time";
      break;
    case JobType.partTime:
      displayName = "Part time";
      break;
    case JobType.remote:
      displayName = "Remote";
      break;
  }

  return displayName;
}

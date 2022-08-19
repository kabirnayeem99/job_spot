enum JobType {
  fullTime,
  partTime,
  remote,
}

/// Takes in a JobType enum and returns a String that is the display name of the
/// enum
///
/// Args:
///   jobType (JobType): This is the enum value that we want to get the display name
/// for.
///
/// Returns:
///   A string
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_spot/domain/entity/job_preview.dart';

import '../../../common/theme/colors.dart';
import '../../widgets/chip_button.dart';

class JobListItemContainer extends StatelessWidget {
  final JobPreview job;

  const JobListItemContainer({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 149.0,
      width: 335.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: mercuryBlue.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network(
                  job.companyLogo,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.jobPostName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Row(
                    children: [
                      Text(
                        job.companyName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      const Text("???"),
                      const SizedBox(width: 4.0),
                      Text(
                        job.location,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(child: Container()),
              Icon(
                job.isSaved
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                color: darkIndigo,
                size: 20.0,
              )
            ],
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  text: "\$${job.monthlySalary}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: "/Mo",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ]),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              ChipButton(text: job.jobCategory),
              const SizedBox(width: 8.0),
              ChipButton(text: job.jobType),
              Expanded(child: Container()),
              ChipButton(
                text: "Apply",
                backgroundColor: orangeBurning.withOpacity(0.4),
              ),
            ],
          )
        ],
      ),
    );
  }
}

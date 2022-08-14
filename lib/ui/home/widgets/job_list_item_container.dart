import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_spot/ui/widgets/image.dart';
import 'package:unicons/unicons.dart';

import '../../../common/theme/colors.dart';
import '../../../domain/entity/job_preview.dart';
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
                child: job.companyLogo.isNotEmpty
                    ? RemoteImage(
                        imageUrl: job.companyLogo,
                        height: 40.0,
                        width: 40.0,
                      )
                    : Container(
                        height: 40.0,
                        width: 40.0,
                        color: nightBlue,
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
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Text(
                          job.companyName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                        const Text("•"),
                        const SizedBox(width: 4.0),
                        Flexible(
                          child: Text(
                            job.location,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(child: Container()),
              Icon(
                job.isSaved ? UniconsLine.bookmark : UniconsSolid.bookmark,
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
                  text: "\$${job.salary}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          job.salaryType == SalaryType.monthly ? "/Mo" : "/Yr",
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
              ChipButton(text: job.tags[0]),
              const SizedBox(width: 8.0),
              ChipButton(text: job.tags[1]),
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

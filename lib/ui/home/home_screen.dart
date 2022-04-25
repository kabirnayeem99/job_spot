import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/domain/entity/job_preview.dart';
import 'package:job_spot/ui/widgets/secondary_action_button.dart';

import 'widgets/job_list_item_container.dart';

const homeScreenNavRouteName = "home_screen/";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteSnowDrift,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 22.0, right: 22.0, top: 18),
          child: ScrollConfiguration(
            behavior:
                const MaterialScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Text(
                          "Hello, \nNaimul Kabir",
                          style: TextStyle(
                            color: nightBlue,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          "https://avatars.githubusercontent.com/u/39023212?v=4",
                          height: 40.0,
                          width: 40.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 38.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17.0, vertical: 17.0),
                    width: double.infinity,
                    height: 143.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: darkIndigo,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Container()),
                        const Text(
                          "50% off\ntake any courses",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 17.0),
                        const SecondaryActionButton(buttonText: "Join Now"),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Find Your Job",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 170.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: bluishCyanFrenchPass,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                CupertinoIcons.compass,
                                size: 34.0,
                                color: darkIndigo,
                              ),
                              Text(
                                "44.5K",
                                style: TextStyle(
                                  color: nightBlue,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Remote Jobs",
                                style: TextStyle(
                                  color: nightBlue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: SizedBox(
                          height: 170.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 75.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: violetPale,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "66.5K",
                                      style: TextStyle(
                                        color: nightBlue,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Full Time",
                                      style: TextStyle(
                                        color: nightBlue,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 75.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: orangeLightApricot,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "38.5K",
                                      style: TextStyle(
                                        color: nightBlue,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Part Time",
                                      style: TextStyle(
                                        color: nightBlue,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 19.0),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Recent Job List",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, position) {
                        return JobListItemContainer(
                          job: JobPreview(
                            jobCategory: "Senior Dev",
                            jobPostName: "iOS Developer - ${position + 1}",
                            monthlySalary: "2${position}${position + 3}K",
                            companyLogo:
                                "http://2.bp.blogspot.com/-i4eGD4DSnjQ/T60e7I4WHfI/AAAAAAAACqw/PFbWuA2ONAI/s1600/Apple+Logo+Wallpapers+2.jpg",
                            companyName: "Apple Inc.",
                            jobType: "Full-time",
                            location: "Chittagong, BD",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

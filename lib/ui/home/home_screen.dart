import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/ui/widgets/chip_button.dart';
import 'package:job_spot/ui/widgets/secondary_action_button.dart';

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
                        return const JobListItemContainer();
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

class JobListItemContainer extends StatelessWidget {
  const JobListItemContainer({
    Key? key,
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
                  "https://1000logos.net/wp-content/uploads/2016/10/apple-emblem.jpg",
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "iOS Developer",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Row(
                    children: const [
                      Text(
                        "Google Inc.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text("•"),
                      SizedBox(width: 4.0),
                      Text(
                        "Chittagong, BD",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(child: Container()),
              const Icon(
                CupertinoIcons.bookmark,
                size: 20.0,
              )
            ],
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                  text: "\$15K",
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
              const ChipButton(text: "Senior Developer"),
              const SizedBox(width: 8.0),
              const ChipButton(text: "Full time"),
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

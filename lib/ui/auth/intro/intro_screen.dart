import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme/colors.dart';
import '../log_in/log_in_screen.dart';

const introScreenNavigationRouteName = "intro_screen/";

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  void _navigateToLogInScreen(BuildContext context) {
    final router = FluroRouter.appRouter;

    router.navigateTo(context, logInScreenNavigationRouteName,
        transition: TransitionType.cupertino);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Jobspot",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(child: Container()),
              SvgPicture.asset("assets/images/svgs/banner_intro.svg",
                  height: 311, width: 311),
              Expanded(child: Container()),
              const Text(
                "Find Your",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Dream Job",
                textAlign: TextAlign.start,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: neonCarrot,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Here!",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Explore all the most exciting job roles based on your interest and study major.",
                style: TextStyle(
                  color: mulledWine,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () => _navigateToLogInScreen(context),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      color: darkIndigo,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}

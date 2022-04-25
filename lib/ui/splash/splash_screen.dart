import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/ui/intro/intro_screen.dart';

const splashScreenNavigationRouteName = "/";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _waitAndMoveOn();
  }

  void _waitAndMoveOn() {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_navigateToIntroScreen(context)});
  }

  void _navigateToIntroScreen(BuildContext context) {
    final router = FluroRouter.appRouter;

    router.navigateTo(context, introScreenNavigationRouteName,
        transition: TransitionType.cupertino);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkIndigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/svgs/logo_jobspot.svg"),
            const SizedBox(height: 4),
            const Text(
              "Jobspot",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

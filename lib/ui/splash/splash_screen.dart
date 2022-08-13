import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/theme/colors.dart';
import '../../common/utility/utility.dart';
import '../home/home_screen.dart';
import 'bloc/splash_bloc.dart';

import '../auth/intro/intro_screen.dart';

const splashScreenNavigationRouteName = "/";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FluroRouter? router;
  late SplashBloc bloc;

  @override
  void initState() {
    router ??= FluroRouter.appRouter;
    bloc = SplashBloc();
    dismissKeyboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (_) => bloc..add(CheckAuthenticationSplashEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.isAuthenticated == null) return;
          if (state.isAuthenticated!) {
            _waitAndGoToHomeScreen();
          } else {
            _waitAndGoToIntroScreen();
          }
        },
        builder: (context, state) => _buildPage(),
      ),
    );
  }

  void _waitAndGoToIntroScreen() {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_navigateToIntroScreen(context)});
  }

  void _waitAndGoToHomeScreen() {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => {_navigateToHomeScreen(context)});
  }

  void _navigateToIntroScreen(BuildContext context) {
    router?.navigateTo(
      context,
      introScreenNavigationRouteName,
      transition: TransitionType.cupertino,
      replace: true,
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    router?.navigateTo(
      context,
      homeScreenNavRouteName,
      transition: TransitionType.cupertino,
      replace: true,
    );
  }

  Widget _buildPage() {
    return Scaffold(
      backgroundColor: darkIndigo,
      body: GestureDetector(
        onTap: () => dismissKeyboard(),
        child: Center(
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
      ),
    );
  }
}

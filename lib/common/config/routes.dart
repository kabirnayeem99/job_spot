import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:job_spot/common/config/route_handlers.dart';
import 'package:job_spot/ui/home/home_screen.dart';
import 'package:job_spot/ui/job_description/job_description_screen.dart';
import 'package:job_spot/ui/splash/splash_screen.dart';

import '../../ui/auth/forget_password/check_email_screen.dart';
import '../../ui/auth/forget_password/forget_password_screen.dart';
import '../../ui/auth/intro/intro_screen.dart';
import '../../ui/auth/log_in/log_in_screen.dart';
import '../../ui/auth/sign_up/sign_up_screen.dart';

class Routes {
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const SplashScreen();
    });

    router.define(splashScreenNavigationRouteName, handler: rootHandler);

    router.define(
      introScreenNavigationRouteName,
      handler: introScreenHandler,
    );

    router.define(
      logInScreenNavigationRouteName,
      handler: logInScreenHandler,
    );

    router.define(
      signUpScreenNavigationRouteName,
      handler: signUpScreenHandler,
    );

    router.define(
      forgetPasswordScreenNavigationName,
      handler: forgetPasswordScreenHandler,
    );

    router.define(
      checkEmailScreenNavigationRouteName,
      handler: checkEmailScreenHandler,
    );

    router.define(homeScreenNavRouteName, handler: homeScreenHandler);
    router.define(jobDescScreenNavRouteName, handler: jobDescScreenHandler);
  }
}

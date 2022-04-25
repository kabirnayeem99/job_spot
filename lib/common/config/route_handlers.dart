import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:job_spot/ui/forget_password/check_email_screen.dart';
import 'package:job_spot/ui/forget_password/forget_password_screen.dart';
import 'package:job_spot/ui/log_in/log_in_screen.dart';
import 'package:job_spot/ui/sign_up/sign_up_screen.dart';
import 'package:job_spot/ui/splash/splash_screen.dart';

import '../../ui/intro/intro_screen.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const SplashScreen();
});

var introScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const IntroScreen(),
);

var logInScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const LogInScreen(),
);

var signUpScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const SignUpScreen(),
);

var forgetPasswordScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const ForgetPasswordScreen(),
);

var checkEmailScreenHandler = Handler(
  handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
      const CheckEmailScreen(),
);

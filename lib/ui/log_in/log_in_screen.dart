import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/common/utility/utility.dart';
import 'package:job_spot/ui/forget_password/forget_password_screen.dart';

import '../sign_up/sign_up_screen.dart';
import '../widgets/primary_action_button.dart';

const logInScreenNavigationRouteName = "log_in_screen/";

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late FluroRouter router;

  @override
  void initState() {
    super.initState();
    router = FluroRouter.appRouter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 40.0),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 11.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 42.0),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mulledWine,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64.0),
              _buildEmailTextInput(),
              const SizedBox(height: 15.0),
              _buildPasswordTextInput(),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool) {},
                    activeColor: lavenderMist,
                    checkColor: darkIndigo,
                  ),
                  const Text(
                    "Remember Me",
                    style: TextStyle(
                      color: spanPearl,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () => _navigateToForgetPasswordScreen(context),
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(
                        color: nightBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36.0),
              _buildLogInButton(),
              const SizedBox(height: 19.0),
              _buildGoogleLogInButton(),
              const SizedBox(height: 16.0),
              _buildSignUpTextButton(),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToSignUpScreen(BuildContext context) =>
      router.navigateTo(context, signUpScreenNavigationRouteName,
          transition: TransitionType.cupertino);

  void _navigateToHomeScreen(BuildContext context) {}

  void _signInWithGoogle(BuildContext context) async {
    launchUrlInWeb("google.com");
  }

  void _navigateToForgetPasswordScreen(BuildContext context) =>
      router.navigateTo(context, forgetPasswordScreenNavigationName,
          transition: TransitionType.cupertino);

  Widget _buildSignUpTextButton() {
    return GestureDetector(
      onTap: () => _navigateToSignUpScreen(context),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "You don't have an account yet?",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 5.0),
            Text(
              "Sign up.",
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: orangeDeepSaffron,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogInButton() {
    const buttonText = "login";
    return GestureDetector(
      onTap: () => _navigateToHomeScreen(context),
      child: const PrimaryActionButton(buttonText: buttonText),
    );
  }

  Widget _buildGoogleLogInButton() {
    return GestureDetector(
      onTap: () => _signInWithGoogle(context),
      child: Container(
        height: 50.0,
        width: 266.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: fog,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/pngs/logo_google.png",
                height: 20.0,
                width: 20.0,
              ),
              const SizedBox(width: 11.0),
              const Text(
                "SIGN IN WITH GOOGLE",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: darkIndigo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextInput() {
    return Align(
      alignment: Alignment.topLeft,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: nightBlue,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: mercuryBlue,
                    spreadRadius: 2,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: SvgPicture.asset(
                          "assets/images/svgs/ic_hidden_eye.svg",
                          height: 24.0,
                          width: 24.0,
                        ),
                      ),
                      hintText: "•••••••",
                      hintStyle: const TextStyle(
                        color: transCongressBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTextInput() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              color: nightBlue,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: mercuryBlue,
                  spreadRadius: 2,
                  blurRadius: 20,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                autocorrect: true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "kabirnayeem.99@gmail.com",
                  hintStyle: TextStyle(
                    color: transCongressBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

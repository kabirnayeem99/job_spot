import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_spot/ui/widgets/primary_action_button.dart';

import '../../../common/theme/colors.dart';
import '../log_in/log_in_screen.dart';
import 'check_email_screen.dart';

const forgetPasswordScreenNavigationName = "forget_password_screen/";

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with SingleTickerProviderStateMixin {
  late FluroRouter router;

  @override
  void initState() {
    super.initState();
    router = FluroRouter.appRouter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: 35.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Forget Password?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
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
                  "To reset your password, you need your email or mobile number that can be authenticated",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mulledWine,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 45.0),
            SvgPicture.asset("assets/images/svgs/banner_foreget_password.svg"),
            const SizedBox(height: 60.0),
            _buildEmailTextInput(),
            const SizedBox(height: 30.0),
            _buildOpenMailButton(),
            const SizedBox(height: 25.0),
            _buildBackToLogInButton(),
          ],
        ),
      ),
    );
  }

  void _navigateBackToSignInScreen() =>
      router.navigateTo(context, logInScreenNavigationRouteName,
          transition: TransitionType.cupertino);

  void _navigateToCheckEmailScreen() =>
      router.navigateTo(context, checkEmailScreenNavigationRouteName,
          transition: TransitionType.cupertino);

  Widget _buildOpenMailButton() {
    return GestureDetector(
      onTap: () => _navigateToCheckEmailScreen(),
      child: const PrimaryActionButton(
        buttonText: "reset password",
        width: double.infinity,
      ),
    );
  }

  Widget _buildBackToLogInButton() {
    return GestureDetector(
      onTap: () => _navigateBackToSignInScreen(),
      child: const PrimaryActionButton(
        buttonText: "back to login",
        buttonColor: purpleBlueMoonraker,
        buttonTextColor: darkIndigo,
        width: double.infinity,
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

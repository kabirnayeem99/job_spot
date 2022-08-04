import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/common/utility/utility.dart';
import 'package:job_spot/ui/auth/log_in/log_in/log_in_bloc.dart';
import 'package:job_spot/ui/auth/log_in/log_in/log_in_event.dart';
import 'package:job_spot/ui/auth/log_in/log_in/log_in_state.dart';
import 'package:job_spot/ui/home/home_screen.dart';

import '../../widgets/primary_action_button.dart';
import '../forget_password/forget_password_screen.dart';
import '../sign_up/sign_up_screen.dart';

const logInScreenNavigationRouteName = "log_in_screen/";

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late FluroRouter _router;
  LogInState _state = LogInState(false, "", "", "", "").init();
  late LogInBloc _bloc;

  @override
  void initState() {
    super.initState();
    _router = FluroRouter.appRouter;
    _bloc = LogInBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc..add(LoadLogInScreenEvent()),
        child: BlocListener<LogInBloc, LogInState>(
          bloc: _bloc,
          listener: (BuildContext context, LogInState state) {
            _state = state;
            print(
                "_state -> ${_state.email}, ${_state.emailValidationErrorText}");
            print("state -> ${state.email}, ${state.emailValidationErrorText}");
          },
          child: _buildPage(_state),
        ));
  }

  Scaffold _buildPage(LogInState state) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const SizedBox(height: 40.0),
              _buildLogInTitle(),
              const SizedBox(height: 11.0),
              _buildLogInHintSubtitle(),
              const SizedBox(height: 64.0),
              _buildEmailTextInput(),
              const SizedBox(height: 15.0),
              _buildPasswordTextInput(),
              const SizedBox(height: 20.0),
              _buildLogInActionsList(),
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

  Widget _buildLogInTitle() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "Welcome Back!",
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildLogInHintSubtitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 42.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          _bloc.state.emailValidationErrorText ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: mulledWine,
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildLogInActionsList() {
    return Row(
      children: [
        Checkbox(
          value: true,
          onChanged: (isChecked) {
            _bloc.add(ToggleRememberPassword(isChecked ?? false));
          },
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
        _buildForgetPasswordTextButton(),
      ],
    );
  }

  Widget _buildForgetPasswordTextButton() {
    return GestureDetector(
      onTap: () => _navigateToForgetPasswordScreen(context),
      child: const Text(
        "Forget password?",
        style: TextStyle(
          color: nightBlue,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

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
      onTap: () => _bloc.add(LogInWithEmailAndPassword()),
      child: const PrimaryActionButton(buttonText: buttonText),
    );
  }

  void _showUserMessage() {
    if (!_bloc.state.isEmailValid()) {
      print("Should proceed");
      final message = _bloc.state.emailValidationErrorText;
      final snackBar = SnackBar(content: Text(message ?? ""));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
                    onChanged: (passwordAsTyping) {
                      _bloc.add(CachePasswordEvent(passwordAsTyping));
                    },
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                autocorrect: true,
                onChanged: (emailAsTyping) {
                  _bloc.add(CacheEmailEvent(emailAsTyping));
                },
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

  void _navigateToSignUpScreen(BuildContext context) =>
      _router.navigateTo(context, signUpScreenNavigationRouteName,
          transition: TransitionType.cupertino);

  void _navigateToHomeScreen(BuildContext context) =>
      _router.navigateTo(context, homeScreenNavRouteName,
          transition: TransitionType.cupertino);

  void _signInWithGoogle(BuildContext context) async {
    launchUrlInWeb("google.com");
  }

  void _navigateToForgetPasswordScreen(BuildContext context) =>
      _router.navigateTo(context, forgetPasswordScreenNavigationName,
          transition: TransitionType.cupertino);
}

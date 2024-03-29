import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme/colors.dart';
import '../../../common/utility/utility.dart';
import '../../widgets/primary_action_button.dart';
import '../log_in/log_in_screen.dart';
import 'bloc/forget_password_cubit.dart';
import 'bloc/forget_password_state.dart';

const checkEmailScreenNavigationRouteName = "check_email_screen/";

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  late FluroRouter router;
  late ForgetPasswordCubit bloc;

  @override
  void initState() {
    super.initState();
    router = FluroRouter.appRouter;
    bloc = ForgetPasswordCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      bloc: bloc,
      listener: (BuildContext context, ForgetPasswordState state) {
        _showUserMessage(state);
      },
      builder: (context, state) => _buildPage(context, state),
    );
  }

  void _showUserMessage(ForgetPasswordState state) {
    final isThereNotMessageToShow = (state.userMessages.isEmpty);
    if (isThereNotMessageToShow) return;

    final message = state.userMessages.first.message;
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    bloc.userMessageShown(state.userMessages.first.id);
  }

  Widget _buildPage(
    BuildContext context,
    ForgetPasswordState state,
  ) {
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
                  "Check Your Email",
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
                    "We have sent the reset password to the email address kabirnayeem.99@gmial.com",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mulledWine,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 52.0),
              SvgPicture.asset("assets/images/svgs/banner_check_email.svg"),
              const SizedBox(height: 72.0),
              const SizedBox(height: 35.0),
              _buildOpenEmail(),
              const SizedBox(height: 30.0),
              _buildBackToLogInButton(),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateBackToSignInScreen() => router.navigateTo(
        context,
        logInScreenNavigationRouteName,
        replace: true,
      );

  void _navigateToEmailScreen() =>
      launchEmail("kabirnayeem.99@gmail.com", "", "");

  Widget _buildOpenEmail() {
    return GestureDetector(
      onTap: () => _navigateToEmailScreen(),
      child: const PrimaryActionButton(
        buttonText: "open your email",
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
}

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/theme/colors.dart';
import '../../../common/utility/utility.dart';
import '../../widgets/primary_action_button.dart';
import 'bloc/forget_password_bloc.dart';
import 'bloc/forget_password_event.dart';
import 'bloc/forget_password_state.dart';

const checkEmailScreenNavigationRouteName = "check_email_screen/";

class CheckEmailScreen extends StatefulWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  late FluroRouter router;

  @override
  void initState() {
    super.initState();
    router = FluroRouter.appRouter;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ForgetPasswordBloc>(context);
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      bloc: bloc,
      listener: (BuildContext context, ForgetPasswordState state) {
        _showUserMessage(bloc, state);
        if (state.status != null) {
          switch (state.status!) {
            case ForgetPasswordStatus.launchForgetPasswordScreen:
              break;
            case ForgetPasswordStatus.navigateBackToSignInScreen:
              dismissKeyboard();
              _navigateBackToSignInScreen();
              break;
            case ForgetPasswordStatus.navigateToCheckEmailScreen:
              break;
          }
        }
      },
      builder: (context, state) => _buildPage(context, bloc, state),
    );
  }

  void _showUserMessage(ForgetPasswordBloc bloc, ForgetPasswordState state) {
    final isThereNotMessageToShow = (state.userMessages.isEmpty);
    if (isThereNotMessageToShow) return;

    final message = state.userMessages.first.message;
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    bloc.add(UserMessageShown(state.userMessages.first.id));
  }

  Widget _buildPage(
    BuildContext context,
    ForgetPasswordBloc bloc,
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
              _buildBackToLogInButton(bloc),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateBackToSignInScreen() => router.pop(context);

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

  Widget _buildBackToLogInButton(ForgetPasswordBloc bloc) {
    return GestureDetector(
      onTap: () => bloc.add(GoBackToSignInScreeEvent()),
      child: const PrimaryActionButton(
        buttonText: "back to login",
        buttonColor: purpleBlueMoonraker,
        buttonTextColor: darkIndigo,
        width: double.infinity,
      ),
    );
  }
}

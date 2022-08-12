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
    dismissKeyboard();
    router = FluroRouter.appRouter;
  }

  @override
  void dispose() {
    dismissKeyboard();
    super.dispose();
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
              dismissKeyboard();
              _navigateToCheckEmailScreen();
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

  Scaffold _buildPage(
    BuildContext context,
    ForgetPasswordBloc bloc,
    ForgetPasswordState state,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(height: 35.0),
            _buildForgetPasswordTitle(bloc),
            const SizedBox(height: 11.0),
            _buildHintSubtitle(bloc),
            const SizedBox(height: 45.0),
            _buildForgetPasswordHintIllustration(),
            const SizedBox(height: 60.0),
            _buildEmailTextInput(bloc),
            const SizedBox(height: 30.0),
            _buildOpenMailButton(bloc),
            const SizedBox(height: 25.0),
            _buildBackToLogInButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget _buildForgetPasswordTitle(ForgetPasswordBloc bloc) {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        "Forget Password?",
        style: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildForgetPasswordHintIllustration() =>
      SvgPicture.asset("assets/images/svgs/banner_foreget_password.svg");

  Widget _buildHintSubtitle(ForgetPasswordBloc bloc) {
    return Container(
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
    );
  }

  Widget _buildOpenMailButton(ForgetPasswordBloc bloc) {
    return GestureDetector(
      onTap: () => bloc.add(ResetPasswordEvent()),
      child: const PrimaryActionButton(
        buttonText: "reset password",
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

  Widget _buildEmailTextInput(ForgetPasswordBloc bloc) {
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
            child: _buildEmailTextBox(bloc),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextBox(ForgetPasswordBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        autocorrect: true,
        onChanged: (emailAsTyping) => {
          bloc.add(
            SaveEmailEvent(emailAsTyping: emailAsTyping),
          ),
        },
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "username@example.com",
          hintStyle: TextStyle(
            color: transCongressBlue,
          ),
        ),
      ),
    );
  }

  Future<void> _navigateBackToSignInScreen() async => router.pop(context);

  Future<void> _navigateToCheckEmailScreen() =>
      router.navigateTo(context, checkEmailScreenNavigationRouteName,
          transition: TransitionType.cupertino);
}

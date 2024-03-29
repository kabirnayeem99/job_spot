import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'bloc/forget_password_cubit.dart';

import '../../../common/theme/colors.dart';
import '../../../common/utility/utility.dart';
import '../../widgets/primary_action_button.dart';
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
  late FluroRouter router = FluroRouter.appRouter;
  late ForgetPasswordCubit bloc = GetIt.I.get();

  @override
  void dispose() {
    dismissKeyboard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgetPasswordCubit>(
      create: (_) => bloc,
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        bloc: bloc,
        listener: (BuildContext context, ForgetPasswordState state) {
          _showUserMessage();
          if (state.status != null) {
            switch (state.status!) {
              case ForgetPasswordStatus.sentForgotPasswordRecoveryMail:
                dismissKeyboard();
                _navigateToCheckEmailScreen();
                break;
              case ForgetPasswordStatus.needForgotPasswordMail:
                break;
            }
          }
        },
        builder: (context, state) => _buildPage(context, state),
      ),
    );
  }

  void _showUserMessage() {
    final isThereNotMessageToShow = (bloc.state.userMessages.isEmpty);
    if (isThereNotMessageToShow) return;

    final userMessage = bloc.state.userMessages.first;
    final message = userMessage.message;
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    bloc.userMessageShown(userMessage.id);
  }

  Scaffold _buildPage(
    BuildContext context,
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
            _buildForgetPasswordTitle(),
            const SizedBox(height: 11.0),
            _buildHintSubtitle(),
            const SizedBox(height: 45.0),
            _buildForgetPasswordHintIllustration(),
            const SizedBox(height: 60.0),
            _buildEmailTextInput(),
            const SizedBox(height: 30.0),
            _buildOpenMailButton(),
            const SizedBox(height: 25.0),
            _buildBackToLogInButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget _buildForgetPasswordTitle() {
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

  Widget _buildHintSubtitle() {
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

  Widget _buildOpenMailButton() {
    return GestureDetector(
      onTap: () => bloc.resetPassword(),
      child: const PrimaryActionButton(
        buttonText: "reset password",
        width: double.infinity,
      ),
    );
  }

  Widget _buildBackToLogInButton(ForgetPasswordCubit bloc) {
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
            child: _buildEmailTextBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        autocorrect: true,
        onChanged: (emailAsTyping) => bloc.emailChanged(emailAsTyping),
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

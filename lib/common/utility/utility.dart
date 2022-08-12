import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

final logger = Logger();

Future<void> launchUrlInWeb(String url) async {
  final uri = Uri.parse(url);
  await launchUrl(uri);
}

Future<void> launchEmail(
  String address,
  String subject,
  String body,
) async {
  final emailUrl = "mailto:$address?subject=$subject&body=$body";
  final uri = Uri.parse(emailUrl);
  await launchUrl(uri);
}

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}


bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isPasswordValid(String password) {
  return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}
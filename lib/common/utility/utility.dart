import 'dart:io';

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

String getFileNameFromFile(File? file) {
  return file?.path.split('/').last ?? "No file selected";
}

/// Returns the file size in MB
///
/// Args:
///   file (File): The file whose size we want to get.
///
/// Returns:
///   File size in string.
String getFileSize(File? file) {
  logger.d(file);
  if (file == null) return "0.0";
  int sizeInBytes = file.lengthSync();
  double sizeInMb = sizeInBytes / (1024 * 1024);
  return sizeInMb.toStringAsFixed(3);
}

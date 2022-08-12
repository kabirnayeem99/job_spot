import 'package:either_dart/either.dart';

Either<String, bool> isEmailValid(String? email) {
  if (email == null) return const Left("Your email is empty.");
  if (email.isEmpty) return const Left("Your email is empty.");

  const emailValidatorRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final isValid = RegExp(emailValidatorRegex).hasMatch(email);
  if (isValid) {
    return Right(isValid);
  } else {
    return const Left("Your email is not valid");
  }
}

Either<String, bool> isPasswordValid(String? password) {
  if (password == null) return const Left("Your password is empty.");
  if (password.isEmpty) return const Left("Your password is empty.");
  if (password.length < 6) return const Left("Your password is too short.");

  const passwordValidatorRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  final isValid = RegExp(passwordValidatorRegex).hasMatch(password);
  if (isValid) {
    return Right(isValid);
  } else {
    return const Left("Your password is vulnerable to dictionary attack.");
  }
}

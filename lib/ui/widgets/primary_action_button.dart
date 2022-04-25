import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';

class PrimaryActionButton extends StatelessWidget {
  final Color buttonColor;
  final Color buttonTextColor;
  final double width;

  const PrimaryActionButton({
    Key? key,
    required this.buttonText,
    this.buttonColor = darkIndigo,
    this.buttonTextColor = Colors.white,
    this.width = 266.0,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: buttonColor,
      ),
      child: Center(
        child: Text(
          buttonText.toUpperCase(),
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: buttonTextColor,
          ),
        ),
      ),
    );
  }
}

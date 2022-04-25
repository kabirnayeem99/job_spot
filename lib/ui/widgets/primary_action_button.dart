import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';

class PrimaryActionButton extends StatelessWidget {
  final Color buttonColor;
  final Color buttonTextColor;
  final double width;
  final double height;
  final double buttonTextFontSize;
  final FontWeight buttonTextFontWeight;

  const PrimaryActionButton({
    Key? key,
    required this.buttonText,
    this.buttonColor = darkIndigo,
    this.buttonTextColor = Colors.white,
    this.width = 266.0,
    this.height = 50.0,
    this.buttonTextFontSize = 14.0,
    this.buttonTextFontWeight = FontWeight.w700,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: buttonColor,
      ),
      child: Center(
        child: Text(
          buttonText.toUpperCase(),
          style: TextStyle(
            fontSize: buttonTextFontSize,
            fontWeight: buttonTextFontWeight,
            color: buttonTextColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:job_spot/common/theme/colors.dart';

class ChipButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;

  const ChipButton({
    Key? key,
    required this.text,
    this.backgroundColor = grayGhost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: mulledWine,
        ),
      ),
    );
  }
}

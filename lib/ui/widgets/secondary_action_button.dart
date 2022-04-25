import 'package:flutter/material.dart';

import '../../common/theme/colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String buttonText;

  const SecondaryActionButton({Key? key, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.0,
      width: 90.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: orangeDeepSaffron,
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

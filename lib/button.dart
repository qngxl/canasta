import 'package:flutter/material.dart';

import 'team_container.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.buttonText, required this.onPressed});

  final void Function()? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: preferedColor,
      ),
      child: Text(
        buttonText,
        style: TextStyle(color: preferedTextColor),
      ),
    );
  }
}

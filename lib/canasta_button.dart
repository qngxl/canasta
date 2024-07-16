import 'package:flutter/material.dart';
import 'canasta_text.dart';
import 'global.dart';

class CanastaButton extends StatelessWidget {
  const CanastaButton(
      {super.key, required this.buttonText, required this.onPressed});

  final void Function()? onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: preferedColor,
      ),
      child: CanastaText(buttonText),
    );
  }
}

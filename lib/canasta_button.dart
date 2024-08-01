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
          side: const BorderSide(
              width: 2,
              color: preferedTextColor)), // ToDo : no border / white border?
      child: CanastaText(buttonText),
    );
  }
}

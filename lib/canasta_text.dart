import 'package:flutter/material.dart';
import 'global.dart';

class CanastaText extends StatelessWidget {
  const CanastaText(this.text,
      {super.key,
      this.background = const Color.fromARGB(255, 109, 102, 209),
      this.size = 16});

  final String text;
  final Color background;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: preferedTextColor,
          backgroundColor: background),
    );
  }
}

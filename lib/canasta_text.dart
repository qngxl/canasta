import 'package:flutter/material.dart';
import 'global.dart';

class CanastaText extends StatelessWidget {
  const CanastaText(this.text,
      {super.key,
      this.background = const Color.fromARGB(255, 109, 102, 209),
      this.size = 16,
      this.textAlign = TextAlign.center});

  final String text;
  final Color background;
  final double size;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: size,
          color: preferedTextColor,
          backgroundColor: Colors.transparent),
    );
  }
}

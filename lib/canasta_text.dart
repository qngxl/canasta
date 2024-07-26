import 'package:flutter/material.dart';
import 'global.dart';

class CanastaText extends StatelessWidget {
  const CanastaText(this.text,
      {super.key,
      this.background = preferedColor,
      this.size = 16,
      this.textAlign = TextAlign.center,
      this.color = preferedTextColor});

  final String text;
  final Color background;
  final double size;
  final TextAlign? textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: size, color: color, backgroundColor: Colors.transparent),
    );
  }
}

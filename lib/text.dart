import 'package:flutter/material.dart';

import 'team_container.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: preferedTextColor),
    );
  }
}

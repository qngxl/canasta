import 'package:flutter/material.dart';

import 'team_container.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    {super.key,
    required this.customTextText,
    }
  );

  final String customTextText;

  @override
  Widget build(BuildContext context) {

    return Text(style: TextStyle(fontSize: 16, color: preferedTextColor),);
  }
}
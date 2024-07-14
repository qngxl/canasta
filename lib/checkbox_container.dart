// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

import 'team_container.dart';

class CheckboxContainer extends StatelessWidget {
  const CheckboxContainer({
    super.key,
    required this.checkboxValue,
    required this.callback,
    required this.checkboxText,
  });

  final bool checkboxValue;
  final Function(bool?) callback;
  final String checkboxText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          color: preferedColor,
          // border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          Padding(
            padding: insets,
            child: Text(checkboxText,
                style: TextStyle(fontSize: 16, color: preferedTextColor)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 10, 10, 10),
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              side: WidgetStateBorderSide.resolveWith(
                (states) => BorderSide(width: 1.5, color: preferedTextColor),
              ),
              //tileColor: preferedColor,
              value: checkboxValue,
              onChanged: callback,
            ),
          ),
        ],
      ),
    );
  }
}

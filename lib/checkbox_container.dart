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
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      decoration: BoxDecoration(
          color: preferedColor,
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          Padding(
            padding: insets,
            child: Text(checkboxText, style: const TextStyle(fontSize: 16)),
          ),
          Checkbox(
            //tileColor: preferedColor,
            value: checkboxValue,
            onChanged: callback,
          ),
        ],
      ),
    );
  }
}

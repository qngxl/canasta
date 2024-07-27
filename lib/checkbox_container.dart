// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'canasta_text.dart';
import 'global.dart';

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
          border: Border.all(
              color: preferedTextColor,
              width: 2), // ToDo: border or no border? if yes, black or white?
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: insets,
            child: CanastaText(
              checkboxText,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              side: WidgetStateBorderSide.resolveWith(
                (states) =>
                    const BorderSide(width: 2, color: preferedTextColor),
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

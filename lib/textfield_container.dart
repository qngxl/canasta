// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'canasta_text.dart';
import 'global.dart';

class TextfieldContainer extends StatelessWidget {
  const TextfieldContainer(
      {super.key,
      required this.callback,
      required this.textfieldText,
      required this.controller});

  final Function(String) callback;
  final String textfieldText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      margin: const EdgeInsets.fromLTRB(10, 19, 10, 5),
      decoration: BoxDecoration(
          color: preferedColor,
          // border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        children: [
          Padding(
            padding: insets,
            child: CanastaText(textfieldText),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 14),
              child: TextField(
                  style: TextStyle(color: preferedTextColor),
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: preferedColor,
                    //labelText: "Canasta Points",

                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  onChanged: callback),
            ),
          ),
        ],
      ),
    );
  }
}

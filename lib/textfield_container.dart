// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/foundation.dart';
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
      margin: kIsWeb? const EdgeInsets.fromLTRB(10, 16, 10, 2) : const EdgeInsets.fromLTRB(10, 19, 10, 5),
      decoration: BoxDecoration(
          color: preferedColor,
          border: Border.all(
              color: preferedTextColor,
              width: 2), // ToDo: border or no border? if yes, black or white?
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Padding(
            padding: rowInsets,
            child: CanastaText(
              textfieldText,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 14),
              child: TextField(
                  style: const TextStyle(color: preferedTextColor),
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: preferedColor,
                    //labelText: "Canasta Points",

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
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

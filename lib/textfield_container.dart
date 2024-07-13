// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

import 'team_container.dart';

class TextfieldContainer extends StatelessWidget {
 const TextfieldContainer({
    super.key,

    required this.callback,
    required this.textfieldText,
    required this.controller
  });

  
  final Function(String) callback;
  final String textfieldText;
  final TextEditingController controller;

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
            child: Text(textfieldText, style:  TextStyle(fontSize: 16, color: preferedTextColor)),
          ),
          Expanded(
            child: TextField(
                  style: TextStyle(color: preferedTextColor),
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: preferedColor,
                    //labelText: "Canasta Points",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  onChanged: callback
                  
                ),
          ),
          
        ],
      ),
    );
  }
}

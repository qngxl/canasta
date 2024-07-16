import 'package:flutter/material.dart';
import 'canasta_text.dart';
import 'global.dart';

//copied from stack overflow

class TitledContainer extends StatelessWidget {
  const TitledContainer(
      {required this.titleText, required this.child, this.insets = 8, Key? key})
      : super(key: key);
  final String titleText;
  final double insets;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          padding: EdgeInsets.all(insets),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: preferedColor, width: 2),
                  left: BorderSide(color: preferedColor, width: 2),
                  right: BorderSide(color: preferedColor, width: 2),
                  top: const BorderSide(color: Colors.transparent, width: 2)),
              borderRadius: const BorderRadius.all(Radius.circular(0))),
          child: child,
        ),
        Positioned(
          left: 10,
          right: 10,
          top: 10,
          child: Align(
            // alignment: Alignment.center,
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                  color: preferedColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: CanastaText(
                titleText,
                size: 19,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

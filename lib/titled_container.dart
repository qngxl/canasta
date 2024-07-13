import 'package:canasta/team_container.dart';
import 'package:flutter/material.dart';

//copied from stack overflow

class TitledContainer extends StatelessWidget {
  const TitledContainer(
      {required this.titleText, required this.child, this.idden = 8, Key? key})
      : super(key: key);
  final String titleText;
  final double idden;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          padding: EdgeInsets.all(idden),
          decoration: BoxDecoration(
            border: Border.all(color: preferedColor, width: 1.2),
            borderRadius: BorderRadius.circular(idden * 0.6),
          ),
          child: child,
        ),
        Positioned(
          left: 10,
          right: 10,
          top: 10,
          child: Align(
            // alignment: Alignment.center,
            child: Container(
              color: Colors.white,
              child: Text(
                titleText,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 19),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

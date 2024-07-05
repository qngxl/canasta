// ignore_for_file: prefer_const_constructors

import 'package:canasta/team.dart';
import 'package:flutter/material.dart';

class TeamContainer extends StatefulWidget {
  const TeamContainer({super.key, required this.team});
  final Team team;

  @override
  State<TeamContainer> createState() => TeamContainerState();
}

var containerHeight = 45.0;
var preferedColor = Color.fromARGB(255, 100, 224, 255);
var insets = const EdgeInsets.fromLTRB(10, 10, 20, 10);

class TeamContainerState extends State<TeamContainer> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //controller.text = "${widget.team.canastaPoints}";
    controller.text = widget.team.canastaPoints.toString();
    return TitledContainer(
      titleText:
          "${widget.team.teamName} : current: ${widget.team.getCurrentRoundPoints()}  |  total: ${widget.team.getTotalRoundPoints()}",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: SizedBox(
              height: containerHeight,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: preferedColor,
                  labelText: "Canasta Points",
                  hintText: "Enter the total amount of Canasta Points",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
                onChanged: (value) {
                  setState(() {
                    int? help = int.tryParse(value);
                    if (help != null) {
                      widget.team.canastaPoints = help;
                    } else {
                      widget.team.canastaPoints = 0;
                    }
                  });
                },
              ),
            ),
          ),
          Container(
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
                  child: Text(
                    "amount of red 3's:",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                DropdownButton(
                  dropdownColor: preferedColor,
                  items: const [
                    DropdownMenuItem(value: "0", child: Text("0")),
                    DropdownMenuItem(value: "1", child: Text("1")),
                    DropdownMenuItem(value: "2", child: Text("2")),
                    DropdownMenuItem(value: "3", child: Text("3")),
                    DropdownMenuItem(value: "4", child: Text("4")),
                    DropdownMenuItem(value: "5", child: Text("5")),
                    DropdownMenuItem(value: "6", child: Text("6")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      int? help = int.tryParse(value!);
                      if (help != null) {
                        widget.team.red3s = help;
                      } else {
                        widget.team.red3s = 0;
                      }
                    });
                  },
                  value: widget.team.red3s.toString(),
                ),
              ],
            ),
          ),
          Container(
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
                  child: const Text("51/52 cards?",
                      style: TextStyle(fontSize: 16)),
                ),
                Checkbox(

                    //tileColor: preferedColor,
                    value: widget.team.dealingBonus,
                    onChanged: (value) {
                      //ignore: avoid_print
                      print("checkBox value is $value");
                      setState(() {
                        if (value != null) {
                          widget.team.dealingBonus = value;
                        }
                      });
                    }),
              ],
            ),
          ),
          Container(
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
                  child: const Text("Closed the game?",
                      style: TextStyle(fontSize: 16)),
                ),
                Checkbox(

                    //tileColor: preferedColor,
                    value: widget.team.closingBonus,
                    onChanged: (value) {
                      // ignore: avoid_print
                      print("checkBox value is $value");
                      setState(() {
                        if (value != null) {
                          widget.team.closingBonus = value;
                        }
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
            border: Border.all(),
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

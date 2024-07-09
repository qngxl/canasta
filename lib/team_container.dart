// ignore_for_file: prefer_const_constructors

import 'package:canasta/team.dart';
import 'package:flutter/material.dart';

import 'checkbox_container.dart';
import 'titled_container.dart';

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
          CheckboxContainer(
            checkboxText: "Closed the game?",
            checkboxValue: widget.team.closingBonus,
            callback: (value) {
              setState(() {
                if (value != null) {
                  widget.team.closingBonus = value;
                }
              });
            },
          ),
          CheckboxContainer(
            checkboxText: "51/52 cards?",
            checkboxValue: widget.team.dealingBonus,
            callback: (value) {
              setState(() {
                if (value != null) {
                  widget.team.dealingBonus = value;
                }
              });
            },
          )
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:canasta/team.dart';
import 'package:flutter/material.dart';

import 'checkbox_container.dart';
import 'textfield_container.dart';
import 'titled_container.dart';

class TeamContainer extends StatefulWidget {
  const TeamContainer({super.key, required this.team});
  final Team team;

  @override
  State<TeamContainer> createState() => TeamContainerState();
}

var containerHeight = 45.0;
var preferedColor = Color.fromARGB(255, 109, 102, 209);
var preferedTextColor = Color.fromARGB(255, 255, 255, 255);
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
          const SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.all(0),
              child: TextfieldContainer(
                textfieldText: "Canasta points: ",
                controller: controller,
                callback: (value) {
                  setState(() {
                    int? help = int.tryParse(value);
                    if (help != null) {
                      widget.team.canastaPoints = help;
                    } else {
                      widget.team.canastaPoints = 0;
                    }
                  });
                },
              )),
          Container(
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
                  child: Text(
                    "amount of ${Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Playing_card_heart_3.svg/1200px-Playing_card_heart_3.svg.png")} / ${Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Playing_card_diamond_3.svg/1200px-Playing_card_diamond_3.svg.png")}",
                    style: TextStyle(fontSize: 16, color: preferedTextColor),
                  ),
                ),
                DropdownButton(
                  dropdownColor: preferedColor,
                  items: [
                    DropdownMenuItem(
                        value: "0",
                        child: Text("0",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
                    DropdownMenuItem(
                        value: "1",
                        child: Text("1",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
                    DropdownMenuItem(
                        value: "2",
                        child: Text("2",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
                    DropdownMenuItem(
                        value: "3",
                        child: Text("3",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
                    DropdownMenuItem(
                        value: "4",
                        child: Text("4",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
                    DropdownMenuItem(
                        value: "5",
                        child: Text("5",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
                    DropdownMenuItem(
                        value: "6",
                        child: Text("6",
                            style: TextStyle(
                                fontSize: 16, color: preferedTextColor))),
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
            checkboxText: "closed the game?",
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
            checkboxText: "51/52 cards?        ",
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

// ignore_for_file: prefer_const_constructors

import 'package:canasta/team.dart';
import 'package:flutter/material.dart';

import 'checkbox_container.dart';
import 'textfield_container.dart';
import 'titled_container.dart';
import 'global.dart';

class TeamContainer extends StatefulWidget {
  const TeamContainer({super.key, required this.team});
  final Team team;

  @override
  State<TeamContainer> createState() => TeamContainerState();
}

class TeamContainerState extends State<TeamContainer> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //controller.text = "${widget.team.canastaPoints}";
    controller.text = widget.team.canastaPoints.toString();
    return TitledContainer(
      titleText:
          "${widget.team.teamName} : ${widget.team.getCurrentRoundPoints()}  |  total: ${widget.team.getTotalRoundPoints()}",
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
                    "amount of red 3's:",
                    style: TextStyle(fontSize: 16, color: preferedTextColor),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconEnabledColor: preferedTextColor,
                    iconSize: 24,
                    borderRadius: BorderRadius.circular(10),
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
                ),
              ],
            ),
          ),
          CheckboxContainer(
            checkboxText: "closed the game?              ",
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
            checkboxText: "51/52 cards?                       ",
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

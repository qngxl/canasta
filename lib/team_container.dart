// ignore_for_file: prefer_const_constructors

import 'package:canasta/team.dart';
import 'package:flutter/material.dart';

import 'canasta_text.dart';
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
           TextfieldContainer(
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
              ),
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
                  child: CanastaText("amount of red 3's:"),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    iconEnabledColor: preferedTextColor,
                    iconSize: 24,
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: preferedColor,
                    items: const [
                      DropdownMenuItem(value: "0", child: CanastaText("0")),
                      DropdownMenuItem(value: "1", child: CanastaText("1")),
                      DropdownMenuItem(value: "2", child: CanastaText("2")),
                      DropdownMenuItem(value: "3", child: CanastaText("3")),
                      DropdownMenuItem(value: "4", child: CanastaText("4")),
                      DropdownMenuItem(value: "5", child: CanastaText("5")),
                      DropdownMenuItem(value: "6", child: CanastaText("6")),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
            child: CheckboxContainer(
              checkboxText: "51/52 cards?                       ",
              checkboxValue: widget.team.dealingBonus,
              callback: (value) {
                setState(() {
                  if (value != null) {
                    widget.team.dealingBonus = value;
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: avoid_print

import 'package:canasta/team.dart';
import 'package:canasta/team_container.dart';
import 'package:flutter/material.dart';

import 'checkbox_container.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Team team1 = Team("Team 1");
  Team team2 = Team("Team 2");
  int? selectedIndex;
  bool showAcumulatedRoundResults = false;
  final controller = PageController(
    initialPage: 0,
  );
  int currentPage = 0;

  // not needed anymore because team has constructor argument
  // @override
  // void initState() {
  //   team1.teamName = "Team 1";
  //   team2.teamName = "Team 2";
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Canasta Calculator"),
      ),
      endDrawer: Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 300,
          margin: const EdgeInsets.fromLTRB(0, 90, 0, 0),
          // decoration: BoxDecoration(
          //     border: Border.all(),
          //     borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (currentPage == 0) {
                          controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        } else {
                          controller.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        }
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text((currentPage == 0)
                        ? "show all results"
                        : "show calculating page")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        team1.newGame();
                        team2.newGame();
                      });
                    },
                    child: const Text("new game")),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
          onPageChanged: (value) {
            setState(() {
              selectedIndex = null;
              currentPage = value;
              //print("current value is: $value");
            });
          },
          controller: controller,
          children: [getCurrentRoundPage(), getAllRoundPage()]),
    );
  }

  SingleChildScrollView getCurrentRoundPage() {
    return SingleChildScrollView(
      child: Column(children: [
        TeamContainer(team: team1),
        TeamContainer(team: team2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ElevatedButton(
            //     onPressed: () {
            //       setState(() {
            //         team1.newGame();
            //         team2.newGame();
            //       });
            //     },
            //     child: const Text("new game")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: preferedColor),
                onPressed: () {
                  setState(() {
                    print(team1.getCurrentRoundPoints());
                    print(team2.getCurrentRoundPoints());
                    team1.saveCurrentRoundPoints();
                    team2.saveCurrentRoundPoints();
                    print(
                        "total points of team 1: ${team1.getTotalRoundPoints()}");
                    print(
                        "total points of team 2: ${team2.getTotalRoundPoints()}");
                  });
                },
                child: const Text("save round")),
          ],
        ),
      ]),
    );
  }

  List<TableRow> getRows() {
    List<TableRow> rows = [];
    rows.add(
      TableRow(
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: preferedColor),
          ),
          children: [
            const Text('Round'),
            Text(team1.teamName),
            Text(team2.teamName),
          ]),
    );
    for (var i = 0; i < team1.roundPoints.length; i++) {
      rows.add(TableRow(
          decoration: BoxDecoration(
              color:
                  selectedIndex == i ? Colors.greenAccent : Colors.transparent),
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = i;
                  });
                },
                child: Text("${i + 1}")),
            Text(
                '${showAcumulatedRoundResults ? team1.getAccumulatedRoundPoints(i) : team1.getNotAcumulatedRoundPoints(i)}'),
            Text(
                "${showAcumulatedRoundResults ? team2.getAccumulatedRoundPoints(i) : team2.getNotAcumulatedRoundPoints(i)}"),
          ]));
    }

    return rows;
  }

  SingleChildScrollView getAllRoundPage() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = null;
              });
            },
            child: Table(
              border: TableBorder.all(color: Colors.black),
              children: getRows(),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: selectedIndex == null
                ? null
                : () {
                    setState(() {
                      team1.deleteRound(selectedIndex);
                      team2.deleteRound(selectedIndex);
                    });
                  },
            child: const Text("delete selected Row")),
        CheckboxContainer(
          checkboxText: "Show acumulated total points?",
          checkboxValue: showAcumulatedRoundResults,
          callback: (value) {
            setState(() {
              if (value != null) {
                showAcumulatedRoundResults = value;
              }
            });
          },
        ),
      ]),
    );
  }
}

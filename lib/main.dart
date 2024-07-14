import 'package:canasta/team.dart';
import 'package:canasta/team_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkbox_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

late SharedPreferences prefs;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(fontFamily: "Satoshi"),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;
  Team team1 = Team("Team 1");
  Team team2 = Team("Team 2");
  int? selectedIndex;
  bool showAcumulatedRoundResults = false;
  final controller = PageController(
    initialPage: 0,
  );
  int currentPage = 0;

  @override
  void initState() {
    team1.loadRoundsFromPrefs();
    team2.loadRoundsFromPrefs();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.topLeft, end: Alignment.topRight),
            weight: 1),
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.topRight, end: Alignment.bottomRight),
            weight: 1),
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.bottomRight, end: Alignment.bottomLeft),
            weight: 1),
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.bottomLeft, end: Alignment.topLeft),
            weight: 1),
      ],
    ).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.bottomRight, end: Alignment.bottomLeft),
            weight: 1),
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.bottomLeft, end: Alignment.topLeft),
            weight: 1),
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.topLeft, end: Alignment.topRight),
            weight: 1),
        TweenSequenceItem<Alignment>(
            tween: Tween<Alignment>(
                begin: Alignment.topRight, end: Alignment.bottomRight),
            weight: 1),
      ],
    ).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: _topAlignmentAnimation.value,
                    end: _bottomAlignmentAnimation.value,
                    colors: const [
                  Color.fromARGB(255, 137, 202, 255),
                  Color.fromARGB(255, 215, 238, 253)
                ])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: preferedColor,
                foregroundColor: preferedTextColor,
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
                            style: ElevatedButton.styleFrom(
                                backgroundColor: preferedColor),
                            onPressed: () {
                              setState(() {
                                if (currentPage == 0) {
                                  controller.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                } else {
                                  controller.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text(
                                style: TextStyle(
                                    fontSize: 16, color: preferedTextColor),
                                (currentPage == 0)
                                    ? "show all results"
                                    : "show calculating page")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: preferedColor),
                            onPressed: () {
                              setState(() {
                                team1.newGame();
                                team2.newGame();
                              });
                            },
                            child: Text("new game",
                                style: TextStyle(
                                    fontSize: 16, color: preferedTextColor))),
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
                    });
                  },
                  controller: controller,
                  children: [getCurrentRoundPage(), getAllRoundPage()]),
            ),
          );
        });
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
                    team1.saveCurrentRoundPoints();
                    team2.saveCurrentRoundPoints();
                  });
                },
                child: Text(
                  "save round",
                  style: TextStyle(color: preferedTextColor),
                )),
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
              color: selectedIndex == i ? preferedColor : Colors.transparent),
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
          color: Colors.transparent,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: preferedColor),
              onPressed: selectedIndex == null
                  ? null
                  : () {
                      setState(() {
                        team1.deleteRound(selectedIndex);
                        team2.deleteRound(selectedIndex);
                      });
                    },
              child: Text("delete selected Row",
                  style: TextStyle(fontSize: 16, color: preferedTextColor))),
        ),
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

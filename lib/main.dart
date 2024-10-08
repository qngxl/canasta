import 'package:canasta/canasta_button.dart';
import 'package:canasta/rounds_chart.dart';
import 'package:canasta/team.dart';
import 'package:canasta/team_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkbox_container.dart';
import 'canasta_text.dart';
import 'global.dart';

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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            "assets/images/canasta_icon.jpg",
                            height: 50,
                            width: 50,
                          )),
                      const CanastaText(
                        "Canasta Calculator",
                        size: 22,
                      ),
                    ],
                  )),
              endDrawer: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: _topAlignmentAnimation.value,
                          end: _bottomAlignmentAnimation.value,
                          colors: const [
                            Color.fromARGB(255, 137, 202, 255),
                            Color.fromARGB(255, 215, 238, 253)
                          ])),
                  height: 300,
                  margin: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                  // decoration: BoxDecoration(
                  //     border: Border.all(),
                  //     borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: Drawer(
                    backgroundColor: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CanastaButton(
                          buttonText: (currentPage == 0)
                              ? "show all results"
                              : "show calculating page",
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
                        ),
                        CanastaButton(
                          buttonText: "new game",
                          onPressed: () {
                            setState(() {
                              team1.newGame();
                              team2.newGame();
                            });
                          },
                        ),
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
        TeamContainer(
          team: team1,
          // headlineColor: team1Color,
          headlineColor: preferedTextColor, // ToDo: white color or team1Color?
        ),
        TeamContainer(
          team: team2,
          // headlineColor: team2Color,
          headlineColor: preferedTextColor, // ToDo: white color or team2Color?
        ),
        CanastaButton(
          buttonText: "save round",
          onPressed: () {
            setState(() {
              team1.saveCurrentRoundPoints();
              team2.saveCurrentRoundPoints();
            });
          },
        )
      ]),
    );
  }

  List<TableRow> getRows() {
    List<TableRow> rows = [];
    rows.add(
      TableRow(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: preferedTextColor, width: 2))),
          children: [
            const CanastaText("Round"),
            // CanastaText(team1.teamName, color: team1Color),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CanastaText(team1.teamName, color: preferedTextColor),
                Container(
                  height: 15,
                  width: 15,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: team1Color,
                      borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CanastaText(team2.teamName, color: preferedTextColor),
                Container(
                  height: 15,
                  width: 15,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: team2Color,
                      borderRadius: BorderRadius.circular(10)),
                )
              ],
            ),
          ]),
    );
    for (var i = 0; i < team1.roundPoints.length; i++) {
      rows.add(TableRow(
          decoration: BoxDecoration(
              color: selectedIndex == i ? Colors.red : Colors.transparent,
              // border: Border.all(color: preferedTextColor, width: 1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      i == (team1.roundPoints.length - 1) ? 10 : 0),
                  bottomRight: Radius.circular(
                      i == (team1.roundPoints.length - 1) ? 10 : 0))),
          // ToDo : when selecting last line borders are not round
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = i;
                  });
                },
                child: CanastaText("${i + 1}")),
            // CanastaText(
            //     '${showAcumulatedRoundResults ? team1.getAccumulatedRoundPoints(i) : team1.getNotAcumulatedRoundPoints(i)}',
            //     color: team1Color),
            CanastaText(
                '${showAcumulatedRoundResults ? team1.getAccumulatedRoundPoints(i) : team1.getNotAcumulatedRoundPoints(i)}',
                color: preferedTextColor),

            // CanastaText(
            //     "${showAcumulatedRoundResults ? team2.getAccumulatedRoundPoints(i) : team2.getNotAcumulatedRoundPoints(i)}",
            //     color: team2Color),
            CanastaText(
                "${showAcumulatedRoundResults ? team2.getAccumulatedRoundPoints(i) : team2.getNotAcumulatedRoundPoints(i)}",
                color:
                    preferedTextColor), // ToDo: preferedTextColor or team1Color/team2Color?
          ]));
    }

    return rows;
  }

  SingleChildScrollView getAllRoundPage() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          color: Colors.transparent,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: preferedColor, borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: preferedTextColor,
                  width: 2), // ToDo: border or no border?
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = null;
                });
              },
              child: Table(
                border: TableBorder.all(
                  color: preferedTextColor, // Done: grey better?
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                children: getRows(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
          child: CanastaButton(
            buttonText: "delete selected row",
            onPressed: selectedIndex == null
                ? null
                : () {
                    setState(() {
                      team1.deleteRound(selectedIndex);
                      team2.deleteRound(selectedIndex);
                    });
                  },
          ),
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
        RoundsChart(team1: team1, team2: team2)
      ]),
    );
  }
}

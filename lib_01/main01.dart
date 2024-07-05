// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

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
  String userName = "";
  String userAddress = "";
  String userEMail = "";
  bool? checkboxValue2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Registration Form"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TitledContainer(
            titleText: "Team 1",
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(245, 243, 129, 1),
                      labelText: "Canasta Points",
                      hintText: "Enter the total amount of Canasta Points",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromRGBO(245, 243, 129, 1),
                      labelText: "red 3s",
                      hintText: "Enter the amount of red 3s",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userAddress = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text("500 point bonus?"),
                      tileColor: const Color.fromRGBO(245, 243, 129, 1),
                      value: checkboxValue2,
                      onChanged: (value) {
                        print("checkBox value is $value");
                        setState(() {
                          checkboxValue2 = value;
                        });
                      }),
                ),
              ],
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Register")),
        ]),
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
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 300),
          padding: EdgeInsets.all(idden),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(idden * 0.6),
          ),
          child: child,
        ),
        Positioned(
          left: 20,
          right: 10,
          top: 10,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.white,
              child: Text(
                titleText,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

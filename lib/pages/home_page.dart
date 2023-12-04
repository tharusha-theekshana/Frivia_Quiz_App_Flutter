import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frivia_quiz_app/pages/game_page.dart';
import 'package:frivia_quiz_app/util/category.dart';

List<Category> categoryfromjson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categorytojson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double deviceHeight, deviceWidth;
  double difficultLevel = 0;
  List<String> difficult = ["Easy", "Medium", "Hard"];
  Category? _selectedValue;

  static String jsonStr = '''
  [
    {"name": "General Knowledge" , "value" : 9 },
    {"name": "Entertainment: Books" , "value" : 10 },
    {"name": "Entertainment: Films" , "value" : 11 },
    {"name": "Entertainment: Music" , "value" : 12 },
    {"name": "Entertainment: Video Games" , "value" : 15 },
    {"name": "Entertainment: Cartoons" , "value" : 32 },
    {"name": "Science and Nature" , "value" : 17 },
    {"name": "Vehicles" , "value" : 28 },
    {"name": "Animals" , "value" : 27 },
    {"name": "Politics" , "value" : 24 },
    {"name": "History" , "value" : 23 },
    {"name": "Sports" , "value" : 21 },
    {"name": "Art" , "value" : 25 }
  ]
  ''';

  List<Category> categoryList = categoryfromjson(jsonStr);

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        width: deviceWidth,
        height: deviceHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              appTitle(),
              difficultText(),
              slider(level: difficultLevel),
              appTitle2(),
              categoryDropDownButton(),
              startButton(),
              exitButton()
            ],
          ),
        ),
      )),
    );
  }

  Widget appTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: deviceHeight * 0.05),
      child: const Text(
        "Select difficult",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
      ),
    );
  }

  Widget appTitle2() {
    return Container(
      margin: EdgeInsets.only(
          bottom: deviceHeight * 0.05, top: deviceHeight * 0.08),
      child: const Text(
        "Select Category",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),
      ),
    );
  }

  Widget difficultText() {
    if (difficultLevel == 0) {
      return Text(
        difficult[0],
        style: const TextStyle(
            color: Colors.green, fontSize: 35.0, fontWeight: FontWeight.bold),
      );
    } else if (difficultLevel == 1) {
      return Text(
        difficult[1],
        style: const TextStyle(
            color: Colors.yellow, fontSize: 35.0, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        difficult[2],
        style: const TextStyle(
            color: Colors.red, fontSize: 35.0, fontWeight: FontWeight.bold),
      );
    }
  }

  Widget slider({required double level}) {
    if (level == 0) {
      return Slider(
          min: 0,
          max: 2,
          divisions: 2,
          activeColor: Colors.green,
          value: difficultLevel,
          onChanged: (value) {
            setState(() {
              difficultLevel = value;
              print(difficultLevel);
            });
          });
    } else if (level == 1) {
      return Slider(
          min: 0,
          max: 2,
          divisions: 2,
          activeColor: Colors.yellow,
          value: difficultLevel,
          onChanged: (value) {
            setState(() {
              difficultLevel = value;
              print(difficultLevel);
            });
          });
    } else {
      return Slider(
          min: 0,
          max: 2,
          divisions: 2,
          activeColor: Colors.red,
          value: difficultLevel,
          onChanged: (value) {
            setState(() {
              difficultLevel = value;
              print(difficultLevel);
            });
          });
    }
  }

  Widget categoryDropDownButton() {
    return Container(
      alignment: Alignment.center,
      child: DropdownButton<Category>(
        onChanged: (value) {
          setState(() {
            _selectedValue = value;
          });
        },
        items: categoryList.map<DropdownMenuItem<Category>>((Category value) {
          return DropdownMenuItem<Category>(
              value: value, child: Center(child: Text(value.name)));
        }).toList(),
        hint: const Text("Select Category"),
        icon: Padding(
          padding: EdgeInsets.only(left: deviceWidth * 0.08),
          child: const Icon(Icons.arrow_drop_down),
        ),
        value: _selectedValue,
        underline: Container(),
      ),
    );
  }

  Widget startButton() {
    if (_selectedValue == null) {
      return Container(
        width: deviceWidth * 0.3,
        height: deviceHeight * 0.05,
        margin: EdgeInsets.only(top: deviceHeight * 0.15),
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            color: Colors.black87,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: Colors.red,
                      elevation: 0.0,
                      icon: const Icon(
                        Icons.warning_amber,
                        color: Colors.white70,
                      ),
                      content: const Text(
                        "Please Select a Category",
                        style: TextStyle(color: Colors.white70, fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        Center(
                          child: MaterialButton(
                            color: Colors.white,
                            height: deviceHeight * 0.03,
                            minWidth: deviceWidth * 0.1,
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )),
      );
    } else {
      return Container(
        width: deviceWidth * 0.3,
        height: deviceHeight * 0.05,
        margin: EdgeInsets.only(top: deviceHeight * 0.15),
        child: MaterialButton(
            color: Colors.black38,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GamePage(
                        difficulty:
                            difficult[difficultLevel.toInt()].toLowerCase(),
                        categoryValue: _selectedValue!.value),
                  ));
            },
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )),
      );
    }
  }

  Widget exitButton() {
    return Container(
      width: deviceWidth * 0.3,
      height: deviceHeight * 0.05,
      margin: EdgeInsets.only(top: deviceHeight * 0.01),
      child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: Colors.blue,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: Colors.red,
                    icon: const Icon(
                      Icons.warning_amber,
                      color: Colors.white,
                    ),
                    title: const Text(
                      "Are you want to Exit ?",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MaterialButton(
                            minWidth: deviceWidth * 0.1,
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            height: deviceHeight * 0.03,
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          MaterialButton(
                            minWidth: deviceWidth * 0.1,
                            color: Colors.white,
                            onPressed: () {
                              exit(0);
                            },
                            height: deviceHeight * 0.03,
                            child: const Text(
                              "Ok",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                });
          },
          child: const Text(
            "Quit",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          )),
    );
  }
}

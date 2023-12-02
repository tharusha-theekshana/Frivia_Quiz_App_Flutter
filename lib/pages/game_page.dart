import 'package:flutter/material.dart' hide Colors;
import 'package:frivia_quiz_app/pages/home_page.dart';
import 'package:frivia_quiz_app/providers/game_page_provider.dart';
import 'package:frivia_quiz_app/util/category.dart';
import 'package:frivia_quiz_app/util/colors.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  late double deviceHeight, deviceWidth;

  GamePageProvider? _gamePageProvider;
  late final String difficulty;
  late final int categoryValue;

  GamePage({required this.difficulty, required this.categoryValue});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
        create: (_context) => GamePageProvider(
            context: _context,
            difficulty: difficulty,
            categoryValue: categoryValue),
        child: buildUi());
  }

  Widget buildUi() {
    return Builder(builder: (_context) {
      _gamePageProvider = _context.watch<GamePageProvider>();
      if (_gamePageProvider!.question != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
                width: deviceWidth, height: deviceHeight, child: gameUi()),
          ),
          floatingActionButton: IconButton(
              onPressed: () {
                showDialog(
                  context: _context,
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
                        "Are you want to go Home Screen ?",
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ));
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
                  },
                );
              },
              icon: Icon(Icons.home)),
        );
      } else {
        return Container(
          height: deviceHeight,
          width: deviceWidth,
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.secondaryColor,
            ),
          ),
        );
      }
    });
  }

  Widget gameUi() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [questionText(), answerButtons()],
    );
  }

  Widget questionText() {
    if (_gamePageProvider!.getCurrentQuestionText() !=
        "No questions available") {
      return Padding(
        padding: EdgeInsets.only(
            left: deviceWidth * 0.05, right: deviceWidth * 0.05),
        child: Text(
          _gamePageProvider!.getCurrentQuestionText(),
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.secondaryColor,
              fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _gamePageProvider!.getCurrentQuestionText(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 40,
                color: Colors.secondaryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: deviceHeight * 0.1,
          ),
          const Text(
            "Please change difficult level and category , and Try Again !",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          )
        ],
      );
    }
  }

  Widget answerButtons() {
    if (_gamePageProvider!.getCurrentQuestionText() !=
        "No questions available") {
      return Column(
        children: [
          trueButton(),
          SizedBox(
            height: deviceHeight * 0.03,
          ),
          falseButton(),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget trueButton() {
    return Container(
      width: deviceWidth * 0.4,
      height: deviceHeight * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
      ),
      child: MaterialButton(
        onPressed: () {
          _gamePageProvider!.answerQuestion("True");
        },
        child: const Text(
          "True",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget falseButton() {
    return Container(
      width: deviceWidth * 0.4,
      height: deviceHeight * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.red,
      ),
      child: MaterialButton(
        onPressed: () {
          _gamePageProvider!.answerQuestion("False");
        },
        child: const Text(
          "False",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

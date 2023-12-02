import 'package:flutter/material.dart' hide Colors;
import 'package:frivia_quiz_app/util/colors.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../pages/home_page.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  late double deviceWidth, deviceHeight;

  BuildContext context;

  final int _maxQuestions = 10;
  int? categoryValue;
  List? question;
  int currentQuestionCount = 0;
  int correctCount = 0;
  String? difficulty;

  GamePageProvider({required this.context,
    required this.difficulty,
    required this.categoryValue}) {
    _dio.options.baseUrl = 'https://opentdb.com/api.php';
    getQuestionsFromApi();
  }

  Future<void> getQuestionsFromApi() async {
    var _response = await _dio.get('', queryParameters: {
      'amount': _maxQuestions,
      'category': categoryValue,
      'difficulty': difficulty,
      'type': 'boolean'
    });

    var _data = jsonDecode(_response.toString());

    question = _data['results'];
    notifyListeners();
  }

  String getCurrentQuestionText() {
    if (question != null && question!.isNotEmpty) {
      String quiz = question![currentQuestionCount]["question"];
      String newQuiz = quiz.replaceAll("&quot;", "");
      String filterQuiz = newQuiz.replaceAll("&#039;", "");
      return filterQuiz;
    } else {
      // Handle the case when the question list is null or empty
      return "No questions available";
    }
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        question![currentQuestionCount]["correct_answer"] == answer;
    currentQuestionCount++;
    correctCount += isCorrect ? 1 : 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: isCorrect
              ? const Text("Answer is correct ... !", style: TextStyle(
              color: Colors.white
          ),)
              : const Text("Answer is Wrong ... !", style:  TextStyle(
              color: Colors.white
          ),),
        icon: isCorrect ? const Icon(Icons.check_circle, color: Colors.white) : const Icon(Icons.cancel_sharp , color: Colors.white)
        ,
        );
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pop(context);
    if (currentQuestionCount == _maxQuestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  void endGame() async {
    deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text("End Quiz",
                style: TextStyle(
                    color: Colors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0)),
          ),
          content: Container(
            padding: EdgeInsets.only(top: deviceHeight * 0.01),
            height: deviceHeight * 0.08,
            child: Column(
              children: [
                Text("$correctCount / $_maxQuestions",
                    textAlign: TextAlign.center),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.01),
                  child: Text("Score : ${correctCount * 10}" , style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: correctCount >= 5 ? Colors.green : Colors.red
                  ),),
                )
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: MaterialButton(
                color: Colors.secondaryColor,
                height: deviceHeight * 0.03,
                minWidth: deviceWidth * 0.1,
                child: const Text(
                  'OK',
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

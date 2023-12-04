import 'package:flutter/material.dart' hide Colors;
import 'package:frivia_quiz_app/pages/splash_page.dart';
import 'package:frivia_quiz_app/util/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primaryColor: Colors.primaryColor
      ),
      home: SplashPage(),
    );
  }
}




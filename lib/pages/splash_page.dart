import 'dart:async';

import 'package:frivia_quiz_app/pages/home_page.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:frivia_quiz_app/util/colors.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late double _deviceWidth, _deviceHeight;

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(seconds:5), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frivia',
      home: Stack(children: [
        Container(
          height: _deviceHeight,
          width: _deviceWidth,
          color: Colors.white,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: _deviceHeight * 0.25,
                width: _deviceWidth * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/logo.png'))),
              ),
              const CircularProgressIndicator(
                color: Colors.secondaryColor
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

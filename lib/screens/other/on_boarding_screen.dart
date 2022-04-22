// ignore_for_file: prefer_const_constructors

import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/authentication/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    final pageList = [
      PageModel(
        color: const Color(0xFF678FB4),
        heroImagePath: 'assets/images/quiz.png',
        title: Text('Trắc nghiệm',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Những bài trắc nghiệm để hiểu rõ bản thân hơn',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        icon: Icon(Icons.gamepad_outlined, color: const Color(0xFF9B90BC)),
      ),
      PageModel(
          color: const Color(0xFF65B0B4),
          heroImagePath: 'assets/images/information.png',
          title: Text('Thông tin',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 34.0,
              )),
          body: Text(
              'Những thông tin mới về các nghề liên quan tới công nghệ thông tin',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          icon: Icon(Icons.work_outline, color: const Color(0xFF9B90BC))),
      PageModel(
          color: const Color(0xFF9B90BC),
          heroImagePath: 'assets/images/news.png',
          title: Text('Tin tức',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 34.0,
              )),
          body: Text(
              'Những tin tức mới nhất liên quan tới ngành Công nghệ thông tin',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          icon: Icon(Icons.newspaper_outlined, color: const Color(0xFF9B90BC))),
      // SVG Pages Example
      PageModel(
          color: const Color(0xFF678FB4),
          heroImagePath: 'assets/images/answer.png',
          title: Text('Giải đáp',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontSize: 34.0,
              )),
          body: Text(
              'Giải đáp những thắc mắc của mọi người về ngành Công nghệ thông tin',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          icon: Icon(Icons.question_answer, color: const Color(0xFF9B90BC))),
    ];

    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Kết thúc",
        skipButtonText: "Bỏ qua",
        pageList: pageList,
        onDoneButtonPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Get.offAll(SignInScreen());
        },
        onSkipButtonPressed: () => Get.offAll(SignInScreen()),
      ),
    );
  }
}

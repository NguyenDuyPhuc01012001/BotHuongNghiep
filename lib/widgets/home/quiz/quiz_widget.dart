// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/screens/home/test/quiz_screen.dart';
import 'package:huong_nghiep/screens/home/test/score_screen.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/styles.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeValue = MediaQuery.of(context).platformBrightness;
    final quizStream = FirebaseHandler.getListQuiz();
    return StreamBuilder<QuerySnapshot>(
        stream: quizStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }
          var lQuiz = snapshot.data!.docs.map((doc) => doc.id).toList();
          return Scaffold(
            backgroundColor: themeValue == Brightness.dark
                ? Color(0xff262626)
                : Color(0xffFFFFFF),
            body: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: QuizContainer(lQuiz: lQuiz, type: "MBTI"),
                ),
                Expanded(
                  flex: 1,
                  child: QuizContainer(lQuiz: lQuiz, type: "Holland"),
                ),
              ],
            ),
          );
        });
  }
}

class QuizContainer extends StatelessWidget {
  final List<String> lQuiz;
  final String type;

  const QuizContainer({Key? key, required this.lQuiz, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => lQuiz.contains(type)
          ? Get.to(ScoreScreen(type: type))
          : Get.to(QuizScreen(type: type)),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: lQuiz.contains(type) ? kgDone : kgNotDone,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type == "MBTI" ? '70' : '54',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white, fontSize: 30),
                ),
                Icon(
                  type == "MBTI"
                      ? Icons.tag_faces_sharp
                      : Icons.business_center_outlined,
                  color: Colors.white,
                  size: 40,
                )
              ],
            ),
            Text(
              type,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              type == "MBTI"
                  ? 'Tìm hiểu tính cách bản thân'
                  : 'Định hướng nghề phù hợp',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white, fontSize: h3),
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}

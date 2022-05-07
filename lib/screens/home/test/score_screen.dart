// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:huong_nghiep/screens/home/test/quiz_screen.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/widgets/alert.dart';
import 'package:huong_nghiep/widgets/home/quiz/explanation.dart';

class ScoreScreen extends StatelessWidget {
  String resultKey = "";
  int resultValue = 0;
  final String type;
  ScoreScreen({Key? key, required this.type}) : super(key: key);

  void getScore(String type, Map<String, dynamic> sc) {
    if (type == "MBTI") {
      // List<dynamic> lScore = sc.values.toList();
      // print(lScore);
      resultKey = "";
      sc['E'] > sc['I'] ? resultKey += "E" : resultKey += "I";
      sc['S'] > sc['N'] ? resultKey += "S" : resultKey += "N";
      sc['T'] > sc['F'] ? resultKey += "T" : resultKey += "F";
      sc['J'] > sc['P'] ? resultKey += "J" : resultKey += "P";
    } else {
      // type= "Holland"
      sc.forEach((k, v) {
        int value = v as int;
        if (value > resultValue) {
          resultValue = value;
          resultKey = k;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final quizStream = FirebaseHandler.getListQuizScore(type);

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Get.to(HomeScreen()),
      //   ),
      //   backgroundColor: kcPrimaryColor,
      //   elevation: 0,
      // ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: quizStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) print('Something went Wrong');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              try {
                Map<String, dynamic> sc =
                    snapshot.data!.data() as Map<String, dynamic>;
                getScore(type, sc);
                return SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: kgPrimaryBackgroundGradient,
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(top: 30, left: 10),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Kết quả kiểm tra, bạn là:",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          resultKey,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.white),
                        ),
                        GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: ((size.width / 2) / 50),
                            controller:
                                ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: getListScore(sc, type)),
                        verticalSpaceTiny,
                        // ListView(
                        //     shrinkWrap: true, children: getListExplanation()),
                        ExplanationContainer(type: type, resultKey: resultKey),
                        verticalSpaceSmall,
                        SizedBox(
                          width: size.width / 2,
                          child: ElevatedButton(
                              onPressed: () => Alerts().confirm(
                                      'Bạn có chắc chắn muốn làm lại bài kiểm tra\n',
                                      'Đồng ý',
                                      'Hủy', () {
                                    Get.back();
                                    Get.off(QuizScreen(type: type));
                                  }, () => Get.back(), context),
                              child: Text(
                                "Làm lại kiểm tra",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kcPrimaryColor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )))),
                        ),
                        verticalSpaceSmall,
                      ],
                    ),
                  ),
                );
              } catch (e) {
                print(e);
              }
            }
            print('Something went Wrong');
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }),
    );
  }

  List<Widget> getListScore(Map scMap, String type) {
    List<Widget> children = [];
    if (type == "MBTI") {
      children.add(getScoreContainer('E', '${scMap['E']}'));
      children.add(getScoreContainer('I', '${scMap['I']}'));
      children.add(getScoreContainer('S', '${scMap['S']}'));
      children.add(getScoreContainer('N', '${scMap['N']}'));
      children.add(getScoreContainer('T', '${scMap['T']}'));
      children.add(getScoreContainer('F', '${scMap['F']}'));
      children.add(getScoreContainer('J', '${scMap['J']}'));
      children.add(getScoreContainer('P', '${scMap['P']}'));
    } else {
      scMap.forEach((k, v) => children.add(getScoreContainer(k, v.toString())));
    }
    return children;
  }

  Widget getScoreContainer(String title, String score) {
    return Center(
      child: Container(
        child: Text(
          '$title: $score',
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 25, color: kWhite90),
        ),
      ),
    );
  }
}

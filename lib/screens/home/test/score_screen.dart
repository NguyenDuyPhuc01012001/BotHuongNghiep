import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:huong_nghiep/screens/home/test/quiz_screen.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huong_nghiep/widgets/alert.dart';
import 'package:huong_nghiep/widgets/home/quiz/explanation.dart';
import 'package:provider/provider.dart';

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
        if (v > resultValue) {
          resultValue = v;
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.to(HomeScreen()),
        ),
        backgroundColor: kcPrimaryColor,
        elevation: 0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: quizStream,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) print('Something went Wrong');
            // print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              try {
                Map<String, dynamic> sc =
                    snapshot.data!.data() as Map<String, dynamic>;
                // print("vo6 r ne");
                getScore(type, sc);
                return SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: kgPrimaryBackgroundGradient,
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        verticalSpaceLarge,
                        Text(
                          "Kết quả kiểm tra, bạn là:",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: kSecondaryColor),
                        ),
                        Text(
                          "$resultKey",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: kSecondaryColor),
                        ),
                        GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: ((size.width / 2) / 50),
                            controller:
                                new ScrollController(keepScrollOffset: false),
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
    } else
      scMap.forEach((k, v) => children.add(getScoreContainer(k, v)));
    return children;
  }

  Widget getScoreContainer(String title, String score) {
    return Center(
      child: Container(
        child: Text(
          '$title: $score',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
        ),
      ),
    );
  }

  List<Widget> getListExplanation() {
    List<Widget> children = [];
    if (resultKey.length > 1)
      for (int i = 0; i < resultKey.length; i++)
        children.add(getExplanationContainer(resultKey[i], resultKey[i]));
    // else

    return children;
  }

  Widget getExplanationContainer(String title, String explanation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: new Color.fromRGBO(255, 0, 0, 0.5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '$title: ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Text(
          '$explanation',
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
      ]),
    );
  }
}

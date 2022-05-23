// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/home/manage/question_manage_body.dart';

class QuestionSolutionScreen extends StatefulWidget {
  const QuestionSolutionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionSolutionScreen> createState() => _QuestionSolutionScreenState();
}

class _QuestionSolutionScreenState extends State<QuestionSolutionScreen> {
  bool descending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Quản lý giải đáp thắc mắc".capitalize!,
            style: kDefaultTextStyle.copyWith(
                fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
            textAlign: TextAlign.center),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                descending = !descending;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  color: Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: Icon(MdiIcons.sort),
            ),
          ),
          horizontalSpaceSmall
        ],
      ),
      extendBodyBehindAppBar: true,
      body: QuestionManageBody(
        descending: false,
      ),
    );
  }
}

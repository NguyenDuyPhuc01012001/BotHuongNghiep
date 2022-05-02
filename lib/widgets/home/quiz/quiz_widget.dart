// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/test/quiz_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeValue = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor:
          themeValue == Brightness.dark ? Color(0xff262626) : Color(0xffFFFFFF),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => Get.to(QuizScreen(type: "MBTI")),
              // onTap: () {
              // QuizAlerts().confirm('This quiz contains 10 question\n', 'Proceed', 'Cancel', () => controller.goToQuiz(), () => Get.back(), context);
              // },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffff0f7b),
                      Color(0xfff89b29),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '70',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white, fontSize: 30),
                        ),
                        Icon(
                          Icons.tag_faces_sharp,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    Text(
                      'MBTI',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Tìm hiểu tính cách bản thân',
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
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              // onTap: () {
              // QuizAlerts().confirm('This quiz contains 10 question\n', 'Proceed', 'Cancel', () => controller.goToQuiz(), () => Get.back(), context);
              // },
              onTap: () => Get.to(QuizScreen(type: "Holland")),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xff56ab2f),
                      Color(0xffa8e063),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '54',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white, fontSize: 30),
                        ),
                        Icon(
                          Icons.business_center_outlined,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    Text(
                      'Holland',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      'Định hướng nghề phù hợp',
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
            ),
          ),
        ],
      ),
    );
  }
}

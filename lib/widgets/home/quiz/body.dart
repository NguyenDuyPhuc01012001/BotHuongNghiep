// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/controllers/question_controller.dart';
import 'package:huong_nghiep/models/tests/question.dart';

// import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatefulWidget {
  final String type;
  const Body({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  QuestionController _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
        future: LoadDataFromJson.loadQuestionData(context, widget.type),
        builder: (context, snapshot) {
          final _questions = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Some error occurred!'));
              } else {
                _questionController.qLength = _questions!.length;
                _questionController.type = widget.type;
                return Stack(
                  children: [
                    // SvgPicture.asset("assets/images/bg.svg", fit: BoxFit.fill),
                    SafeArea(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: kgPrimaryBackgroundGradient,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              child: Text("Chọn đáp án phù hợp nhất với bạn"),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding),
                              child: Obx(
                                () => Text.rich(
                                  TextSpan(
                                    text:
                                        "Question ${_questionController.questionNumber.value}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: kSecondaryColor),
                                    children: [
                                      TextSpan(
                                        text: "/${_questionController.qLength}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(color: kSecondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(thickness: 1.5),
                            SizedBox(height: kDefaultPadding),
                            Expanded(
                              child: PageView.builder(
                                // Block swipe to next qn
                                physics: NeverScrollableScrollPhysics(),
                                controller: _questionController.pageController,
                                onPageChanged:
                                    _questionController.updateTheQnNum,
                                itemCount: _questionController.qLength,
                                itemBuilder: (context, index) =>
                                    QuestionCard(question: _questions[index]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
          }
        });
  }
}

// return Stack(
//             children: [
//               // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
//               SafeArea(
//                 child:
//                     // _questionController.questions == null
//                     //     ? Container()
//                     //     :
//                     //             Obx(() => _questionController.isLoading
//                     // ? Container()
//                     // :
//                     Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: kDefaultPadding),
//                       child: Text("Chọn đáp án phù hợp nhất với bạn"),
//                     ),
//                     const SizedBox(height: kDefaultPadding),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: kDefaultPadding),
//                       child: Obx(
//                         () => Text.rich(
//                           TextSpan(
//                             text:
//                                 "Question ${_questionController.questionNumber.value}",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline4!
//                                 .copyWith(color: kSecondaryColor),
//                             children: [
//                               TextSpan(
//                                 text: "/${_questions!.length}",
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline5!
//                                     .copyWith(color: kSecondaryColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Divider(thickness: 1.5),
//                     SizedBox(height: kDefaultPadding),
//                     Expanded(
//                       child: PageView.builder(
//                         // Block swipe to next qn
//                         physics: NeverScrollableScrollPhysics(),
//                         controller: _questionController.pageController,
//                         onPageChanged: _questionController.updateTheQnNum,
//                         itemCount: _questions!.length,
//                         itemBuilder: (context, index) =>
//                             QuestionCard(question: _questions[index]),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );

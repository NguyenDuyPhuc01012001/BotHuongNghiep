import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatelessWidget {
  getScore(List<int> lAnswers) {
    for (int i = 0; i < 2; i++) {
      print(lAnswers[i]);
    }
    for (int i = 2; i < lAnswers.length; i++) {
      print("rest answers ${lAnswers[i]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final _quizProvider = Provider.of<QuizProvider>(context);
    getScore(_quizProvider.lAnswers);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "${10}/${_quizProvider.questions.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}

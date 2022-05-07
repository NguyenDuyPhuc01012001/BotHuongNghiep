import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/controllers/question_controller.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/widgets/home/quiz/body.dart';
import 'package:provider/provider.dart';

// import '../../quiz/components/body.dart';

class QuizScreen extends StatelessWidget {
  final String type;
  const QuizScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _quizProvider = Provider.of<QuizProvider>(context);
    // _quizProvider.type = type;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: kcPrimaryColor,
        elevation: 0,
      ),
      body: Body(type: type),
    );
  }
}

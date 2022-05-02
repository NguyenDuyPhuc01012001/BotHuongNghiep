import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/controllers/question_controller.dart';
import 'package:huong_nghiep/widgets/home/quiz/body.dart';

// import '../../quiz/components/body.dart';

class QuizScreen extends StatelessWidget {
  final String type;
  const QuizScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    _controller.type = type;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Body(),
    );
  }
}

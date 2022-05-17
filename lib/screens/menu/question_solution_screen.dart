// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../widgets/home/manage/question_manage_body.dart';

class QuestionSolutionScreen extends StatefulWidget {
  const QuestionSolutionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionSolutionScreen> createState() => _QuestionSolutionScreenState();
}

class _QuestionSolutionScreenState extends State<QuestionSolutionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lí giải đáp thắc mắc'),
      ),
      body: QuestionManageBody(),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:huong_nghiep/widgets/home/answer/list_answer_widget.dart';
import 'package:huong_nghiep/widgets/home/answer/request_widget.dart';

class QuestionAnswerWidget extends StatelessWidget {
  const QuestionAnswerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 8),
              ResquestWidget(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.trending_flat),
                    SizedBox(width: 8),
                    Text(
                      "Danh sách câu hỏi",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              ListAnswerWidget(),
            ]),
          ),
        ),
      ),
    );
  }
}

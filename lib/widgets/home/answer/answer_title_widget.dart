// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:huong_nghiep/model/answer.dart';

import '../../../utils/styles.dart';
import '../../custom/custom_shape.dart';

class AnswerTitleWidget extends StatelessWidget {
  const AnswerTitleWidget({
    Key? key,
    required this.answer,
  }) : super(key: key);

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipOval(
                child: Image.network(
                  answer.sourceImage!,
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 8),
              Text(answer.source!, style: kItemText),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(answer.answer!,
                      style: kContentText.copyWith(
                          fontWeight: FontWeight.normal, color: Colors.white)),
                ),
              ),
              CustomPaint(painter: CustomShape(Colors.blue[400]!)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: Text(
              "Đã trả lời vào lúc ${answer.time!}",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

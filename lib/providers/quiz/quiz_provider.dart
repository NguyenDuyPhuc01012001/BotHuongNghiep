// ignore_for_file: prefer_final_fields, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:huong_nghiep/models/tests/explanation.dart';
// import 'package:huong_nghiep/models/tests/Questions.dart';
import 'package:huong_nghiep/models/tests/question.dart';

class LoadDataFromJson {
  static String _dataPath = "assets/data.json";
  List<Question> _questions = <Question>[];

  List<Question> get questions => _questions;

  // Load data, convert to List of Model
  static Future<List<Question>> loadQuestionData(
      BuildContext context, String type) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final dataString = await assetBundle.loadString(_dataPath);
    Map<String, dynamic> jsonQuestionData = jsonDecode(dataString);

    print('load thành công!');
    return QuestionList.fromJson(jsonQuestionData[type]).questions;
  }
}

class LoadExplanationFromJson {
  static String _dataPath = "assets/explanation.json";
  List<Explanation> _explanations = <Explanation>[];

  List<Explanation> get questions => _explanations;

  // Load data, convert to List of Model
  static Future<List<Explanation>> loadExplanationData(
      BuildContext context, String type) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final dataString = await assetBundle.loadString(_dataPath);
    Map<String, dynamic> jsonExplanationData = jsonDecode(dataString);

    print('load thành công!');
    print(jsonExplanationData[type]);
    return ExplanationList.fromJson(jsonExplanationData[type]).explanations;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:huong_nghiep/models/tests/Questions.dart';
import 'package:huong_nghiep/models/tests/questions.dart';
import 'package:huong_nghiep/screens/home/test/score_screen.dart';

class QuizProvider extends ChangeNotifier {
// Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController = PageController();
  PageController get pageController => this._pageController;

  String _type = "";
  String get type => this._type;
  set type(String value) => this._type = value;

  // late List<Question> _questions;
  List<Question> _questions = <Question>[];
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  List<int> _lAnswers = <int>[];
  List<int> get lAnswers => this._lAnswers;

  readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    print(data);
    // data.map((question) => _questions.add(
    //       Question(
    //         id= question['id'],
    //         question= question['question'],
    //         options= question['options'].cast<String>(),
    //         // answer: question['answer_index']
    //       ),
    //     ));
    notifyListeners();
    // isLoading = false;
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _selectedAns = selectedIndex;

    // if (_correctAns == _selectedAns) _numOfCorrectAns++;
    lAnswers.add(_selectedAns);
    // print(lAnswers);

    // Once user select an ans after 1s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      // Get package provide us simple way to navigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}

class LoadDataFromJson {
  static String _dataPath = "assets/data.json";
  // List<Question> questions = <Question>[];
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  PageController _pageController = PageController();
  PageController get pageController => this._pageController;

  String _type = "";
  String get type => this._type;
  set type(String value) => this._type = value;

  // late List<Question> _questions;
  List<Question> _questions = <Question>[];
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  List<int> _lAnswers = <int>[];
  List<int> get lAnswers => this._lAnswers;

  // Load data, convert to List of Model
  static Future<List<Question>> loadQuestionData(
      BuildContext context, String type) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final dataString = await assetBundle.loadString('assets/data.json');
    // var dataString = await loadAsset();
    // print(dataString);
    Map<String, dynamic> jsonQuestionData = jsonDecode(dataString);
    // _questions = ;
    print('load thành công!');
    // print(dataString);
    return QuestionList.fromJson(jsonQuestionData[type]).questions;
  }

  // Load Data from Assets
  static Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: 10), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  // Load data, convert to List of Model
  Future<List<Question>> loadMBTIData() async {
    // var dataString = await loadAsset();
    // Map<String, dynamic> jsonQuestionData = jsonDecode(dataString);
    // questions = QuestionList.fromJson(jsonQuestionData['questions']).questions;
    print('load thành công MBTI!');
    return questions;
  }
}

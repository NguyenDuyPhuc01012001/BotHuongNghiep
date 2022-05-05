import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:huong_nghiep/models/tests/questions.dart';
import 'package:huong_nghiep/screens/home/test/score_screen.dart';
// import 'package:huong_nghiep/score/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  String _type = "";
  String get type => this._type;
  set type(String value) => this._type = value;

  // late List<Question> _questions;
  // List<Question> _questions = <Question>[];
  // List<Question> get questions => this._questions;
  int _length = -1;
  int get length => this._length;
  set length(int value) => this._length = value;

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

  // int _numOfCorrectAns = 0;
  // int get numOfCorrectAns => this._numOfCorrectAns;

  // bool _isLoading = false;
  // set isLoading(bool value) => this._isLoading = value;
  // bool get isLoading => this._isLoading;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60h
    _animationController =
        AnimationController(duration: Duration(hours: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });
    readJson().then((value) => update());

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    // _questions = (_type == "MBTI" ? testMBTI : testHolland)
    //     .map(
    //       (question) => Question(
    //         id: question['id'],
    //         question: question['question'],
    //         options: question['options'],
    //         // answer: question['answer_index']
    //       ),
    //     )
    //     .toList();
    super.onInit();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    // print(data);
    // data.map((question) => _questions.add(
    //       Question(
    //         id: question['id'],
    //         question: question['question'],
    //         options: question['options'].cast<String>(),
    //         // answer: question['answer_index']
    //       ),
    //     ));
    update();
    // isLoading = false;
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _selectedAns = selectedIndex;

    // if (_correctAns == _selectedAns) _numOfCorrectAns++;
    lAnswers.add(_selectedAns);
    print(lAnswers);
    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}

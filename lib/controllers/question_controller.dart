// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_getters_setters, prefer_final_fields

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/tests/question.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/screens/home/test/score_screen.dart';
// import 'package:huong_nghiep/score/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;

  // so that we can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;

  PageController get pageController => _pageController;

  String _type = "";

  String get type => _type;

  set type(String value) => _type = value;

  // late List<Question> _questions;
  // List<Question> _questions = <Question>[];
  // List<Question> get questions => this._questions;
  int _qLength = -1;

  int get qLength => _qLength;

  set qLength(int value) => _qLength = value;

  bool _isAnswered = false;

  bool get isAnswered => _isAnswered;

  late int _correctAns;

  int get correctAns => _correctAns;

  late int _selectedAns;

  int get selectedAns => _selectedAns;

  // for more about obs please check documentation
  RxInt _questionNumber = 1.obs;

  RxInt get questionNumber => _questionNumber;

  List<int> _lAnswers = <int>[];

  List<int> get lAnswers => _lAnswers;

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
    // print(lAnswers);
    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 1s it will go to the next qn
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _qLength) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      Map<String, int> scMap = getMapScore();
      FirebaseHandler.updateQuizScores(type, scMap);
      // Get package provide us simple way to naviigate another page
      Get.off(ScoreScreen(type: type));
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }

  getMapScore() {
    int scN = 0, scT = 0, scF = 0, scJ = 0, scP = 0;
    int scI = 0, scS = 0, scE = 0;
    int scR = 0, scA = 0, scC = 0;
    if (type == "MBTI") {
      for (int i = 0; i < lAnswers.length; i++) {
        // print("rest answers ${lAnswers[i]}");
        switch (i % 7) {
          case 1:
            lAnswers[i] == 0 ? scE += 1 : scI += 1;
            break;
          case 2:
          case 3:
            lAnswers[i] == 0 ? scS += 1 : scN += 1;
            break;
          case 4:
          case 5:
            lAnswers[i] == 0 ? scT += 1 : scF += 1;
            break;
          case 6:
          case 0:
            lAnswers[i] == 0 ? scJ += 1 : scP += 1;
            break;
        }
      }
    } else {
      // type= "Holland"
      for (int i = 0; i < 9; i++) {
        scR += ++lAnswers[i];
      }
      for (int i = 9; i < 18; i++) {
        scI += ++lAnswers[i];
      }
      for (int i = 18; i < 27; i++) {
        scA += ++lAnswers[i];
      }
      for (int i = 27; i < 36; i++) {
        scS += ++lAnswers[i];
      }
      for (int i = 36; i < 45; i++) {
        scE += ++lAnswers[i];
      }
      for (int i = 45; i < 54; i++) {
        scC += ++lAnswers[i];
      }
    }
    Map<String, int> scMap = {};
    if (type == "MBTI") {
      scMap['E'] = scE;
      scMap['I'] = scI;
      scMap['S'] = scS;
      scMap['N'] = scN;
      scMap['T'] = scT;
      scMap['F'] = scF;
      scMap['J'] = scJ;
      scMap['P'] = scP;
    } else {
      // type= "Holland"
      scMap['R'] = scR;
      scMap['I'] = scI;
      scMap['A'] = scA;
      scMap['S'] = scS;
      scMap['E'] = scE;
      scMap['C'] = scC;
    }
    return scMap;
  }
}

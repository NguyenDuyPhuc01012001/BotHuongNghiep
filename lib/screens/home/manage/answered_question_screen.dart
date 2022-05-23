// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/posts.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/widgets/home/answer/add_answer_widget.dart';
import 'package:huong_nghiep/widgets/home/answer/answer_title_widget.dart';
import 'package:huong_nghiep/widgets/home/answer/post_title_widget.dart';

import '../../../models/answer.dart';
import '../../../utils/styles.dart';

class AnsweredQuestionScreen extends StatefulWidget {
  final Post post;
  const AnsweredQuestionScreen({Key? key, required this.post})
      : super(key: key);

  @override
  State<AnsweredQuestionScreen> createState() => _AnsweredQuestionScreenState();
}

class _AnsweredQuestionScreenState extends State<AnsweredQuestionScreen> {
  final TextEditingController answerController = TextEditingController();
  String filePath = "";

  late Stream<QuerySnapshot> answerStream;

  @override
  void initState() {
    answerStream = postsFR
        .doc(widget.post.id)
        .collection('answers')
        .orderBy('time')
        .snapshots();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text("Giải đáp thắc mắc",
                style: kDefaultTextStyle.copyWith(
                    fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
                textAlign: TextAlign.center),
          ),
          titleSpacing: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PostTitleWidget(post: widget.post),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(height: 5, thickness: 2),
                    ),
                    StreamBuilder(
                      stream: answerStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print('Something went Wrong');
                          return ErrorScreen();
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Positioned(
                            top: MediaQuery.of(context).size.height * 0.5,
                            left: MediaQuery.of(context).size.width * 0.5,
                            child: SpinKitChasingDots(
                                color: Colors.brown, size: 32),
                          );
                        }

                        List<Answer> answerDocs = [];
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                          Answer answer = Answer.fromSnap(document);
                          answerDocs.add(answer);
                        }).toList();

                        return answerDocs.isEmpty
                            ? Center(
                                child: Text("Hiện tại chưa có câu trả lời"))
                            : Column(
                                children: [
                                  for (var i = 0;
                                      i < answerDocs.length;
                                      i++) ...[
                                    AnswerTitleWidget(
                                      answer: answerDocs[i],
                                      postID: widget.post.id!,
                                      isAdmin: true,
                                    )
                                  ]
                                ],
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
            AddAnswerWidget(postID: widget.post.id!),
          ],
        ));
  }
}

// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/answer.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/utils/constants.dart';

import '../../../models/posts.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/answer/answer_title_widget.dart';
import '../../../widgets/home/answer/post_title_widget.dart';

class AnswerPageScreen extends StatefulWidget {
  final String postID;

  const AnswerPageScreen({Key? key, required this.postID}) : super(key: key);

  @override
  State<AnswerPageScreen> createState() => _AnswerPageScreenState();
}

class _AnswerPageScreenState extends State<AnswerPageScreen> {
  late Stream<QuerySnapshot> answerStream;

  @override
  void initState() {
    answerStream = postsFR.doc(widget.postID).collection('answers').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Answer> answerDocs = [];
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
          padding: EdgeInsets.only(top: 10, bottom: 5),
          child: Text("Giải đáp thắc mắc".capitalize!,
              style: kDefaultTextStyle.copyWith(
                  fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
              textAlign: TextAlign.center),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: postsFR.doc(widget.postID).get(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something Went Wrong');
              return ErrorScreen();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitChasingDots(color: Colors.brown, size: 32),
              );
            }
            Post post = Post.fromSnap(snapshot.data!);
            return SingleChildScrollView(
                child: Column(children: [
              PostTitleWidget(post: post),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(thickness: 2)),
              StreamBuilder(
                stream: answerStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('Something went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Answer answer = Answer.fromSnap(document);
                    answerDocs.add(answer);
                  }).toList();

                  return answerDocs.isEmpty
                      ? Center(
                          child: Text(
                          "Hiện tại chưa có câu trả lời",
                          style: kDefaultTextStyle,
                        ))
                      : Column(
                          children: [
                            for (var i = 0; i < answerDocs.length; i++) ...[
                              AnswerTitleWidget(
                                answer: answerDocs[i],
                                postID: post.id!,
                                isAdmin: false,
                              )
                            ],
                            verticalSpaceMedium
                          ],
                        );
                },
              )
            ]));
          }),
    );
  }
}

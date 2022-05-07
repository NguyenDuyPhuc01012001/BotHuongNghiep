// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:huong_nghiep/model/posts.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:huong_nghiep/widgets/home/answer/answer_title_widget.dart';
import 'package:huong_nghiep/widgets/home/answer/post_title_widget.dart';

import '../../../model/answer.dart';

class AnsweredQuestionScreen extends StatefulWidget {
  final String postID;
  const AnsweredQuestionScreen({Key? key, required this.postID})
      : super(key: key);

  @override
  State<AnsweredQuestionScreen> createState() => _AnsweredQuestionScreenState();
}

class _AnsweredQuestionScreenState extends State<AnsweredQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController answerController = TextEditingController();

  late Stream<QuerySnapshot> answerStream;

  @override
  void initState() {
    answerStream = postsFR
        .doc(widget.postID)
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
      appBar: AppBar(title: Text("Giải đáp thắc mắc")),
      body: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: postsFR.doc(widget.postID).get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Post post = Post.fromSnap(snapshot.data!);
              return Column(
                children: [
                  PostTitleWidget(post: post),
                  Expanded(
                      child: StreamBuilder(
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

                      List<Answer> answerDocs = [];
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Answer answer = Answer.fromSnap(document);
                        answerDocs.add(answer);
                      }).toList();

                      return answerDocs.isEmpty
                          ? Center(child: Text("Hiện tại chưa có câu trả lời"))
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: Column(
                                children: [
                                  for (var i = 0;
                                      i < answerDocs.length;
                                      i++) ...[
                                    AnswerTitleWidget(answer: answerDocs[i])
                                  ]
                                ],
                              ),
                            );
                    },
                  )),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                )),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 100),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: answerController,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto'),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: 'Gửi câu trả lời',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            String answerMessage = answerController.text;
                            if (answerMessage.isNotEmpty) {
                              await FirebaseHandler.addAnswerPost(
                                  answerMessage, widget.postID);
                              print(answerMessage);
                            }
                            answerController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}

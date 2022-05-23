// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:huong_nghiep/models/answer.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';

import '../../../models/posts.dart';
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
      appBar: AppBar(title: Text('Giải đáp thắc mắc')),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                      ? Center(child: Text("Hiện tại chưa có câu trả lời"))
                      : Column(
                          children: [
                            for (var i = 0; i < answerDocs.length; i++) ...[
                              AnswerTitleWidget(
                                answer: answerDocs[i],
                                postID: post.id!,
                                isAdmin: false,
                              )
                            ]
                          ],
                        );
                },
              )
            ]));
          }),
    );
  }
}

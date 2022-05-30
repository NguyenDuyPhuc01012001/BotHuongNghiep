// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/widgets/home/answer/post_widget.dart';

import '../../../models/posts.dart';
import '../../../resources/firebase_reference.dart';

class ListAnswerWidget extends StatefulWidget {
  const ListAnswerWidget({Key? key}) : super(key: key);

  @override
  State<ListAnswerWidget> createState() => _ListAnswerWidgetState();
}

class _ListAnswerWidgetState extends State<ListAnswerWidget> {
  late Stream<QuerySnapshot> postsStream;

  @override
  void initState() {
    postsStream = postsFR.orderBy('time', descending: true).snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: postsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }

          List<Post> postDocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Post post = Post.fromSnap(document);
            postDocs.add(post);
          }).toList();

          return Card(
            elevation: 20,
            color: Colors.grey[300],
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              for (var i = 0; i < postDocs.length; i++) ...[
                PostWidget(post: postDocs[i])
              ]
            ]),
          );
        });
  }
}

// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../resources/firebase_reference.dart';

class ListAnswerWidget extends StatefulWidget {
  const ListAnswerWidget({Key? key}) : super(key: key);

  @override
  State<ListAnswerWidget> createState() => _ListAnswerWidgetState();
}

class _ListAnswerWidgetState extends State<ListAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    var postsStream = postsFR.snapshots();
    return StreamBuilder(
        stream: postsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          return Column();
        });
  }
}

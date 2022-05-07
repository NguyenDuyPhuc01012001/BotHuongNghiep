// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../../resources/firebase_handle.dart';
import '../../../screens/home/manage/answered_question_screen.dart';

class QuestionManageBody extends StatefulWidget {
  const QuestionManageBody({Key? key}) : super(key: key);

  @override
  State<QuestionManageBody> createState() => _QuestionManageBodyState();
}

class _QuestionManageBodyState extends State<QuestionManageBody> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> postStream = postsFR.snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: postStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          final List postdocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            postdocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(200),
                  2: FixedColumnWidth(120),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Câu hỏi',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Số câu TL',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Chức năng',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < postdocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Center(
                                child: Text(postdocs[i]['question'],
                                    style: TextStyle(fontSize: 14.0))),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Center(
                                child: Text("${postdocs[i]['numAnswer']}",
                                    style: TextStyle(fontSize: 14.0))),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Get.to(AnsweredQuestionScreen(
                                      postID: postdocs[i]['id']))
                                },
                                icon: Icon(
                                  Icons.chat_outlined,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Dialogs.materialDialog(
                                      msg: 'Bạn có muốn xoá câu hỏi này không?',
                                      title: "Xoá",
                                      color: Colors.white,
                                      context: context,
                                      actions: [
                                        IconsOutlineButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          text: 'Cancel',
                                          iconData: Icons.cancel_outlined,
                                          textStyle:
                                              TextStyle(color: Colors.grey),
                                          iconColor: Colors.grey,
                                        ),
                                        IconsButton(
                                          onPressed: () async {
                                            await FirebaseHandler.deletePost(
                                                    postdocs[i]['id'])
                                                .whenComplete(() => Get.back());
                                          },
                                          text: 'Xoá',
                                          iconData: Icons.delete,
                                          color: Colors.red,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                          iconColor: Colors.white,
                                        ),
                                      ]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}

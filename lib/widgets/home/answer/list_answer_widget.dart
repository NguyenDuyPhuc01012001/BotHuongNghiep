// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/detailpage/answer_page_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';

import '../../../model/posts.dart';
import '../../../resources/firebase_reference.dart';

class ListAnswerWidget extends StatefulWidget {
  const ListAnswerWidget({Key? key}) : super(key: key);

  @override
  State<ListAnswerWidget> createState() => _ListAnswerWidgetState();
}

class _ListAnswerWidgetState extends State<ListAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var postsStream = postsFR.snapshots();
    List<Post> postDocs = [];
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

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Post post = Post.fromSnap(document);
            postDocs.add(post);
          }).toList();

          return Column(children: [
            for (var i = 0; i < postDocs.length; i++) ...[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    postDocs[i].userImage!,
                                    fit: BoxFit.cover,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(postDocs[i].email!, style: kItemText),
                              ],
                            ),
                            Text(
                              postDocs[i].time!,
                              style: kItemText,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(postDocs[i].question!,
                              style: kContentText.copyWith(
                                  fontWeight: FontWeight.normal)),
                        ),
                        SizedBox(height: 4),
                        postDocs[i].image! == ""
                            ? SizedBox()
                            : ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: postDocs[i].image!,
                                  width: size.width,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                hoverColor: Colors.grey,
                                onPressed: () {
                                  Get.to(AnswerPageScreen(
                                      postID: postDocs[i].id!));
                                },
                                icon: Icon(Icons.question_answer_outlined)),
                            Text("Đã có ${postDocs[i].numAnswer} trả lời")
                          ],
                        )
                      ],
                    ),
                  ))
            ]
          ]);
        });
  }
}

// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/answer.dart';

import '../../../models/user.dart';
import '../../../resources/firebase_handle.dart';
import '../../../resources/firebase_reference.dart';
import '../../../screens/other/error_screen.dart';
import '../../../utils/styles.dart';
import '../../alert.dart';

class AnswerTitleWidget extends StatefulWidget {
  const AnswerTitleWidget({
    Key? key,
    required this.answer,
    required this.postID,
    required this.isAdmin,
  }) : super(key: key);

  final Answer answer;
  final String postID;
  final bool isAdmin;

  @override
  State<AnswerTitleWidget> createState() => _AnswerTitleWidgetState();
}

class _AnswerTitleWidgetState extends State<AnswerTitleWidget> {
  @override
  Widget build(BuildContext context) {
    bool isUserMessage = FirebaseAuth.instance.currentUser!.displayName!
        .contains(widget.answer.source!);
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 12.0, left: 12, top: 12, bottom: 4),
      child: Column(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  widget.answer.sourceImage!,
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 8),
              FutureBuilder(
                  future: userFR.doc(widget.answer.sourceID!).get(),
                  builder:
                      ((context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('Something went Wrong');
                      Get.to(ErrorScreen());
                      return SizedBox();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            SpinKitChasingDots(color: Colors.brown, size: 16),
                      );
                    }
                    UserData userData = UserData.fromSnap(snapshot.data!);
                    return userData.isAdmin
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(widget.answer.source!, style: kItemText),
                              Icon(Icons.star,
                                  color: Color.fromARGB(255, 234, 214, 40)),
                              Text("Admin",
                                  style: kItemText.copyWith(
                                      color: Color.fromARGB(255, 234, 214, 40),
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        : Text(widget.answer.source!, style: kItemText);
                  })),
              // Text(widget.answer.source!, style: kItemText),
            ],
          ),
          Dismissible(
            key: UniqueKey(),
            direction: isUserMessage
                ? DismissDirection.endToStart
                : DismissDirection.startToEnd,
            onDismissed: (_) {
              setState(() {
                Alerts().confirm(
                    "Bạn có muốn xoá câu trả lời này không?", 'Đồng ý', 'Hủy',
                    () async {
                  await FirebaseHandler.deleteAnswerPost(
                          widget.postID, widget.answer.id!)
                      .whenComplete(() => {Get.back()});
                }, () => Get.back(), context);
              });
            },
            confirmDismiss: (direction) async => widget.isAdmin,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xffFEF8E8),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: isUserMessage
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.answer.answer!.length > 50
                          ? size.width * 0.7
                          : size.width * 0.6,
                      child: Text(widget.answer.answer!,
                          textAlign: TextAlign.justify,
                          style: kContentText.copyWith(
                              fontWeight: FontWeight.normal,
                              color: Colors.black)),
                    ),
                    widget.answer.image! == ""
                        ? SizedBox()
                        : ClipRRect(
                            child: CachedNetworkImage(
                                imageUrl: widget.answer.image!,
                                width: widget.answer.answer!.length > 50
                                    ? size.width * 0.7
                                    : size.width * 0.6,
                                height: 150,
                                fit: BoxFit.fitWidth,
                                placeholder: (context, _) => SpinKitChasingDots(
                                    color: Colors.brown, size: 32),
                                errorWidget: (context, _, error) =>
                                    Icon(Icons.error)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                  ],
                ),
              ),
            ),
            background: Card(
              elevation: 20,
              color: widget.isAdmin ? Colors.red : Colors.green,
              child: Container(
                alignment: isUserMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: widget.isAdmin
                      ? Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      : Text(
                          "Không có gì xảy ra đâu.",
                          style: kContentText.copyWith(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: Text(
              "Đã trả lời vào lúc ${widget.answer.time!}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}

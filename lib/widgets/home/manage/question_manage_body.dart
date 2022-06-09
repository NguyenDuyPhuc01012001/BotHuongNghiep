// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../models/posts.dart';
import '../../../resources/firebase_handle.dart';
import '../../../screens/home/manage/answered_question_screen.dart';
import '../../../screens/other/error_screen.dart';
import '../../../utils/styles.dart';
import '../../alert.dart';

class QuestionManageBody extends StatefulWidget {
  final bool descending;

  const QuestionManageBody({Key? key, required this.descending})
      : super(key: key);

  @override
  State<QuestionManageBody> createState() => _QuestionManageBodyState();
}

class _QuestionManageBodyState extends State<QuestionManageBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: FirebaseHandler.getPostsList(widget.descending),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }
          if (snapshot.hasData) {
            List<Post> postdocs = snapshot.data!;
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: postdocs.length,
                      itemBuilder: ((context, index) {
                        return Dismissible(
                          key: UniqueKey(),

                          // only allows the user swipe from right to left
                          direction: DismissDirection.endToStart,

                          // Remove this product from the list
                          // In production enviroment, you may want to send some request to delete it on server side
                          onDismissed: (_) {
                            setState(() {
                              Alerts().confirm(
                                  "Bạn có muốn xoá câu hỏi này không?",
                                  'Đồng ý',
                                  'Hủy', () async {
                                await FirebaseHandler.deletePost(
                                        postdocs[index].id!)
                                    .whenComplete(
                                        () => {Get.back(), setState(() {})});
                              }, () => Get.back(), context);
                            });
                          },

                          // Display item's title, price...
                          child: Card(
                            elevation: 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: InkWell(
                              onTap: () async {
                                final result = await Get.to(
                                    AnsweredQuestionScreen(
                                        post: postdocs[index]));
                                if (result != null) {
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      "${index + 1}",
                                      style: kDefaultTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    backgroundColor: Color(0xffBFBFBF),
                                  ),
                                  title: Text(
                                      postdocs[index]
                                          .question!
                                          .capitalizeFirst!,
                                      style: kDefaultTextStyle,
                                      textAlign: TextAlign.justify),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                        text: 'Số lượng phản hồi: ',
                                        style: kDefaultTextStyle.copyWith(
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.normal),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "${postdocs[index].numAnswer}",
                                              style: kDefaultTextStyle.copyWith(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                      RichText(
                                          text: TextSpan(
                                        text: 'Đăng bởi ',
                                        style: kDefaultTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: postdocs[index].name!,
                                              style: kDefaultTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                      RichText(
                                          text: TextSpan(
                                        text: 'Đăng vào ',
                                        style: kDefaultTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: postdocs[index].time!,
                                              style: kDefaultTextStyle.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // This will show up when the user performs dismissal action
                          // It is a red background and a trash icon
                          background: Card(
                            elevation: 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            color: Colors.red,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }))),
            );
          } else {
            return ErrorScreen();
          }
        });
  }
}

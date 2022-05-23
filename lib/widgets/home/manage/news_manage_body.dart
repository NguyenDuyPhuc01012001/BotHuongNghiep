// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/manage/update_news_screen.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';
import 'package:huong_nghiep/widgets/alert.dart';

import '../../../models/news.dart';
import '../../../resources/firebase_handle.dart';

class NewsManageBody extends StatefulWidget {
  final bool descending;
  const NewsManageBody({Key? key, required this.descending}) : super(key: key);

  @override
  State<NewsManageBody> createState() => _NewsManageBodyState();
}

class _NewsManageBodyState extends State<NewsManageBody> {
  // Stream<QuerySnapshot> newsStream = newsFR.orderBy('time').snapshots();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
        future: FirebaseHandler.getListNews(widget.descending),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }

          List<News> newsdocs = snapshot.data!;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: newsdocs.length,
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
                                "Bạn có muốn xoá tin tức này không?",
                                'Đồng ý',
                                'Hủy', () async {
                              await FirebaseHandler.deleteNews(
                                      newsdocs[index].id!)
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
                                  UpdateNewsScreen(newsPost: newsdocs[index]));
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
                                title: Text(newsdocs[index].title!,
                                    style: kDefaultTextStyle,
                                    textAlign: TextAlign.justify),
                                subtitle: Text(
                                    "Đã đăng vào ${newsdocs[index].time!}",
                                    style: kDefaultTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.justify),
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
        });
  }
}

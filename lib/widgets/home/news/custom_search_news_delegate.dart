// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:huong_nghiep/resources/support_function.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../models/news.dart';
import '../../../screens/home/detailpage/news_page_screen.dart';
import '../../../utils/styles.dart';

class CustomSearchNewsDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return excuteWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return excuteWidget();
  }

  Widget excuteWidget() {
    if (query == "") {
      return Center(
        child: SizedBox(
          child: Lottie.network(
              "https://assets7.lottiefiles.com/private_files/lf30_cgfdhxgx.json",
              fit: BoxFit.cover),
        ),
      );
    }
    return StreamBuilder(
      stream: newsFR.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: SpinKitChasingDots(color: Colors.brown, size: 32),
          );
        }

        List<News> newList = News.dataListFromSnapshot(snapshot.data!);
        List<News> resultNews = newList
            .where((element) => TiengViet.parse(element.title!.toLowerCase())
                .contains(TiengViet.parse(query.toLowerCase())))
            .toList();

        return SingleChildScrollView(
          child: Column(children: [
            for (var i = 0; i < resultNews.length; i++) ...[
              Card(
                elevation: 20,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.transparent,
                child: GestureDetector(
                    onTap: () {
                      Get.to(NewsPageScreen(newsPostID: resultNews[i].id!));
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: resultNews[i].image!,
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, _) => SpinKitChasingDots(
                                    color: Colors.brown, size: 32),
                                errorWidget: (context, _, error) =>
                                    Icon(Icons.error),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                      getTruncatedTitle(
                                          resultNews[i].title!, 60),
                                      style: kItemText.copyWith(
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${resultNews[i].timeRead!} đọc",
                                        style: kItemText,
                                      ),
                                      Text(
                                        resultNews[i].time!,
                                        style: kItemText,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ))),
              )
            ]
          ]),
        );
      },
    );
  }
}

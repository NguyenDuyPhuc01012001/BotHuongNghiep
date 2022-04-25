// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../model/news/news.dart';
import '../../../providers/news/news_provider.dart';
import '../../../resources/firebase_reference.dart';
import '../../../screens/home/news/news_page_screen.dart';
import '../../../utils/values.dart';

class NewsCarousel extends StatelessWidget {
  NewsCarousel({Key? key}) : super(key: key);
  final StaticValues staticValues = StaticValues();

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    final Stream<QuerySnapshot> newsStream = newsFR.snapshots();
    List<News> newsdocs = [];
    return StreamBuilder<QuerySnapshot>(
        stream: newsStream,
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
            News news = News.fromSnap(document);
            newsdocs.add(news);
          }).toList();

          return CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
            ),
            items: newsdocs.map((news) {
              print('Is Rerun');
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(NewsPageScreen(newsPostID: news.id!));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(news.image!),
                              height: 250,
                              // width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: const [
                                    Color(0xCC000000),
                                    Color(0x00000000),
                                    Color(0x00000000),
                                    Color(0xCC000000),
                                  ],
                                ),
                                // image: DecorationImage(
                                //     colorFilter: new ColorFilter.mode(
                                //         Colors.black, BlendMode.dstATop),
                                //     image: NetworkImage(news.image),
                                //     fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  news.title!,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        });
  }
}

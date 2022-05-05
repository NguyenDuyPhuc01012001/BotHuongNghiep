// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../model/news/news.dart';
import '../../../resources/firebase_reference.dart';
import '../../../screens/home/detailpage/news_page_screen.dart';

class NewsCarousel extends StatefulWidget {
  const NewsCarousel({Key? key}) : super(key: key);

  @override
  State<NewsCarousel> createState() => _NewsCarouselState();
}

class _NewsCarouselState extends State<NewsCarousel> {
  final _random = Random();
  bool _isFirst = true;
  @override
  Widget build(BuildContext context) {
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
            if (_isFirst) {
              _isFirst = false;
              News news = News.fromSnap(document);
              newsdocs.add(news);
            } else {
              var number = _random.nextInt(50);
              if (number % 2 == 0) {
                News news = News.fromSnap(document);
                newsdocs.add(news);
              }
            }
          }).toList();

          return CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
            ),
            items: newsdocs.map((news) {
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

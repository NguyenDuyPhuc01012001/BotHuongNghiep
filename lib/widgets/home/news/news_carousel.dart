// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';

import '../../../models/news.dart';
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
    final Stream<QuerySnapshot> newsStream =
        newsFR.orderBy('time', descending: true).snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: newsStream,
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
          List<News> newsdocs = [];
          int count = 1;
          snapshot.data!.docs.map((DocumentSnapshot document) {
            if (_isFirst && count < 4) {
              _isFirst = false;
              News news = News.fromSnap(document);
              newsdocs.add(news);
              count++;
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
              // height: 200.0,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 1.5,
              initialPage: 1,
            ),
            items: newsdocs.map((news) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(NewsPageScreen(newsPostID: news.id!));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    imageUrl: news.image!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, _) =>
                                        SpinKitChasingDots(
                                            color: Colors.brown, size: 32),
                                    errorWidget: (context, _, error) =>
                                        Icon(Icons.error),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              child: Text(
                                news.title!,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
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

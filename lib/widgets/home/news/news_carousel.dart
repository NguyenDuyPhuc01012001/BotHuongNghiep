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
              height: 200.0,
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
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black54
                                    ]).createShader(Rect.fromLTRB(
                                    0, -140, rect.width, rect.height * 0.8));
                              },
                              blendMode: BlendMode.darken,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CachedNetworkImage(
                                    imageUrl: news.image!,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, _) =>
                                        SpinKitChasingDots(
                                            color: Colors.brown, size: 32),
                                    errorWidget: (context, _, error) =>
                                        Icon(Icons.error),
                                  )),
                            ),
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

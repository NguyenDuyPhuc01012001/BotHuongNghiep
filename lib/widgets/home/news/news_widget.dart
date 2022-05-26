// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/list/list_news_screen.dart';
import 'package:huong_nghiep/widgets/home/news/list_title_news.dart';
import 'package:huong_nghiep/widgets/home/news/news_carousel.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            width: size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0, top: 4.0),
                    child: Text(
                      "Tin tức ngẫu nhiên",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  NewsCarousel(),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tin tức mới nhất",
                          style: TextStyle(fontSize: 24),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ListNewsScreen());
                          },
                          child: Row(
                            children: [
                              Text("Xem thêm",
                                  style: kDefaultTextStyle.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18)),
                              horizontalSpaceTiny,
                              Icon(Icons.arrow_forward, size: 32),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTitleNews(
                          limited: 3,
                          descending: true,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

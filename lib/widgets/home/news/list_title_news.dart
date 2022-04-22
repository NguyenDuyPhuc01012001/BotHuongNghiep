// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/news/news_page_screen.dart';

import '../../../model/news/news.dart';
import '../../../utils/styles.dart';
import '../../../utils/values.dart';

class ListTitleNews extends StatelessWidget {
  ListTitleNews({Key? key}) : super(key: key);
  final List<News> news = StaticValues().news;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(news.length, (index) {
        News newsItem = news[index];
        int newsDescriptionLength = newsItem.description.split(' ').length;
        return GestureDetector(
          onTap: () {
            Get.to(NewsPageScreen(newsPost: newsItem));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: newsItem.image,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
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
                      Text(getTruncatedTitle(newsItem.title, 60),
                          style: kItemText.copyWith(
                              fontWeight: FontWeight.normal)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${newsDescriptionLength >= 200 ? (newsDescriptionLength / 200).floor() : (newsDescriptionLength / 200 * 60).floor()} ${newsDescriptionLength >= 200 ? "mins" : "secs"} read",
                            style: kItemText,
                          ),
                          Text(
                            newsItem.time,
                            style: kItemText,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}

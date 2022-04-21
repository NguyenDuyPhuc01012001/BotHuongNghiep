// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:huong_nghiep/widgets/home/news/list_title_news.dart';
import 'package:huong_nghiep/widgets/home/news/news_carousel.dart';
import 'package:huong_nghiep/widgets/home/news/news_search_bar.dart';

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
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [NewsSearchBar(), SizedBox(height: 10)],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0, top: 4.0),
                    child: Text(
                      "Tin tức ngẫu nhiên",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  NewsCarousel(),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: Text(
                      "Danh sách tin tức",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ListTitleNews()],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

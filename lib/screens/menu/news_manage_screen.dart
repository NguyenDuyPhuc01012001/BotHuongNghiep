// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/manage/add_news_screen.dart';

import '../../widgets/home/manage/news_manage_body.dart';

class NewsManageScreen extends StatefulWidget {
  const NewsManageScreen({Key? key}) : super(key: key);

  @override
  _NewsManageScreenState createState() => _NewsManageScreenState();
}

class _NewsManageScreenState extends State<NewsManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quản lí tin tức'),
            IconButton(
                onPressed: () => {Get.to(AddNewsScreen())},
                icon: Icon(Icons.add))
          ],
        ),
      ),
      body: NewsManageBody(),
    );
  }
}

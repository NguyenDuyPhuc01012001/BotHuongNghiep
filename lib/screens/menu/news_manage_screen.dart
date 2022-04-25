// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/news/news_provider.dart';
import 'package:huong_nghiep/screens/manageNews/add_news_screen.dart';
import 'package:huong_nghiep/widgets/home/news_manage/news_manage_body.dart';
import 'package:provider/provider.dart';

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
            Text('Flutter FireStore CRUD'),
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

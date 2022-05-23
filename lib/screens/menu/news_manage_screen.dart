// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/manage/add_news_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../utils/constants.dart';
import '../../widgets/home/manage/news_manage_body.dart';

class NewsManageScreen extends StatefulWidget {
  const NewsManageScreen({Key? key}) : super(key: key);

  @override
  _NewsManageScreenState createState() => _NewsManageScreenState();
}

class _NewsManageScreenState extends State<NewsManageScreen> {
  bool descending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Quản lý tin tức".capitalize!,
            style: kDefaultTextStyle.copyWith(
                fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
            textAlign: TextAlign.center),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                descending = !descending;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  color: Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: Icon(MdiIcons.sort),
            ),
          ),
          horizontalSpaceSmall
        ],
      ),
      extendBodyBehindAppBar: true,
      body: NewsManageBody(descending: descending),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Get.to(AddNewsScreen());
            if (result != null) {
              setState(() {});
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffBFBFBF),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

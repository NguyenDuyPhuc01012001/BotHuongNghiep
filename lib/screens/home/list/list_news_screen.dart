// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/widgets/home/news/list_title_news.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/news/custom_search_news_delegate.dart';

class ListNewsScreen extends StatefulWidget {
  const ListNewsScreen({Key? key}) : super(key: key);

  @override
  State<ListNewsScreen> createState() => _ListNewsScreenState();
}

class _ListNewsScreenState extends State<ListNewsScreen> {
  bool descending = true;
  String TITLE_NEWSLIST = "Danh sách tin tức";

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
        title: Padding(
          padding: EdgeInsets.only(
              top: 4.0, left: TITLE_NEWSLIST.length.toDouble() * 1.5),
          child: Text(TITLE_NEWSLIST.capitalize!,
              style: kDefaultTextStyle.copyWith(
                  fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
              textAlign: TextAlign.center),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          horizontalSpaceTiny,
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchNewsDelegate(),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  color: Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10, bottom: 5, right: 10),
              child: Icon(
                Icons.search,
              ),
            ),
          ),
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
          horizontalSpaceTiny
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: ListTitleNews(
                limited: 0,
                descending: descending,
              )),
        ])),
      ),
    );
  }
}

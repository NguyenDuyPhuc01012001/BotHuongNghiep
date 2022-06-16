// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/job/custom_search_jobs_delegate.dart';
import '../../../widgets/home/job/list_title_jobs.dart';

class ListJobScreen extends StatefulWidget {
  const ListJobScreen({Key? key}) : super(key: key);

  @override
  State<ListJobScreen> createState() => _ListJobScreenState();
}

class _ListJobScreenState extends State<ListJobScreen> {
  bool descending = true;
  final String TITLE_JOBS = "Danh sách bài đăng";

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
          padding: EdgeInsets.only(top: 4.0),
          child: Text(TITLE_JOBS.capitalize!,
              style: kDefaultTextStyle.copyWith(
                  fontSize: 24, color: Color.fromARGB(255, 142, 142, 142))),
        ),
        centerTitle: true,
        titleSpacing: 0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: CustomSearchJobsDelegate(),
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
              child: ListTitleJobs(
                limited: 0,
                descending: descending,
              )),
        ])),
      ),
    );
  }
}

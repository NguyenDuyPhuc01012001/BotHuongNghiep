// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/styles.dart';
import '../../widgets/home/manage/admin_manage_body.dart';

class AdminManageScreen extends StatefulWidget {
  const AdminManageScreen({Key? key}) : super(key: key);

  @override
  State<AdminManageScreen> createState() => _AdminManageScreenState();
}

class _AdminManageScreenState extends State<AdminManageScreen> {
  String TITLE_ADMIN_MANGEMENT = "Quản lý vai trò người dùng";

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
              top: 4.0, left: TITLE_ADMIN_MANGEMENT.length.toDouble() * 0.6),
          child: Text(TITLE_ADMIN_MANGEMENT.capitalize!,
              style: kDefaultTextStyle.copyWith(
                  fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
              textAlign: TextAlign.center),
        ),
        titleSpacing: 0,
      ),
      extendBodyBehindAppBar: true,
      body: AdminManageBody(),
    );
  }
}

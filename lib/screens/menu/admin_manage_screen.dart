// ignore_for_file: prefer_const_constructors

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
        title: Text("Quản lý vai trò người dùng",
            style: kDefaultTextStyle.copyWith(
                fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
            textAlign: TextAlign.center),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: AdminManageBody(),
    );
  }
}

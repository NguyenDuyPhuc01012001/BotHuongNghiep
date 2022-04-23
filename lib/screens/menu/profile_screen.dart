// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/home/home_provider.dart';
import 'package:huong_nghiep/widgets/home/profile/app_bar_profile_widget.dart';
import 'package:huong_nghiep/widgets/home/profile/display_image_widget.dart';
import 'package:huong_nghiep/widgets/home/profile/edit_email_widget.dart';
import 'package:huong_nghiep/widgets/home/profile/edit_image_widget.dart';
import 'package:huong_nghiep/widgets/home/profile/edit_name_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final image = "assets/images/default_avatar.jpg";
    return Scaffold(
      appBar: AppBarProfileWidget(context),
      body: Column(
        children: [
          Center(
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Cập nhật thông tin',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(64, 105, 225, 1),
                    ),
                  ))),
          InkWell(
              onTap: () {
                Get.to(EditImageWidget());
              },
              child: DisplayImageWidget(
                imagePath: image,
                onPressed: () {},
              )),
          buildUserInfoDisplay(homeProvider.user.name, 'Tên', EditNameWidget()),
          buildUserInfoDisplay(
              homeProvider.user.email, 'Email', EditEmailWidget()),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(
          String? getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Get.to(editPage);
                            },
                            child: Text(
                              getValue!,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));
}

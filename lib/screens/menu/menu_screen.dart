// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/chatbot_screen.dart';
import 'package:huong_nghiep/screens/menu/account_screen.dart';
import 'package:huong_nghiep/screens/menu/setting_screen.dart';

import '../home/home_screen.dart';

class MenuScreen extends StatefulWidget {
  final ValueSetter setIndex;
  const MenuScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

void getToScreen(int index) {
  switch (index) {
    case 0:
      break;
    case 1:
      Get.to(AccountScreen());
      break;
    case 2:
      Get.to(SettingScreen());
      break;
    case 3:
      Get.to(ChatbotScreen());
      break;
    case 4:
      break;
    case 5:
      break;
    default:
      break;
  }
}

class _MenuScreenState extends State<MenuScreen> {
  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () => getToScreen(index),
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        drawerList(Icons.home, "Trang chủ", 0),
        drawerList(Icons.account_box_outlined, "Thông tin cá nhân", 1),
        drawerList(Icons.settings, "Cài đặt", 2),
        drawerList(Icons.chat, "Trò chuyện Chatbot", 3),
        drawerList(Icons.upcoming, "UpComming", 4),
      ]),
    );
  }
}

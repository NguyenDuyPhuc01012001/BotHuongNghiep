// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:huong_nghiep/screens/chatbot_screen.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:huong_nghiep/screens/menu/account_screen.dart';
import 'package:huong_nghiep/screens/menu/menu_screen.dart';
import 'package:huong_nghiep/screens/menu/setting_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int currentIndex = 0;

  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return AccountScreen();
      case 2:
        return SettingScreen();
      case 3:
        return ChatbotScreen();
      case 4:
        return HomeScreen();
      case 5:
        return HomeScreen();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreen: HomeScreen(),
      menuScreen: MenuScreen(
        setIndex: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      borderRadius: 30,
      showShadow: true,
      angle: -1.0,
      slideWidth: 275,
      menuBackgroundColor: Colors.lightBlueAccent,
    );
  }
}

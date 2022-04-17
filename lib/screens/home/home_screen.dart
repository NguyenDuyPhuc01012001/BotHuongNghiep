// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:huong_nghiep/screens/chatbot_screen.dart';
import 'package:huong_nghiep/widgets/home/menu_widget.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //State class
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  ///Thay widget cua minh vao day
  static final List<Widget> _widgetOptions = <Widget>[
    const Center(
      child: Text(
        'Index 0: Trắc nghiệm',
        style: kBottomNavigationItemStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 1: Trường Nghề',
        style: kBottomNavigationItemStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 2: Tin tức',
        style: kBottomNavigationItemStyle,
      ),
    ),
    const Center(
      child: Text(
        'Index 3: Giải đáp',
        style: kBottomNavigationItemStyle,
      ),
    )
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var themeValue = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeValue == Brightness.dark
            ? const Color(0xff3C3A3A)
            : const Color(0xffBFBFBF),
        leading: MenuWidget(),
        centerTitle: true,
        title: Text(
          'Trang chủ',
          style: TextStyle(
              color:
                  themeValue == Brightness.dark ? Colors.white : Colors.black),
        ),
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(ChatbotScreen()),
        child: const Icon(Icons.chat_bubble_outline),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: screenSize.height * 0.08,
          key: _bottomNavigationKey,
          color: kPrimaryColor,
          backgroundColor: kcWhiteColor,
          items: const <Widget>[
            Icon(Icons.games, color: kcWhiteColor),
            Icon(Icons.school, color: kcWhiteColor),
            Icon(Icons.newspaper, color: kcWhiteColor),
            Icon(Icons.question_answer, color: kcWhiteColor)
          ],
          onTap: _onItemTapped,
          letIndexChange: _isCurrentPage),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  bool _isCurrentPage(int value) {
    return _currentIndex != value;
  }
}

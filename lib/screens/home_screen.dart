import 'package:flutter/material.dart';
import 'package:huong_nghiep/screens/chatbot_screen.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  ///Thay widget cua minh vao day
  static List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Index 0: Favorite',
        style: kBottomNavigationItemStyle,
      ),
    ),
    Center(
      child: Text(
        'Index 1: Favorite',
        style: kBottomNavigationItemStyle,
      ),
    ),
    Center(
      child: Text(
        'Index 2: Favorite',
        style: kBottomNavigationItemStyle,
      ),
    ),
    Center(
      child: Text(
        'Index 3: Favorite',
        style: kBottomNavigationItemStyle,
      ),
    ),
    ChatbotScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color:
                    _currentIndex == 0 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Practice"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.description,
                color:
                    _currentIndex == 1 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Vocabulary"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pie_chart,
                color:
                    _currentIndex == 2 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Statistics"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color:
                    _currentIndex == 3 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dehaze,
                color:
                    _currentIndex == 4 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Menu")
        ],
        fixedColor: kPrimaryColor,
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}

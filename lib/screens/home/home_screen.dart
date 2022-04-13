import 'package:flutter/material.dart';
import 'package:huong_nghiep/screens/chatbot_screen.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

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
    ),
    // const Center(
    //   child: Text(
    //     'Index 4: Cài đặt',
    //     style: kBottomNavigationItemStyle,
    //   ),
    // ),
    ChatbotScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      // floatingActionButton: FloatingActionButton(
      //     // When the button is pressed,
      //     // give focus to the text field using myFocusNode.
      //     onPressed: () => ChatbotScreen(),
      //     tooltip: 'Focus Second Text Field',
      //     child: const Icon(Icons.edit)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.games,
                color:
                    _currentIndex == 0 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Trắc nghiệm"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
                color:
                    _currentIndex == 1 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Trường Nghề"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.newspaper,
                color:
                    _currentIndex == 2 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Tin tức"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.question_answer,
                color:
                    _currentIndex == 3 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Giải đáp"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color:
                    _currentIndex == 4 ? kPrimaryColor : kUnselectedIconColor,
              ),
              label: "Cài đặt")
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

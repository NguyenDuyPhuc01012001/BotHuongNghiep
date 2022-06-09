// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/widgets/home/job/jobs_widget.dart';
import 'package:huong_nghiep/widgets/home/menu/nav_bar_drawer.dart';
import 'package:huong_nghiep/widgets/home/news/news_widget.dart';
import 'package:huong_nghiep/widgets/home/quiz/quiz_widget.dart';

// import 'package:huong_nghiep/utils/constants.dart';
// import 'package:huong_nghiep/widgets/home/job/custom_search_jobs_delegate.dart';
// import '../../widgets/home/news/custom_search_news_delegate.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';
import '../../widgets/home/answer/answers_widget.dart';
import '../floatactions/chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //State class
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  static final List<String> _listTitle = [
    "Trắc nghiệm",
    "Thông tin nghề nghiệp",
    "Tin tức",
    "Giải đáp"
  ];

  ///Thay widget cua minh vao day
  static final List<Widget> _widgetOptions = <Widget>[
    QuizWidget(),
    JobsWidget(),
    NewsWidget(),
    QuestionAnswerWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // homeProvider.getCurrentUser();

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => _scaffoldState.currentState!.openDrawer(),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
            child: Icon(
              Icons.menu,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(_listTitle[_currentIndex].capitalize!,
              style: kDefaultTextStyle.copyWith(
                  fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
              textAlign: TextAlign.center),
        ),
        titleSpacing: 0,
        centerTitle: true,
        // actions: <Widget>[
        //   if (_currentIndex == 2)
        //     GestureDetector(
        //       onTap: () {
        //         showSearch(
        //           context: context,
        //           delegate: CustomSearchNewsDelegate(),
        //         );
        //       },
        //       child: Container(
        //         width: MediaQuery.of(context).size.width * 0.12,
        //         decoration: BoxDecoration(
        //             color: Color(0xffBFBFBF),
        //             borderRadius: BorderRadius.circular(10)),
        //         padding: EdgeInsets.all(5),
        //         margin: EdgeInsets.only(top: 10, bottom: 5, right: 10),
        //         child: Icon(
        //           Icons.search,
        //         ),
        //       ),
        //     )
        //   else if (_currentIndex == 1)
        //     GestureDetector(
        //       onTap: () {
        //         showSearch(
        //           context: context,
        //           delegate: CustomSearchJobsDelegate(),
        //         );
        //       },
        //       child: Container(
        //         width: MediaQuery.of(context).size.width * 0.12,
        //         decoration: BoxDecoration(
        //             color: Color(0xffBFBFBF),
        //             borderRadius: BorderRadius.circular(10)),
        //         padding: EdgeInsets.all(5),
        //         margin: EdgeInsets.only(top: 10, bottom: 5, right: 10),
        //         child: Icon(
        //           Icons.search,
        //         ),
        //       ),
        //     ),
        //   horizontalSpaceTiny
        // ],
      ),
      drawer: NavBarDrawer(),
      body: _widgetOptions.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(ChatbotScreen()),
        icon: Icon(Icons.chat_bubble_outline),
        backgroundColor: Color(0xffBFBFBF),
        label: Text(
          'Trò chuyện ChatBot',
          style: kContentText.copyWith(color: Colors.white),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          height: screenSize.height * 0.08,
          key: _bottomNavigationKey,
          color: Color(0xffBFBFBF),
          backgroundColor: kcWhiteColor,
          items: const <Widget>[
            Icon(Icons.games, color: kcWhiteColor),
            Icon(Icons.work, color: kcWhiteColor),
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

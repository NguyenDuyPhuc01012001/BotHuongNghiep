// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/resources/support_function.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/widgets/home/news/title_manage_news.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/news.dart';
import '../../../models/title_news.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/news/content_manage_news.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  List<ContentManageNewsWidget> dynamicList = [];
  TitleManageNewsWidget titleNewsWidget = TitleManageNewsWidget();

  List<String> contents = [];
  List<String> filePaths = [];
  List<String> titles = [];

  onDeleteVar(int val) {
    setState(
      () => {
        titles = [],
        contents = [],
        filePaths = [],
        dynamicList.forEach((element) => {
              titles.add(element.titleController.text),
              contents.add(element.contentController.text),
              filePaths.add(element.filePath)
            }),
        dynamicList.removeWhere((item) => item.index == val),
        titles.removeAt(val),
        contents.removeAt(val),
        filePaths.removeAt(val),
        dynamicList.forEach((element) => {
              element.index = dynamicList.indexOf(element),
              element.contentController.text =
                  contents.elementAt(dynamicList.indexOf(element)),
              element.titleController.text =
                  titles.elementAt(dynamicList.indexOf(element)),
              element.filePath =
                  filePaths.elementAt(dynamicList.indexOf(element))
            })
      },
    );
  }

  addDynamic() {
    setState(() {});
    dynamicList.add(ContentManageNewsWidget(
        index: dynamicList.length, removeItem: onDeleteVar));
  }

  clearScreen() {
    dynamicList.forEach((element) => {
          element.index = dynamicList.indexOf(element),
          element.contentController.text = "",
          element.titleController.text = "",
          element.filePath = ""
        });

    titles.forEach((element) => {element = ""});
    contents.forEach((element) => {element = ""});
    titleNewsWidget.titleController.text = "";
    setState(() {});
  }

  checkValidate() {
    dynamicList.forEach((element) => {
          titles.add(element.titleController.text),
          contents.add(element.contentController.text),
          filePaths.add(element.filePath)
        });
    String titleNews = titleNewsWidget.titleController.text;
    String imageNews = titleNewsWidget.filePath;
    int checkContentEmpty = 0;
    contents.forEach((element) => {if (element.isEmpty) checkContentEmpty++});
    return titleNews.isEmpty || checkContentEmpty > 0 || imageNews.isEmpty;
  }

  saveScreen() {
    if (checkValidate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Dữ liệu nhập vào còn thiếu. Vui lòng kiểm tra lại.')),
      );
    } else {
      List<TitleNews> listTitleNews = [];
      for (int i = 0; i < dynamicList.length; i++) {
        listTitleNews.add(TitleNews(
            title: titles[i], content: contents[i], image: filePaths[i]));
      }
      String title = titleNewsWidget.titleController.text;
      String image = titleNewsWidget.filePath;
      String timeRead = getReadTime(contents);
      News news = News(
          title: title,
          image: image,
          listTitle: listTitleNews,
          timeRead: timeRead);
      FirebaseHandler.addNews(news).then(
        (value) => const SnackBar(content: Text('Đã thêm dữ liệu')),
      );
      Get.back();
    }
  }

  @override
  void initState() {
    dynamicList.add(ContentManageNewsWidget(
        index: dynamicList.length, removeItem: onDeleteVar));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dynamicList.length,
      itemBuilder: (_, index) => dynamicList[index],
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffBFBFBF),
          title: Text('Thêm tin tức'),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: clearScreen,
                    icon: Icon(MdiIcons.eraser),
                    color: Color(0xffede7f6),
                    iconSize: 32),
                horizontalSpaceSmall,
                IconButton(
                    onPressed: saveScreen,
                    icon: Icon(MdiIcons.contentSaveOutline),
                    color: Color(0xffede7f6),
                    iconSize: 32),
                horizontalSpaceTiny
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                    child: Text("Tiêu đề bài báo",
                        style:
                            ktsMediumTitleText.copyWith(color: Colors.black))),
                titleNewsWidget,
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                    child: Text("Nội dung bài báo",
                        style:
                            ktsMediumTitleText.copyWith(color: Colors.black))),
                dynamicTextField,
              ]),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: addDynamic, child: Icon(Icons.add)));
  }
}

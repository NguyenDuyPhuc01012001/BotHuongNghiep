// ignore_for_file: avoid_print, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/widgets/home/news/title_news.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/news.dart';
import '../../../models/title_news.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/news/detail_news_add.dart';
import '../../../widgets/home/news/title_news.dart';

class UpdateScreen extends StatefulWidget {
  final String newsPostID;
  const UpdateScreen({Key? key, required this.newsPostID}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<DetailNewsWidget> dynamicList = [];
  TitleNewsWidget titleNewsWidget = TitleNewsWidget();

  List<TitleNews> listTitle = [];

  late News news;

  onDeleteVar(int val) {
    setState(
      () => {
        listTitle = [],
        dynamicList.forEach((element) => {
              listTitle.add(TitleNews(
                  id: element.id!,
                  title: element.titleController.text,
                  content: element.contentController.text,
                  image: element.filePath))
            }),
        dynamicList.removeWhere((item) => item.index == val),
        listTitle.removeAt(val),
        dynamicList.forEach((element) => {
              element.index = dynamicList.indexOf(element),
              element.id =
                  listTitle.elementAt(dynamicList.indexOf(element)).id!,
              element.contentController.text =
                  listTitle.elementAt(dynamicList.indexOf(element)).content!,
              element.titleController.text =
                  listTitle.elementAt(dynamicList.indexOf(element)).title!,
              element.filePath =
                  listTitle.elementAt(dynamicList.indexOf(element)).image!
            })
      },
    );
  }

  resetList() {
    dynamicList.clear();
    listTitle.clear();
  }

  setDataToDynamic(List<TitleNews> titleList) {
    resetList();
    for (int i = 0; i < titleList.length; i++) {
      dynamicList.add(DetailNewsWidget(removeItem: onDeleteVar, index: i));
      dynamicList[i].id = titleList[i].id!;
      dynamicList[i].titleController.text = titleList[i].title!;
      dynamicList[i].contentController.text = titleList[i].content!;
      dynamicList[i].filePath = titleList[i].image!;

      listTitle.add(titleList[i]);
    }
  }

  setNewsTitleWidget(News news) {
    titleNewsWidget.titleController.text = news.title!;
    titleNewsWidget.filePath = news.image!;
    titleNewsWidget.id = news.id;

    setDataToDynamic(news.listTitle!);
  }

  addDynamic() {
    setState(() {});
    dynamicList.add(DetailNewsWidget(
        index: dynamicList.length, removeItem: onDeleteVar, id: ""));
  }

  clearScreen() {
    setState(() {});
  }

  checkValidate() {
    listTitle = [];
    dynamicList.forEach((element) => {
          listTitle.add(TitleNews(
              id: element.id!,
              title: element.titleController.text,
              content: element.contentController.text,
              image: element.filePath))
        });
    String titleNews = titleNewsWidget.titleController.text;
    String imageNews = titleNewsWidget.filePath;
    int checkContentEmpty = 0;
    listTitle.forEach(
        (element) => {if (element.content!.isEmpty) checkContentEmpty++});
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
        String idTitle = listTitle[i].id!;
        String titleTitle = listTitle[i].title!;
        String titleContent = listTitle[i].content!;
        String titleImage = listTitle[i].image!;
        listTitleNews.add(TitleNews(
            id: idTitle,
            title: titleTitle,
            content: titleContent,
            image: titleImage));
      }
      String title = titleNewsWidget.titleController.text;
      String image = titleNewsWidget.filePath;
      String id = titleNewsWidget.id!;
      News news =
          News(id: id, title: title, image: image, listTitle: listTitleNews);
      FirebaseHandler.updateNew(news).then((value) => Get.back());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffBFBFBF),
          title: Text('Cập nhật tin tức'),
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
        body: FutureBuilder<News>(
          future: FirebaseHandler.getNewByID(widget.newsPostID),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            news = snapshot.data!;
            setNewsTitleWidget(news);
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                        child: Text("Tiêu đề bài báo",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    titleNewsWidget,
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                        child: Text("Nội dung bài báo",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dynamicList.length,
                      itemBuilder: (_, index) => dynamicList[index],
                    )
                  ]),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: addDynamic, child: Icon(Icons.add)));
  }
}
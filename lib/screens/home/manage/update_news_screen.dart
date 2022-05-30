// ignore_for_file: avoid_print, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/resources/support_function.dart';
import 'package:huong_nghiep/screens/other/loading_screen.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/news.dart';
import '../../../models/titles.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/manage/content_manage_widget.dart';
import '../../../widgets/home/manage/title_manage_widget.dart';

class UpdateNewsScreen extends StatefulWidget {
  final News newsPost;

  const UpdateNewsScreen({Key? key, required this.newsPost}) : super(key: key);

  @override
  State<UpdateNewsScreen> createState() => _UpdateNewsScreenState();
}

class _UpdateNewsScreenState extends State<UpdateNewsScreen> {
  List<ContentManageWidget> dynamicList = [];
  TitleManageWidget titleNewsWidget = TitleManageWidget();

  List<Titles> listTitle = [];
  bool loading = false;

  onDeleteVar(int val) {
    setState(
      () => {
        listTitle = [],
        dynamicList.forEach((element) => {
              listTitle.add(Titles(
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

  setDataToDynamic(List<Titles> titleList) {
    resetList();
    for (int i = 0; i < titleList.length; i++) {
      dynamicList.add(ContentManageWidget(removeItem: onDeleteVar, index: i));
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
    dynamicList.add(ContentManageWidget(
        index: dynamicList.length, removeItem: onDeleteVar, id: ""));
  }

  clearScreen() {
    setNewsTitleWidget(widget.newsPost);
    setState(() {});
  }

  checkValidate() {
    listTitle = [];
    dynamicList.forEach((element) => {
          listTitle.add(Titles(
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
    setState(() {
      loading = true;
    });
    if (checkValidate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Dữ liệu nhập vào còn thiếu. Vui lòng kiểm tra lại.')),
      );
      setState(() {
        loading = false;
      });
    } else {
      List<Titles> listTitleNews = [];
      List<String> contents = [];
      for (int i = 0; i < dynamicList.length; i++) {
        String idTitle = listTitle[i].id!;
        String titleTitle = listTitle[i].title!;
        String titleContent = listTitle[i].content!;
        String titleImage = listTitle[i].image!;
        listTitleNews.add(Titles(
            id: idTitle,
            title: titleTitle,
            content: titleContent,
            image: titleImage));

        contents.add(titleContent);
      }
      String title = titleNewsWidget.titleController.text;
      String image = titleNewsWidget.filePath;
      String id = titleNewsWidget.id!;
      String timeRead = getReadTime(contents);
      News news = News(
          id: id,
          title: title,
          image: image,
          listTitle: listTitleNews,
          timeRead: timeRead);
      FirebaseHandler.updateNew(news).then((value) {
        setState(() {
          loading = false;
        });
        Get.back(result: 'success');
      });
    }
  }

  @override
  void initState() {
    setNewsTitleWidget(widget.newsPost);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
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
              title: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Text("Cập nhật tin tức",
                    style: kDefaultTextStyle.copyWith(
                        fontSize: 24,
                        color: Color.fromARGB(255, 142, 142, 142)),
                    textAlign: TextAlign.center),
              ),
              centerTitle: true,
              actions: <Widget>[
                GestureDetector(
                  onTap: clearScreen,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xffBFBFBF),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(MdiIcons.eraser),
                  ),
                ),
                horizontalSpaceSmall,
                GestureDetector(
                  onTap: saveScreen,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                        color: Color(0xffBFBFBF),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    child: Icon(MdiIcons.contentSaveOutline),
                  ),
                ),
                horizontalSpaceTiny
              ],
            ),
            // extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                        child: Text("Tiêu đề bài báo",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    titleNewsWidget,
                    verticalSpaceTiny,
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Text(
                            "Người đăng/sửa bài: ${widget.newsPost.source!} \nThời gian: ${widget.newsPost.time}",
                            style: ktsMediumLabelInputText)),
                    verticalSpaceTiny,
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
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: addDynamic,
              child: Icon(Icons.add),
              backgroundColor: Color(0xffBFBFBF),
            ));
  }
}

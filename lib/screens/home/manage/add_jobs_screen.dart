// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/other/loading_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/jobs.dart';
import '../../../models/titles.dart';
import '../../../resources/firebase_handle.dart';
import '../../../resources/support_function.dart';
import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../../widgets/home/manage/content_manage_widget.dart';
import '../../../widgets/home/manage/title_manage_widget.dart';

class AddJobsScreen extends StatefulWidget {
  const AddJobsScreen({Key? key}) : super(key: key);

  @override
  State<AddJobsScreen> createState() => _AddJobsScreenState();
}

class _AddJobsScreenState extends State<AddJobsScreen> {
  List<ContentManageWidget> dynamicList = [];
  TitleManageWidget titleJobsWidget = TitleManageWidget();

  List<String> contents = [];
  List<String> filePaths = [];
  List<String> titles = [];

  bool loading = false;

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
    dynamicList.add(ContentManageWidget(
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
    titleJobsWidget.titleController.text = "";
    setState(() {});
  }

  checkValidate() {
    dynamicList.forEach((element) => {
          titles.add(element.titleController.text),
          contents.add(element.contentController.text),
          filePaths.add(element.filePath)
        });
    String titleJobs = titleJobsWidget.titleController.text;
    String imageJobs = titleJobsWidget.filePath;
    int checkContentEmpty = 0;
    contents.forEach((element) => {if (element.isEmpty) checkContentEmpty++});
    return titleJobs.isEmpty || checkContentEmpty > 0 || imageJobs.isEmpty;
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
      List<Titles> listTitleJobs = [];
      for (int i = 0; i < dynamicList.length; i++) {
        listTitleJobs.add(Titles(
            title: titles[i], content: contents[i], image: filePaths[i]));
      }
      String title = titleJobsWidget.titleController.text;
      String image = titleJobsWidget.filePath;
      String timeRead = getReadTime(contents);
      Jobs job = Jobs(
          title: title,
          image: image,
          listTitle: listTitleJobs,
          timeRead: timeRead);
      FirebaseHandler.addJobs(job).then(
        (value) {
          setState(() {
            loading = false;
          });
          Get.back(result: "success");
        },
      );
    }
  }

  @override
  void initState() {
    dynamicList.add(ContentManageWidget(
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
                child: Text("Thêm tin tức",
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
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                        child: Text("Tiêu đề bài báo",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    titleJobsWidget,
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                        child: Text("Nội dung bài báo",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    dynamicTextField,
                  ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: addDynamic,
              child: Icon(Icons.add),
              backgroundColor: Color(0xffBFBFBF),
            ));
  }
}

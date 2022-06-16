// ignore_for_file: prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../models/jobs.dart';
import '../../../models/titles.dart';
import '../../../resources/firebase_handle.dart';
import '../../../resources/support_function.dart';
import '../../../utils/constants.dart';
import '../../../utils/styles.dart';
import '../../../widgets/alert.dart';
import '../../../widgets/home/manage/content_manage_widget.dart';
import '../../../widgets/home/manage/title_manage_widget.dart';
import '../../other/loading_screen.dart';

class UpdateJobsScreen extends StatefulWidget {
  final Jobs jobsPost;

  const UpdateJobsScreen({Key? key, required this.jobsPost}) : super(key: key);

  @override
  State<UpdateJobsScreen> createState() => _UpdateJobsScreenState();
}

class _UpdateJobsScreenState extends State<UpdateJobsScreen> {
  List<ContentManageWidget> dynamicList = [];
  TitleManageWidget titleJobsWidget = TitleManageWidget();
  String TITLE_JOBS = "Cập nhật trường nghề";

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

  setJobsTitleWidget(Jobs jobs) {
    titleJobsWidget.titleController.text = jobs.title!;
    titleJobsWidget.filePath = jobs.image!;
    titleJobsWidget.id = jobs.id;

    setDataToDynamic(jobs.listTitle!);
  }

  addDynamic() {
    setState(() {});
    dynamicList.add(ContentManageWidget(
        index: dynamicList.length, removeItem: onDeleteVar, id: ""));
  }

  clearScreen() {
    setState(() {
      Alerts().confirm(
          "Bạn có muốn xoá những gì vừa nhập không?", 'Đồng ý', 'Hủy', () {
        setJobsTitleWidget(widget.jobsPost);
        setState(() {});
        Get.back();
      }, () => Get.back(), context);
    });
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
    String titleJobs = titleJobsWidget.titleController.text;
    String imageJobs = titleJobsWidget.filePath;
    int checkContentEmpty = 0;
    listTitle.forEach(
        (element) => {if (element.content!.isEmpty) checkContentEmpty++});
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
      List<String> contents = [];
      for (int i = 0; i < dynamicList.length; i++) {
        String idTitle = listTitle[i].id!;
        String titleTitle = listTitle[i].title!;
        String titleContent = listTitle[i].content!;
        String titleImage = listTitle[i].image!;
        listTitleJobs.add(Titles(
            id: idTitle,
            title: titleTitle,
            content: titleContent,
            image: titleImage));

        contents.add(titleContent);
      }
      String title = titleJobsWidget.titleController.text;
      String image = titleJobsWidget.filePath;
      String id = titleJobsWidget.id!;
      String timeRead = getReadTime(contents);
      Jobs jobs = Jobs(
          id: id,
          title: title,
          image: image,
          listTitle: listTitleJobs,
          timeRead: timeRead);
      FirebaseHandler.updateJobs(jobs).then((value) {
        setState(() {
          loading = false;
        });
        Get.back(result: 'success');
      });
    }
  }

  @override
  void initState() {
    setJobsTitleWidget(widget.jobsPost);
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
                padding: EdgeInsets.only(
                    top: 10,
                    bottom: 5,
                    left: TITLE_JOBS.length.toDouble() * 0.4),
                child: Text(TITLE_JOBS,
                    style: kDefaultTextStyle.copyWith(
                        fontSize: 24,
                        color: Color.fromARGB(255, 142, 142, 142))),
              ),
              titleSpacing: 0,
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
                        child: Text("Tiêu đề trường nghề",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    titleJobsWidget,
                    verticalSpaceTiny,
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Text(
                            "Người đăng/sửa bài: ${widget.jobsPost.source!} \nThời gian: ${widget.jobsPost.time}",
                            style: ktsMediumLabelInputText)),
                    verticalSpaceTiny,
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 12, 5, 5),
                        child: Text("Nội dung trường nghề",
                            style: ktsMediumTitleText.copyWith(
                                color: Colors.black))),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dynamicList.length,
                      itemBuilder: (_, index) => dynamicList[index],
                    ),
                    verticalSpaceLarge,
                  ]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: addDynamic,
              child: Icon(Icons.add),
              backgroundColor: Color(0xffBFBFBF),
            ));
  }
}

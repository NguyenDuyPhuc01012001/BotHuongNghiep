// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../models/jobs.dart';
import '../../../resources/firebase_handle.dart';
import '../../../screens/home/manage/update_jobs_screen.dart';
import '../../../screens/other/error_screen.dart';
import '../../../utils/styles.dart';
import '../../alert.dart';

class JobsManageBody extends StatefulWidget {
  final bool descending;
  final String search;

  const JobsManageBody(
      {Key? key, required this.descending, required this.search})
      : super(key: key);

  @override
  State<JobsManageBody> createState() => _JobsManageBodyState();
}

class _JobsManageBodyState extends State<JobsManageBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Jobs>>(
        future: FirebaseHandler.getListJobs(widget.descending),
        builder: (BuildContext context, AsyncSnapshot<List<Jobs>> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }

          List<Jobs> jobsdocs = snapshot.data!;
          jobsdocs = jobsdocs
              .where((element) => TiengViet.parse(element.title!.toLowerCase())
                  .contains(TiengViet.parse(widget.search.toLowerCase())))
              .toList();
          if (jobsdocs.isEmpty) {
            return Center(
                child: Text(
              "Không có kết quả",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: jobsdocs.length + 1,
                      itemBuilder: ((context, index) {
                        if (index == jobsdocs.length) {
                          return verticalSpaceLarge;
                        }
                        return Dismissible(
                          key: UniqueKey(),

                          // only allows the user swipe from right to left
                          direction: DismissDirection.endToStart,

                          // Remove this product from the list
                          // In production enviroment, you may want to send some request to delete it on server side
                          onDismissed: (_) {
                            setState(() {
                              Alerts().confirm(
                                  "Bạn có muốn xoá bài đăng này không?",
                                  'Đồng ý',
                                  'Hủy', () async {
                                await FirebaseHandler.deleteJobs(
                                        jobsdocs[index].id!)
                                    .whenComplete(
                                        () => {Get.back(), setState(() {})});
                              }, () => Get.back(), context);
                            });
                          },

                          // Display item's title, price...
                          child: Card(
                            elevation: 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: InkWell(
                              onTap: () async {
                                final result = await Get.to(UpdateJobsScreen(
                                    jobsPost: jobsdocs[index]));
                                if (result != null) {
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      "${index + 1}",
                                      style: kDefaultTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    backgroundColor: Color(0xffBFBFBF),
                                  ),
                                  title: Text(jobsdocs[index].title!,
                                      style: kDefaultTextStyle,
                                      textAlign: TextAlign.justify),
                                  subtitle: RichText(
                                      text: TextSpan(
                                    text: 'Đăng vào ',
                                    style: kDefaultTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: jobsdocs[index].time!,
                                          style: kDefaultTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ),

                          // This will show up when the user performs dismissal action
                          // It is a red background and a trash icon
                          background: Card(
                            elevation: 20,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            color: Colors.red,
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }))),
            );
          }
        });
  }
}

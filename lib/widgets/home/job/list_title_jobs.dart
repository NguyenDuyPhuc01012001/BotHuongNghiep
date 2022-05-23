// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/jobs.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';

import '../../../resources/firebase_reference.dart';
import '../../../resources/support_function.dart';
import '../../../screens/home/detailpage/jobs_page_screen.dart';

class ListTitleJobs extends StatefulWidget {
  final int limited;
  final bool descending;
  const ListTitleJobs(
      {Key? key, required this.limited, required this.descending})
      : super(key: key);

  @override
  State<ListTitleJobs> createState() => _ListTitleJobsState();
}

class _ListTitleJobsState extends State<ListTitleJobs> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> jobsStream = widget.limited == 0
        ? jobsFR.orderBy('time', descending: widget.descending).snapshots()
        : jobsFR.orderBy('time').limit(widget.limited).snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: jobsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }

          List<Jobs> jobsdocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Jobs jobs = Jobs.fromSnap(document);
            jobsdocs.add(jobs);
          }).toList();

          return Column(children: [
            for (var i = 0; i < jobsdocs.length; i++) ...[
              GestureDetector(
                  onTap: () {
                    Get.to(JobsPageScreen(jobsPostID: jobsdocs[i].id!));
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: jobsdocs[i].image!,
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(getTruncatedTitle(jobsdocs[i].title!, 60),
                                    style: kDefaultTextStyle),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${jobsdocs[i].timeRead!} đọc",
                                      style: kItemText,
                                    ),
                                    Text(
                                      jobsdocs[i].time!,
                                      style: kItemText,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )))
            ]
          ]);
        });
  }
}

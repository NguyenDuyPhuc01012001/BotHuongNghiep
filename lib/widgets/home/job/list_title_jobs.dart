// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/model/jobs.dart';
import 'package:huong_nghiep/utils/styles.dart';

import '../../../resources/firebase_reference.dart';
import '../../../resources/support_function.dart';
import '../../../screens/home/detailpage/jobs_page_screen.dart';

class ListTitleJobs extends StatefulWidget {
  const ListTitleJobs({Key? key}) : super(key: key);

  @override
  State<ListTitleJobs> createState() => _ListTitleJobsState();
}

class _ListTitleJobsState extends State<ListTitleJobs> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> jobsStream = jobsFR.snapshots();
    List<Jobs> jobsdocs = [];
    return StreamBuilder<QuerySnapshot>(
        stream: jobsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Jobs jobs = Jobs.fromSnap(document);
            jobsdocs.add(jobs);
            print(jobsdocs);
          }).toList();

          return Column(children: [
            for (var i = 0; i < jobsdocs.length; i++) ...[
              GestureDetector(
                  onTap: () {
                    Get.to(JobsPageScreen(JobsPostID: jobsdocs[i].id!));
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
                              children: [
                                SizedBox(height: 10),
                                Text(getTruncatedTitle(jobsdocs[i].title!, 60),
                                    style: kItemText.copyWith(
                                        fontWeight: FontWeight.normal)),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(jobsdocs[i].define! + jobsdocs[i].income! + jobsdocs[i].qualities!).split(' ').length >= 200 ? ((jobsdocs[i].define! + jobsdocs[i].income! + jobsdocs[i].qualities!).split(' ').length / 200).floor() : ((jobsdocs[i].define! + jobsdocs[i].income! + jobsdocs[i].qualities!).split(' ').length / 200 * 60).floor()} ${(jobsdocs[i].define! + jobsdocs[i].income! + jobsdocs[i].qualities!).split(' ').length >= 200 ? "phút" : "giây"} đọc",
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

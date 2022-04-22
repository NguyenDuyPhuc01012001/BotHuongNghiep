// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/model/jobs/jobs.dart';
import 'package:huong_nghiep/screens/home/jobs/jobs_page_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';

import '../../../utils/values.dart';

class ListTitleJobs extends StatelessWidget {
  ListTitleJobs({Key? key}) : super(key: key);

  final List<Jobs> jobs = StaticValues().jobs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(jobs.length, (index) {
        Jobs jobsItem = jobs[index];
        int jobsDescriptionLength = jobsItem.description.split(' ').length;
        return GestureDetector(
          onTap: () {
            Get.to(JobPageScreen(jobsPost: jobsItem));
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
                    imageUrl: jobsItem.image,
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
                      Text(getTruncatedTitle(jobsItem.title, 60),
                          style: kItemText.copyWith(fontSize: h4)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${jobsDescriptionLength >= 200 ? (jobsDescriptionLength / 200).floor() : (jobsDescriptionLength / 200 * 60).floor()} ${jobsDescriptionLength >= 200 ? "mins" : "secs"} read",
                            style: kItemText,
                          ),
                          Text(
                            jobsItem.time,
                            style: kItemText,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }
}

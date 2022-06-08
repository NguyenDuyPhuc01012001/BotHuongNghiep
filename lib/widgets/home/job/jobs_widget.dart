// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/list/list_job_screen.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/utils/styles.dart';
import 'package:huong_nghiep/widgets/home/job/jobs_carousel.dart';
import 'package:huong_nghiep/widgets/home/job/list_title_jobs.dart';

class JobsWidget extends StatelessWidget {
  const JobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            width: size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 8.0, top: 4.0),
                    child: Text(
                      "Bài đăng ngẫu nhiên",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  JobsCarousel(),
                  verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bài đăng mới nhất",
                          style: TextStyle(fontSize: 24),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ListJobScreen());
                          },
                          child: Row(
                            children: [
                              Text("Xem thêm",
                                  style: kDefaultTextStyle.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18)),
                              horizontalSpaceTiny,
                              Icon(Icons.arrow_forward, size: 32),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ListTitleJobs(
                          limited: 3,
                          descending: true,
                        )
                      ],
                    ),
                  ),
                  verticalSpaceLarge
                ],
              ),
            )),
      ),
    );
  }
}

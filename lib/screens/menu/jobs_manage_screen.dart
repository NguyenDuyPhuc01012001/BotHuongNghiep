// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/home/manage/jobs_manage_body.dart';
import '../manageJobs/add_jobs_screen.dart';

class JobsManageScreen extends StatefulWidget {
  const JobsManageScreen({Key? key}) : super(key: key);

  @override
  _JobsManageScreenState createState() => _JobsManageScreenState();
}

class _JobsManageScreenState extends State<JobsManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quản lí bài đăng'),
            IconButton(
                onPressed: () => {Get.to(AddJobsScreen())},
                icon: Icon(Icons.add))
          ],
        ),
      ),
      body: JobsManageBody(),
    );
  }
}

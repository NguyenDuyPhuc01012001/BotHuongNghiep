// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../widgets/home/manage/admin_manage_body.dart';

class AdminManageScreen extends StatefulWidget {
  const AdminManageScreen({Key? key}) : super(key: key);

  @override
  State<AdminManageScreen> createState() => _AdminManageScreenState();
}

class _AdminManageScreenState extends State<AdminManageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lí danh sách người dùng'),
      ),
      body: AdminManageBody(),
    );
  }
}

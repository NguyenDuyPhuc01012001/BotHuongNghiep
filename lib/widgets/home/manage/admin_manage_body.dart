// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../../resources/firebase_handle.dart';

class AdminManageBody extends StatefulWidget {
  const AdminManageBody({Key? key}) : super(key: key);

  @override
  State<AdminManageBody> createState() => _AdminManageBodyState();
}

class _AdminManageBodyState extends State<AdminManageBody> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> userStream = userFR.snapshots();
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: userStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          final List userdocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            userdocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(240),
                  2: FixedColumnWidth(60),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Vai trò',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                '',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < userdocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Center(
                                child: Text(userdocs[i]['email'],
                                    style: TextStyle(fontSize: 14.0))),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Center(
                                child: Text(
                                    userdocs[i]['isAdmin']
                                        ? "Quản trị viên"
                                        : "Người dùng",
                                    style: TextStyle(fontSize: 14.0))),
                          ),
                        ),
                        TableCell(
                          child: uid == userdocs[i]['id']
                              ? SizedBox()
                              : IconButton(
                                  onPressed: () => {
                                        Dialogs.materialDialog(
                                            msg:
                                                'Bạn có muốn thay đổi quyền của người dùng này không?',
                                            title: "Vai trò",
                                            color: Colors.white,
                                            context: context,
                                            actions: [
                                              IconsButton(
                                                onPressed: () async {
                                                  await FirebaseHandler
                                                          .updateRoleFirestore(
                                                              true,
                                                              userdocs[i]['id'])
                                                      .whenComplete(
                                                          () => Get.back());
                                                },
                                                text: 'Admin',
                                                iconData:
                                                    Icons.account_box_outlined,
                                                color: Colors.red,
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                iconColor: Colors.white,
                                              ),
                                              IconsButton(
                                                onPressed: () async {
                                                  await FirebaseHandler
                                                          .updateRoleFirestore(
                                                              false,
                                                              userdocs[i]['id'])
                                                      .whenComplete(
                                                          () => Get.back());
                                                },
                                                text: 'User',
                                                iconData:
                                                    Icons.people_alt_rounded,
                                                color: Colors.blue,
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                iconColor: Colors.white,
                                              ),
                                              IconsOutlineButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                text: 'Cancel',
                                                iconData: Icons.cancel_outlined,
                                                textStyle: TextStyle(
                                                    color: Colors.grey),
                                                iconColor: Colors.grey,
                                              ),
                                            ])
                                      },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                  )),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}

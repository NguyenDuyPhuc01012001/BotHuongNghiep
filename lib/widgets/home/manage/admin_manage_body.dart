// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';

import '../../../resources/firebase_handle.dart';
import '../../../screens/other/error_screen.dart';
import '../../../utils/styles.dart';
import '../../alert.dart';

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
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
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
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: userdocs.length,
                    itemBuilder: ((context, index) {
                      return Dismissible(
                        key: UniqueKey(),

                        // only allows the user swipe from right to left
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async =>
                            uid != userdocs[index]['id'],

                        // Remove this product from the list
                        // In production enviroment, you may want to send some request to delete it on server side
                        onDismissed: (_) {
                          setState(() {
                            Alerts().confirm(
                                userdocs[index]['isAdmin']
                                    ? "Hi???n t???i vai tr?? c???a ng?????i n??y l?? Qu???n tr??? vi??n. B???n c?? mu???n thay ?????i vai tr?? c???a ${userdocs[index]['email']}?"
                                    : "Hi???n t???i vai tr?? c???a ng?????i n??y l?? Ng?????i d??ng. B???n c?? mu???n thay ?????i vai tr?? c???a ${userdocs[index]['email']}?",
                                '?????ng ??',
                                'H???y', () async {
                              await FirebaseHandler.updateRoleFirestore(
                                      !userdocs[index]['isAdmin'],
                                      userdocs[index]['id'])
                                  .whenComplete(() => Get.back());
                            }, () => Get.back(), context);
                          });
                        },

                        // Display item's title, price...
                        child: Card(
                          elevation: 20,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
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
                                backgroundColor: uid == userdocs[index]['id']
                                    ? Colors.orange
                                    : Color(0xffBFBFBF),
                              ),
                              title: Text(userdocs[index]['email'],
                                  style: kDefaultTextStyle.copyWith(
                                      color: uid == userdocs[index]['id']
                                          ? Colors.orange
                                          : Colors.black,
                                      fontWeight: uid == userdocs[index]['id']
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                  textAlign: TextAlign.justify),
                              subtitle: Text(
                                  userdocs[index]['isAdmin']
                                      ? "Vai tr??: Qu???n tr??? vi??n"
                                      : "Vai tr??: Ng?????i d??ng",
                                  style: kDefaultTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: uid == userdocs[index]['id']
                                          ? Colors.orange
                                          : Colors.black),
                                  textAlign: TextAlign.justify),
                              trailing: uid == userdocs[index]['id']
                                  ? Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ),

                        // This will show up when the user performs dismissal action
                        // It is a red background and a trash icon
                        background: Card(
                          elevation: 20,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          color: Colors.green,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }))),
          );
        });
  }
}

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:huong_nghiep/model/user.dart';
import 'firebase_reference.dart';

class FirebaseHandler {
  static updateImageToFirestore(String url, String uid) async {
    var doc = userFR.doc(uid);
    await doc
        .update({'image': url})
        .then((value) => print("User Updated Image"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static updateNameFirestore(String name, String uid) async {
    var doc = userFR.doc(uid);
    await doc
        .update({'name': name})
        .then((value) => print("User Updated Names"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> uploadFile(String filePath, String uid) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('users/$uid/user_image.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('users/$uid/user_image.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of Image $url");

            await FirebaseHandler.updateImageToFirestore(url, uid);
          }).catchError((onError) {
            print("Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  static Future<UserData> getUser(String uid) async => await userFR
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        return UserData.fromSnap(documentSnapshot);
      });

  static Future<String> getDefaultImage() async {
    String urlString = '';
    await FirebaseStorage.instance
        .ref('default/default_avatar.jpg')
        .getDownloadURL()
        .then((url) async {
      print("Here is the URL of Image $url");
      urlString = url;
    });
    print(urlString);
    return urlString;
  }

  static Future<void> deleteNews(id) {
    return newsFR
        .doc(id)
        .delete()
        .then((value) => print('News Deleted'))
        .catchError((error) => print('Failed to Delete news: $error'));
  }

  static getNewsData() async {
    List newsList = [];
    await newsFR.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map val = doc.data() as Map<String, dynamic>;
        val['id'] = doc.id;
        newsList.add(val);
      }
    });
    print('News: ' + newsList.toString());
    return newsList;
  }
}

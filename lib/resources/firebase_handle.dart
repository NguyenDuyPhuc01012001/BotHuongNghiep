// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:huong_nghiep/model/news/news.dart';
import 'package:huong_nghiep/model/user.dart';
import 'auth_methods.dart';
import 'firebase_reference.dart';

class FirebaseHandler {
  static Future<UserData> getCurrentUser() async =>
      await AuthMethods().getUserDetails().then((data) {
        return UserData(
            email: data.email,
            name: data.name,
            uid: data.uid,
            image: data.image,
            isAdmin: data.isAdmin);
      });

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
    return urlString;
  }

  static Future<void> deleteNews(id) {
    return newsFR.doc(id).delete().then((value) {
      FirebaseStorage.instance.ref("news/$id").listAll().then((value) {
        for (var element in value.items) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        }
      });
    }).catchError((error) => print('Failed to Delete news: $error'));
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
    return newsList;
  }

  static Future<void> uploadNewsImage(String filePath, String newsID) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('news/$newsID/news_image.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('news/$newsID/news_image.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of Image $url");

            await FirebaseHandler.updateNewsImageToFirestore(url, newsID);
          }).catchError((onError) {
            print("Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  static updateNewsImageToFirestore(String url, String newsID) async {
    var doc = newsFR.doc(newsID);
    await doc
        .update({'image': url})
        .then((value) => print("News Updated Image"))
        .catchError((error) => print("Failed to update news: $error"));
  }

  static Future<void> addNews(
      String title, String description, String filePath) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await newsFR.add({
      'title': title,
      'description': description,
      'source': user.name,
      'sourceImage': user.image,
      'time': myTimeStamp
    }).then((value) async {
      await uploadNewsImage(filePath, value.id);
    }).catchError((error) => print('Failed to Add news: $error'));
  }

  static Future<void> updateNews(
      String newsID, String title, String description, String filePath) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await newsFR
        .doc(newsID)
        .update({
          'title': title,
          'description': description,
          'source': user.name,
          'sourceImage': user.image,
          'time': myTimeStamp
        })
        .then((value) async => await uploadNewsImage(filePath, newsID))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static addToFavorite(
      String id, String type, String title, String image) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    CollectionReference favoriteFR =
        userFR.doc(user.uid).collection('favorite');
    return await favoriteFR
        .add({
          'favoriteID': id,
          'favoriteType': type,
          'title': title,
          'image': image,
          'time': myTimeStamp
        })
        .then((value) => print("Add Favorite ${value.id} successfull"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static deleteFromFavorite(String id) async {
    UserData user = await getCurrentUser();
    CollectionReference favoriteFR =
        userFR.doc(user.uid).collection('favorite');
    List<String> listID = [];
    await favoriteFR
        .where('favoriteID', isEqualTo: id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        listID.add(doc.id);
      }
    });
    return favoriteFR.doc(listID.first).delete().then((value) {
      print("Delete Favorite $id successful");
    }).catchError((error) => print('Failed to Delete news: $error'));
  }

  static Stream<QuerySnapshot<Object?>> getListFavorite() async* {
    UserData user = await getCurrentUser();
    CollectionReference favoriteFR =
        userFR.doc(user.uid).collection('favorite');
    yield* favoriteFR.snapshots();
  }

  static getNewsByID(String id) async {
    News news = News();
    await newsFR.doc(id).get().then((value) {
      news = News.fromSnap(value);
    });

    return news;
  }
}

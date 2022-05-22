// ignore_for_file: avoid_print, invalid_return_type_for_catch_error, unused_local_variable, avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:huong_nghiep/models/jobs.dart';
import 'package:huong_nghiep/models/news.dart';
import 'package:huong_nghiep/models/titles.dart';
import 'package:huong_nghiep/models/user.dart';
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

  static updateRoleFirestore(bool isAdmin, String uid) async {
    var doc = userFR.doc(uid);
    await doc
        .update({'isAdmin': isAdmin})
        .then((value) => print("User Updated Role"))
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

  static Future<void> uploadPostsImage(String filePath, String postID) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('posts/$postID/post_image.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("posts task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('posts/$postID/post_image.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of Post Image $url");

            await FirebaseHandler.updatePostImageToFirestore(url, postID);
          }).catchError((onError) {
            print("Posts Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  static updatePostImageToFirestore(String url, String postID) async {
    var doc = postsFR.doc(postID);
    await doc
        .update({'image': url})
        .then((value) => print("Post Updated Image"))
        .catchError((error) => print("Failed to update post: $error"));
  }

  static addToFavorite(
      String id, String type, String title, String image) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await userFR
        .doc(user.uid)
        .collection('favorite')
        .add({
          'favoriteID': id,
          'favoriteType': type,
          'title': title,
          'image': image,
          'time': myTimeStamp
        })
        .then((value) => print("Add Favorite ${value.id} successfull"))
        .catchError((error) => print("Failed to update favorite: $error"));
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
    yield* favoriteFR.orderBy('time').snapshots();
  }

  static Stream<QuerySnapshot<Object?>> getListQuiz() async* {
    UserData user = await getCurrentUser();
    CollectionReference quizFR = userFR.doc(user.uid).collection('quiz');
    yield* quizFR.snapshots();
  }

  static Stream<DocumentSnapshot<Object?>> getListQuizScore(
      String type) async* {
    UserData user = await getCurrentUser();
    DocumentReference quizFR =
        userFR.doc(user.uid).collection('quiz').doc(type);
    // print(user.uid);
    // print(type);
    // print(quizFR);
    // print(quizFR.snapshots());
    yield* quizFR.snapshots();
  }

  static Future<void> updateQuizScores(String type, Map<String, int> sc) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await userFR
        .doc(user.uid)
        .collection('quiz')
        .doc(type)
        .set(sc)
        .then((value) async => print("Update successfully"))
        .catchError((error) => print("Failed to update score: $error"));
  }

  static Future<void> addPost(String question, String filePath) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await postsFR.add({
      'uid': user.uid,
      'email': user.email,
      'userImage': user.image,
      'question': question,
      'image': "",
      'numAnswer': 0,
      'time': myTimeStamp
    }).then((value) async {
      if (filePath != "") {
        await uploadPostsImage(filePath, value.id);
      }
    }).catchError((error) => print('Failed to Add news: $error'));
  }

  static deletePost(String postID) async {
    return postsFR.doc(postID).delete().then((value) {
      FirebaseStorage.instance.ref("posts/$postID").listAll().then((value) {
        for (var element in value.items) {
          FirebaseStorage.instance.ref(element.fullPath).delete();
        }
      });
    }).catchError((error) => print('Failed to Delete posts: $error'));
  }

  static addAnswerPost(String message, String postID) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    return await postsFR.doc(postID).collection("answers").add({
      'source': user.name,
      'sourceImage': user.image,
      'answer': message,
      'time': myTimeStamp
    }).then((value) async {
      await postsFR.doc(postID).update({'numAnswer': FieldValue.increment(1)});
    }).catchError((error) => print('Failed to Add answers: $error'));
  }

  // START NEWS

  // Add News to FireStore
  static Future<void> addNews(News news) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await newsFR.add({
      'title': news.title,
      'description': "",
      'source': user.name,
      'sourceImage': user.image,
      'time': myTimeStamp,
      'timeRead': news.timeRead
    }).then((fNews) async {
      await uploadNewsImage(news.image!, fNews.id);
      for (Titles element in news.listTitle!) {
        await newsFR
            .doc(fNews.id)
            .collection("titles")
            .add({'title': element.title, 'content': element.content}).then(
                (fTitle) async {
          if (element.image!.isNotEmpty) {
            await uploadNewsTitleImage(element.image!, fNews.id, fTitle.id);
          }
        });
      }
    }).catchError((error) => print('Failed to Add news: $error'));
  }

  // Upload News Contents Image to Storage
  static Future<void> uploadNewsTitleImage(
      String filePath, String newsID, String titlesID) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('news/$newsID/$titlesID.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("news task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('news/$newsID/$titlesID.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of News Image $url");

            await FirebaseHandler.updateNewsTitleImageToFirestore(
                url, newsID, titlesID);
          }).catchError((onError) {
            print("News Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  // Update News Contents Image From Storage to FireStore
  static updateNewsTitleImageToFirestore(
      String url, String newsID, String titlesID) async {
    var doc = newsFR.doc(newsID).collection("titles").doc(titlesID);
    await doc
        .update({'image': url})
        .then((value) => print("News Updated Image"))
        .catchError((error) => print("Failed to update news: $error"));
  }

  // Upload News Image to Storage
  static Future<void> uploadNewsImage(String filePath, String newsID) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('news/$newsID/news_image.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("news task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('news/$newsID/news_image.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of News Image $url");

            await FirebaseHandler.updateNewsImageToFirestore(url, newsID);
          }).catchError((onError) {
            print("News Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  // Update News Image From Storage to FireStore
  static updateNewsImageToFirestore(String url, String newsID) async {
    var doc = newsFR.doc(newsID);
    await doc
        .update({'image': url})
        .then((value) => print("News Updated Image"))
        .catchError((error) => print("Failed to update news: $error"));
  }

  // Get News by ID from FireStore
  static Future<News> getNewByID(String id) async {
    News news = News();
    await newsFR.doc(id).get().then((value) {
      news = News.fromSnap(value);
    });

    List<Titles> titleList = await getListNewsTitle(news.id!);
    news.listTitle = titleList;

    return news;
  }

  // Get List Titles News from colection(tiltes) from FireStore
  static Future<List<Titles>> getListNewsTitle(String newsId) async {
    List<Titles> titleList = [];
    QuerySnapshot titleQuerySnapshot =
        await newsFR.doc(newsId).collection("titles").get();

    if (titleQuerySnapshot.size > 0) {
      titleList = Titles.dataListFromSnapshot(titleQuerySnapshot);
    }

    return titleList;
  }

  // Get List News from FireStore
  static Future<List<News>> getListNews(bool descending) async {
    List<News> newsList = [];
    QuerySnapshot newsQuerySnapshot =
        await newsFR.orderBy('time', descending: descending).get();
    newsList = newsQuerySnapshot.docs.map((doc) => News.fromSnap(doc)).toList();

    for (int i = 0; i < newsList.length; i++) {
      List<Titles> listTitle = await getListNewsTitle(newsList[i].id!);
      newsList[i].listTitle = listTitle;
    }

    return newsList;
  }

  // Update News to FireStore
  static Future<void> updateNew(News news) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await newsFR.doc(news.id).update({
      'title': news.title,
      'description': "",
      'source': user.name,
      'sourceImage': user.image,
      'time': myTimeStamp,
      'timeRead': news.timeRead,
      'image': news.image!.contains("http") ? news.image : ""
    }).then((result) async {
      if (!news.image!.contains("http") && news.image!.isNotEmpty) {
        await uploadNewsImage(news.image!, news.id!);
      }
      for (Titles element in news.listTitle!) {
        element.id!.isEmpty
            ? await newsFR
                .doc(news.id!)
                .collection("titles")
                .add({'title': element.title, 'content': element.content}).then(
                    (fTitle) async {
                if (element.image!.isNotEmpty) {
                  await uploadNewsTitleImage(
                      element.image!, news.id!, fTitle.id);
                }
              }).catchError((error) =>
                    print("Failed to update news title without Image: $error"))
            : await newsFR
                .doc(news.id!)
                .collection("titles")
                .doc(element.id)
                .update({
                'title': element.title,
                'content': element.content,
                'image': element.image!.contains("http") ? element.image : ""
              }).then((result) async {
                if (!element.image!.contains("http") &&
                    element.image!.isNotEmpty) {
                  await uploadNewsTitleImage(
                      element.image!, news.id!, element.id!);
                }
              }).catchError((error) =>
                    print("Failed to update news title add Image: $error"));
      }
    }).catchError((error) => print("Failed to update news: $error"));
  }

  // Delete News from FireStore include colection(tiltes)
  static Future<void> deleteNews(id) {
    CollectionReference tiltesRef = newsFR.doc(id).collection("tiltes");
    Future<QuerySnapshot> tiltes = tiltesRef.get();
    return tiltes
        .then((value) => value.docs.forEach((element) {
              tiltesRef.doc(element.id).delete();
            }))
        .then((value) => newsFR.doc(id).delete().then((value) {
              FirebaseStorage.instance.ref("news/$id").listAll().then((value) {
                for (var element in value.items) {
                  FirebaseStorage.instance.ref(element.fullPath).delete();
                }
              });
            }).catchError((error) => print('Failed to Delete news: $error')));
  }

  // END NEWS

  // START JOBS

  // Upload Jobs Image to Storage
  static Future<void> uploadJobsImage(String filePath, String jobsID) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('jobs/$jobsID/jobs_image.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("jobs task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('jobs/$jobsID/jobs_image.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of Jobs Image $url");

            await FirebaseHandler.updateJobsImageToFirestore(url, jobsID);
          }).catchError((onError) {
            print("Jobs Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  // Update Jobs Image from Storage to FireStore
  static updateJobsImageToFirestore(String url, String jobsID) async {
    var doc = jobsFR.doc(jobsID);
    await doc
        .update({'image': url})
        .then((value) => print("Jobs Updated Image"))
        .catchError((error) => print("Failed to update jobs: $error"));
  }

  // Upload Jobs Contents Image to Storage
  static Future<void> uploadJobsTitleImage(
      String filePath, String jobsID, String titlesID) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref('jobs/$jobsID/$titlesID.jpg')
          .putFile(file)
          .then((taskSnapshot) async {
        print("jobs task done");

        // download url when it is uploaded
        if (taskSnapshot.state == TaskState.success) {
          await FirebaseStorage.instance
              .ref('jobs/$jobsID/$titlesID.jpg')
              .getDownloadURL()
              .then((url) async {
            print("Here is the URL of Jobs Image $url");

            await FirebaseHandler.updateJobsTitleImageToFirestore(
                url, jobsID, titlesID);
          }).catchError((onError) {
            print("Jobs Got Error $onError");
          });
        }
      });
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  // Update News Contents Image From Storage to FireStore
  static updateJobsTitleImageToFirestore(
      String url, String jobsID, String titlesID) async {
    var doc = jobsFR.doc(jobsID).collection("titles").doc(titlesID);
    await doc
        .update({'image': url})
        .then((value) => print("Jobs Updated Image"))
        .catchError((error) => print("Failed to update jobs: $error"));
  }

  // Add Jobs to FireStore
  static Future<void> addJobs(Jobs jobs) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await jobsFR.add({
      'title': jobs.title,
      'description': "",
      'source': user.name,
      'sourceImage': user.image,
      'time': myTimeStamp,
      'timeRead': jobs.timeRead
    }).then((fJobs) async {
      await uploadJobsImage(jobs.image!, fJobs.id);
      for (Titles element in jobs.listTitle!) {
        await jobsFR
            .doc(fJobs.id)
            .collection("titles")
            .add({'title': element.title, 'content': element.content}).then(
                (fTitle) async {
          if (element.image!.isNotEmpty) {
            await uploadJobsTitleImage(element.image!, fJobs.id, fTitle.id);
          }
        });
      }
    }).catchError((error) => print('Failed to Add jobs: $error'));
  }

  // Update Jobs to FireStore
  static Future<void> updateJobs(Jobs jobs) async {
    UserData user = await getCurrentUser();
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
    return await jobsFR.doc(jobs.id).update({
      'title': jobs.title,
      'description': "",
      'source': user.name,
      'sourceImage': user.image,
      'time': myTimeStamp,
      'timeRead': jobs.timeRead,
      'image': jobs.image!.contains("http") ? jobs.image : ""
    }).then((result) async {
      if (!jobs.image!.contains("http") && jobs.image!.isNotEmpty) {
        await uploadJobsImage(jobs.image!, jobs.id!);
      }
      for (Titles element in jobs.listTitle!) {
        element.id!.isEmpty
            ? await jobsFR
                .doc(jobs.id!)
                .collection("titles")
                .add({'title': element.title, 'content': element.content}).then(
                    (fTitle) async {
                if (element.image!.isNotEmpty) {
                  await uploadJobsTitleImage(
                      element.image!, jobs.id!, fTitle.id);
                }
              }).catchError((error) =>
                    print("Failed to update jobs title without Image: $error"))
            : await jobsFR
                .doc(jobs.id!)
                .collection("titles")
                .doc(element.id)
                .update({
                'title': element.title,
                'content': element.content,
                'image': element.image!.contains("http") ? element.image : ""
              }).then((result) async {
                if (!element.image!.contains("http") &&
                    element.image!.isNotEmpty) {
                  await uploadJobsTitleImage(
                      element.image!, jobs.id!, element.id!);
                }
              }).catchError((error) =>
                    print("Failed to update jobs title add Image: $error"));
      }
    }).catchError((error) => print("Failed to update jobs: $error"));
  }

  // Delete Jobs from FireStore include colection(tiltes)
  static Future<void> deleteJobs(id) {
    CollectionReference tiltesRef = jobsFR.doc(id).collection("tiltes");
    Future<QuerySnapshot> tiltes = tiltesRef.get();
    return tiltes
        .then((value) => value.docs.forEach((element) {
              tiltesRef.doc(element.id).delete();
            }))
        .then((value) => jobsFR.doc(id).delete().then((value) {
              FirebaseStorage.instance.ref("jobs/$id").listAll().then((value) {
                for (var element in value.items) {
                  FirebaseStorage.instance.ref(element.fullPath).delete();
                }
              });
            }).catchError((error) => print('Failed to Delete jobs: $error')));
  }

  // Get Jobs by ID from FireStore
  static Future<Jobs> getJobsByID(String id) async {
    Jobs jobs = Jobs();
    await jobsFR.doc(id).get().then((value) {
      jobs = Jobs.fromSnap(value);
    });

    List<Titles> titleList = await getListJobsTitle(jobs.id!);
    jobs.listTitle = titleList;

    return jobs;
  }

  // Get List Titles Jobs from colection(tiltes) from FireStore
  static Future<List<Titles>> getListJobsTitle(String jobsId) async {
    List<Titles> titleList = [];
    QuerySnapshot titleQuerySnapshot =
        await jobsFR.doc(jobsId).collection("titles").get();

    if (titleQuerySnapshot.size > 0) {
      titleList = Titles.dataListFromSnapshot(titleQuerySnapshot);
    }

    return titleList;
  }

  // Get List Jobs from FireStore
  static Future<List<Jobs>> getListJobs(bool descending) async {
    List<Jobs> jobsList = [];
    QuerySnapshot jobsQuerySnapshot =
        await jobsFR.orderBy('time', descending: descending).get();
    jobsList = jobsQuerySnapshot.docs.map((doc) => Jobs.fromSnap(doc)).toList();

    for (int i = 0; i < jobsList.length; i++) {
      List<Titles> listTitle = await getListJobsTitle(jobsList[i].id!);
      jobsList[i].listTitle = listTitle;
    }

    return jobsList;
  }

  // END JOBS
}

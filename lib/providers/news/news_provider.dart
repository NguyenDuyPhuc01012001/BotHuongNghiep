import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';

class NewsProvider extends ChangeNotifier {
  bool isFetching = false;
  String search = "";
  List newsList = [];

  getNewsData() async {
    isFetching = true;
    notifyListeners();

    newsList = await FirebaseHandler.getNewsData();

    isFetching = false;
    notifyListeners();
  }
}

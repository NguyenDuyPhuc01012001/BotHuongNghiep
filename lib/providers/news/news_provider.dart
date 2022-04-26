import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';

class NewsProvider extends ChangeNotifier {
  bool isFavorite = false;

  updateIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

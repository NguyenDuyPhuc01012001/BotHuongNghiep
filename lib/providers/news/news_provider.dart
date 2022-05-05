import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';

class NewsProvider extends ChangeNotifier {
  bool isFavorite = false;

  updateIsFavorite(String id, String title, String image) async {
    isFavorite = !isFavorite;
    if (isFavorite) {
      await FirebaseHandler.addToFavorite(id, "news", title, image);
    } else {
      await FirebaseHandler.deleteFromFavorite(id);
    }
    notifyListeners();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/model/storage.dart';
import 'package:huong_nghiep/model/user.dart';
import 'package:huong_nghiep/resources/auth_methods.dart';

import '../../screens/authentication/signin_screen.dart';

class HomeProvider extends ChangeNotifier {
  Future<UserData> currentUser = AuthMethods().getUserDetails();

  late final UserData user;
  bool isLoading = false;

  void getCurrentUser() async {
    currentUser.then((data) {
      user = UserData(
          email: data.email,
          name: data.name,
          uid: data.uid,
          image: data.image,
          isAdmin: data.isAdmin);
    });
  }

  void updateUserEmail(String email) {
    user.setEmail(email);
    notifyListeners();
  }

  void updateUserName(String name) {
    user.setName(name);
    notifyListeners();
  }

  void signOut() {
    AuthMethods().signOut();
    Get.offAll(SignInScreen());
  }

  setImage(String path) {
    user.setImage(path);
    print('set: ' + user.image);
    notifyListeners();
  }

  updateImageToStorage() {
    final storage = Storage();
    print(user.image);

    isLoading = true;
    notifyListeners();

    storage
        .uploadFile(user.image, user.uid)
        .then((value) => {isLoading = false, Get.back()});
    notifyListeners();
  }
}

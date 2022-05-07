// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/user.dart';
import 'package:huong_nghiep/resources/auth_methods.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';

import '../../screens/authentication/signin_screen.dart';

class HomeProvider extends ChangeNotifier {
  late UserData user;
  bool isLoading = false;

  Future<void> getCurrentUser() async =>
      await AuthMethods().getUserDetails().then((data) {
        user = UserData(
            email: data.email,
            name: data.name,
            uid: data.uid,
            image: data.image,
            isAdmin: data.isAdmin);
      });

  void updateUserEmail(String email) {
    user.setEmail(email);
    notifyListeners();
  }

  void updateUserName(String name) async {
    user.setName(name);
    await FirebaseHandler.updateNameFirestore(name, user.uid);
    notifyListeners();
  }

  void signOut() async {
    await AuthMethods().signOut();
    Get.offAll(SignInScreen());
  }

  setImage(String path) {
    user.setImage(path);
    notifyListeners();
  }

  updateImageToStorage(String filePath) async {
    isLoading = true;
    notifyListeners();

    await FirebaseHandler.uploadFile(filePath, user.uid).then((value) async {
      isLoading = false;
      Get.back();
      UserData userAfter = await FirebaseHandler.getUser(user.uid);
      user.setImage(userAfter.image);
      print('Image Update: ' + user.image);
      print('Get back');
      notifyListeners();
    });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:huong_nghiep/model/user.dart';
import 'package:huong_nghiep/resources/auth_methods.dart';

class HomeProvider extends ChangeNotifier {
  Future<UserApp> currentUser = AuthMethods().getUserDetails();
  late String userName;
  late String userEmail;

  void getCurrentUser() async {
    currentUser.then((data) {
      userName = data.name!;
      userEmail = data.email!;
    });
  }
}

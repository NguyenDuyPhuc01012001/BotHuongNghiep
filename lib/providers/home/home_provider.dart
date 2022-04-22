import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/model/user.dart';
import 'package:huong_nghiep/resources/auth_methods.dart';

import '../../screens/authentication/signin_screen.dart';

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

  void signOut() {
    AuthMethods().signOut();
    Get.offAll(SignInScreen());
  }
}

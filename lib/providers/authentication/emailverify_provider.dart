// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/authentication/signin_screen.dart';

class EmailVerifyProvider extends ChangeNotifier {
  bool _isLoading = false;
  final User _user = FirebaseAuth.instance.currentUser!;

  /// _currentState represent for current state of the screen.
  /// It is "false" if current state is when the user haven't click the send email button yet,
  /// and it will is "true" if the user clicked the send email button
  bool _currentState = false;
  get currentState => _currentState;
  get isLoading => _isLoading;
  String title = "Chỉ một bước nữa";
  String description =
      "Chúng tôi đã gửi một liên kết xác minh đến email này. Vui lòng kiểm tra email của bạn và xác nhận";
  String buttonContent = "Đi đến đăng nhập";
  void setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void onSubmitClick() async {
    // //User haven't clicked the send email button yet
    // if (_currentState == false) {
    //   await sendEmailVerification();
    //   changeCurrentState();
    // } else {
    //   Get.to(const SignInScreen());
    // }
    Get.to(SignInScreen());
  }

  Future<String> sendEmailVerification() async {
    if (!_user.emailVerified) {
      setIsLoading(true);
      await _user.sendEmailVerification();
      setIsLoading(false);
      Get.snackbar("Gửi Email", "Một email vừa được gửi tới ${_user.email}");
      return "success";
    }
    return "failed";
  }
}

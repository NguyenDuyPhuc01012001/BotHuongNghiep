// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/auth_methods.dart';
import '../../screens/authentication/emailverify_screen.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isValid = true;

  bool get isValid => _isValid;

  set isValid(bool value) => _isValid = value;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<String> signUp(
      {required String email,
      required String password,
      required String name}) async {
    _isLoading = true;
    notifyListeners();

    _errorMessage = await AuthMethods().registerUsingEmailPassword(
      name: name,
      email: email,
      password: password,
    );

    if (_errorMessage == "Success") {
      _isValid = true;
      Get.off(EmailVerifyScreen());
    } else {
      _isValid = false;
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();

    // if (user != null) {
    // await user.sendEmailVerification();
    // AwesomeDialog(
    //   context: context,
    //   dialogType: DialogType.INFO,
    //   animType: AnimType.BOTTOMSLIDE,
    //   title: 'Dialog Title',
    //   desc: 'Dialog description here.............',
    //   btnOkOnPress: () {
    //     Navigator.pop(context);
    //   },
    // )..show();
    // print("Done");
    // Navigator.pop(context);

    // }
    return _errorMessage;
  }
}

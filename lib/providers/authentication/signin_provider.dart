import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/other/slashing_screen.dart';

import '../../resources/auth_methods.dart';

class SignInProvider extends ChangeNotifier {
  bool _isValid = true;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isValid => _isValid;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<String> loginUser(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      _isValid = false;
      _errorMessage = "Vui lòng nhập đầy đủ thông tin";
      notifyListeners();
      return _errorMessage;
    }

    _isLoading = true;
    notifyListeners();

    _errorMessage =
        await AuthMethods().loginUser(email: email, password: password);
    if (_errorMessage == "Login success") {
      _isValid = true;
      Get.offAll(const SplashingScreen());
    } else {
      _isValid = false;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
    return _errorMessage;
  }

  void changeIsValidValue() {
    _isValid = !_isValid;
    notifyListeners();
  }
}

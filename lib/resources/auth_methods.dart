import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    String result = "Email không tồn tại";
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //add user to database
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'uid': userCredential.user!.uid,
        'email': email,
      });
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      await user?.sendEmailVerification();
      result = "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Mật khẩu quá yếu';
      } else if (e.code == 'email-already-in-use') {
        return 'Email này đã được sử dụng';
      }
    } catch (e) {
      return e.toString();
    }
    return result;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String result = "Login success";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(userCredential.user!.email);
      }
    } on FirebaseAuthException catch (e) {
      print("error return " + e.code);
      if (e.code == "user-not-found") {
        result = "Không tìm thấy tài khoản với email này";
      } else if (e.code == "wrong-password") {
        result = "Mật khẩu không chính xác";
      } else if (e.code == "invalid-email") {
        result = "Email sai định dạng";
      } else {
        result = "Hiện tại hệ thống đang có vấn đề, vui lòng thử lại sau";
      }
    }
    return result;
  }
}

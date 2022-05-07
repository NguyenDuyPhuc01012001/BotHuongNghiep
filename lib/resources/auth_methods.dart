// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';

import '../models/user.dart';

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

      //add user include favorite to database
      await userFR.doc(userCredential.user!.uid).set({
        'name': name,
        'uid': userCredential.user!.uid,
        'email': email,
        'isAdmin': false,
        'image': await FirebaseHandler.getDefaultImage()
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

        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            print('User is not login');
          } else {
            print('User is signed in!');
          }
        });
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

  Future<UserData> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    print('Auth Medthod + ' + currentUser.email!);
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    print(snap);
    return UserData.fromSnap(snap);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

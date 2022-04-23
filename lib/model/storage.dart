// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String uid) async {
    File file = File(filePath);
    print('1: ' + filePath);
    print('2: ' + file.path);

    try {
      await storage.ref('users/$uid/user_image.jpg').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  late String _email;
  late String _name;
  late String _uid;
  late String _image;
  bool _isAdmin = false;

  UserData(
      {required String email,
      required String name,
      required String uid,
      required String image,
      required bool isAdmin}) {
    _email = email;
    _name = name;
    _uid = uid;
    _image = image;
    _isAdmin = isAdmin;
  }

  String get email => _email;

  String get name => _name;

  String get uid => _uid;

  String get image => _image;

  bool get isAdmin => _isAdmin;

  setName(String name) {
    _name = name;
  }

  setEmail(String email) {
    _email = email;
  }

  setImage(String image) {
    _image = image;
  }

  Map<String, dynamic> toJson() => {
        'email': _email,
        'name': _name,
        'uid': _uid,
        'image': _image,
        'isAdmin': _isAdmin
      };

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        image: snapshot['image'],
        isAdmin: snapshot['isAdmin']);
  }
}

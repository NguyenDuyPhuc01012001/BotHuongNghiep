import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserApp {
  late final String? _email;
  late final String? _name;
  late final String? _uid;
  late final String? _image;
  bool? _isAdmin = false;

  UserApp(
      {String? email,
      String? name,
      String? uid,
      String? image,
      bool? isAdmin}) {
    _email = email;
    _name = name;
    _uid = uid;
    _image = image;
    _isAdmin = isAdmin;
  }

  String? get email => _email;
  String? get name => _name;
  String? get uid => _uid;
  String? get image => _image;
  bool? get isAdmin => _isAdmin;

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

  static UserApp fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserApp(
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        image: snapshot['image'],
        isAdmin: snapshot['isAdmin']);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class UserApp {
  late final String? _email;
  late final String? _name;
  late final String? _uid;

  UserApp({String? email, String? name, String? uid}) {
    _email = email;
    _name = name;
    _uid = uid;
  }
  String? get email => _email;
  String? get name => _name;
  String? get uid => _uid;
  Map<String, dynamic> toJson() =>
      {'email': _email, 'name': _name, 'uid': _uid};
  static UserApp fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserApp(
        email: snapshot['email'], name: snapshot['name'], uid: snapshot['uid']);
  }
}

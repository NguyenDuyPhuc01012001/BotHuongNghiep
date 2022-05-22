import 'package:cloud_firestore/cloud_firestore.dart';

class Titles {
  late String? id;
  late String? title;
  late String? content;
  late String? image;

  Titles({this.id, this.title, this.content, this.image});

  static List<Titles> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Titles(
        id: snapshot.id,
        title: dataMap['title'] ?? "",
        content: dataMap['content'] ?? "",
        image: dataMap['image'] ?? "",
      );
    }).toList();
  }

  static Titles fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Titles(
      id: snap.id,
      title: snapshot['title'] ?? "",
      content: snapshot['content'] ?? "",
      image: snapshot['image'] ?? "",
    );
  }
}

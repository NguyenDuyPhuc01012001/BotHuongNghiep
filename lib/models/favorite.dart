import 'package:cloud_firestore/cloud_firestore.dart';

import '../resources/support_function.dart';

class Favorite {
  late String? id;
  late String? favoriteID;
  late String? favoriteType;
  late String? title;
  late String? image;
  late String? time;

  Favorite(
      {this.id,
      this.favoriteID,
      this.favoriteType,
      this.title,
      this.image,
      this.time});

  static List<Favorite> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Favorite(
          id: snapshot.id,
          favoriteID: dataMap['favoriteID'],
          favoriteType: dataMap['favoriteType'],
          title: dataMap['title'],
          image: dataMap['image'],
          time: readTimestamp(dataMap['time']));
    }).toList();
  }

  static Favorite fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Favorite(
        id: snap.id,
        favoriteID: snapshot['favoriteID'],
        favoriteType: snapshot['favoriteType'],
        title: snapshot['title'],
        image: snapshot['image'],
        time: readTimestamp(snapshot['time']));
  }
}

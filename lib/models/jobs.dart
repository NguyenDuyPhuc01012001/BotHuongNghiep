import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huong_nghiep/models/titles.dart';

import '../resources/support_function.dart';

class Jobs {
  late String? id;
  late String? title;
  late String? image;
  late String? source;
  late String? sourceImage;
  late String? time;
  late String? description;
  late String? timeRead;
  late List<Titles>? listTitle;

  Jobs(
      {this.id,
      this.title,
      this.image,
      this.source,
      this.sourceImage,
      this.time,
      this.description,
      this.timeRead,
      this.listTitle});

  static List<Jobs> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Jobs(
          id: snapshot.id,
          title: dataMap['title'] ?? "",
          image: dataMap['image'] ?? "",
          source: dataMap['source'] ?? "",
          sourceImage: dataMap['sourceImage'] ?? "",
          time: readTimestamp(dataMap['time']),
          timeRead: dataMap['timeRead'] ?? "",
          description: dataMap['description'] ?? "");
    }).toList();
  }

  List<Jobs> listDataFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Jobs(
          id: snapshot.id,
          title: dataMap['title'] ?? "",
          image: dataMap['image'] ?? "",
          source: dataMap['source'] ?? "",
          sourceImage: dataMap['sourceImage'] ?? "",
          time: readTimestamp(dataMap['time']),
          timeRead: dataMap['timeRead'] ?? "",
          description: dataMap['description'] ?? "");
    }).toList();
  }

  static Jobs fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Jobs(
        id: snap.id,
        title: snapshot['title'] ?? "",
        image: snapshot['image'] ?? "",
        source: snapshot['source'] ?? "",
        sourceImage: snapshot['sourceImage'] ?? "",
        time: readTimestamp(snapshot['time']),
        timeRead: snapshot['timeRead'] ?? "",
        description: snapshot['description'] ?? "");
  }
}

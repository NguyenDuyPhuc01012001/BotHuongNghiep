import 'package:cloud_firestore/cloud_firestore.dart';

import '../resources/support_function.dart';

class Answer {
  late String? id;
  late String? source;
  late String? sourceImage;
  late String? answer;
  late String? time;
  late String? image;

  Answer(
      {this.id,
      this.source,
      this.sourceImage,
      this.answer,
      this.time,
      this.image});

  static List<Answer> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Answer(
        id: snapshot.id,
        source: dataMap['source'] ?? "",
        sourceImage: dataMap['sourceImage'] ?? "",
        answer: dataMap['answer'] ?? "",
        image: dataMap['image'] ?? "",
        time: readTimestamp(dataMap['time']),
      );
    }).toList();
  }

  static Answer fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Answer(
      id: snap.id,
      source: snapshot['source'] ?? "",
      sourceImage: snapshot['sourceImage'] ?? "",
      answer: snapshot['answer'] ?? "",
      image: snapshot['image'] ?? "",
      time: readTimestamp(snapshot['time']),
    );
  }
}

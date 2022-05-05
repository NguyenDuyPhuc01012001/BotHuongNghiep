import 'package:cloud_firestore/cloud_firestore.dart';

import '../../resources/support_function.dart';

class Jobs {
  late String? id;
  late String? title;
  late String? image;
  late String? source;
  late String? sourceImage;
  late String? time;
  late String? define;
  late String? income;
  late String? qualities;

  Jobs(
      {this.id,
      this.title,
      this.image,
      this.source,
      this.sourceImage,
      this.time,
      this.define,
      this.income,
      this.qualities});

  static List<Jobs> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Jobs(
        id: snapshot.id,
        title: dataMap['title'],
        image: dataMap['image'],
        source: dataMap['source'],
        sourceImage: dataMap['sourceImage'],
        time: readTimestamp(dataMap['time']),
        define: dataMap['define'],
        income: dataMap['income'],
        qualities: dataMap['qualities'],
      );
    }).toList();
  }

  static Jobs fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Jobs(
      id: snap.id,
      title: snapshot['title'],
      image: snapshot['image'],
      source: snapshot['source'],
      sourceImage: snapshot['sourceImage'],
      time: readTimestamp(snapshot['time']),
      define: snapshot['define'],
      income: snapshot['income'],
      qualities: snapshot['qualities'],
    );
  }
}

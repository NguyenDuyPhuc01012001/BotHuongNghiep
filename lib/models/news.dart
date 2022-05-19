import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huong_nghiep/models/title_news.dart';
import 'package:huong_nghiep/resources/support_function.dart';

class News {
  late String? id;
  late String? title;
  late String? image;
  late String? source;
  late String? sourceImage;
  late String? time;
  late String? description;
  late List<TitleNews>? listTitle;

  News(
      {this.id,
      this.title,
      this.image,
      this.source,
      this.sourceImage,
      this.time,
      this.description,
      this.listTitle});

  static List<News> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return News(
          id: snapshot.id,
          title: dataMap['title'] ?? "",
          image: dataMap['image'] ?? "",
          source: dataMap['source'] ?? "",
          sourceImage: dataMap['sourceImage'] ?? "",
          time: readTimestamp(dataMap['time']),
          description: dataMap['description'] ?? "");
    }).toList();
  }

  static News fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return News(
        id: snap.id,
        title: snapshot['title'] ?? "",
        image: snapshot['image'] ?? "",
        source: snapshot['source'] ?? "",
        sourceImage: snapshot['sourceImage'] ?? "",
        time: readTimestamp(snapshot['time']),
        description: snapshot['description'] ?? "");
  }
}

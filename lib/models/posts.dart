import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:huong_nghiep/models/answer.dart';

import '../resources/support_function.dart';

class Post {
  late String? id;
  late String? uid;
  late String? name;
  late String? userImage;
  late String? image;
  late String? question;
  late String? time;
  late int? numAnswer;
  late int? numFavorite;
  late List<Answer>? answerList;

  Post(
      {this.id,
      this.uid,
      this.name,
      this.userImage,
      this.image,
      this.question,
      this.time,
      this.numAnswer,
      this.numFavorite,
      this.answerList});

  static List<Post> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return Post(
        id: snapshot.id,
        uid: dataMap['uid'],
        image: dataMap['image'],
        name: dataMap['name'],
        userImage: dataMap['userImage'],
        time: readTimestamp(dataMap['time']),
        question: dataMap['question'],
        numAnswer: dataMap['numAnswer'],
        numFavorite: dataMap['numFavorite'],
      );
    }).toList();
  }

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      id: snap.id,
      uid: snapshot['uid'],
      image: snapshot['image'],
      name: snapshot['name'],
      userImage: snapshot['userImage'],
      time: readTimestamp(snapshot['time']),
      question: snapshot['question'],
      numAnswer: snapshot['numAnswer'],
      numFavorite: snapshot['numFavorite'],
    );
  }
}

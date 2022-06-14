import 'package:cloud_firestore/cloud_firestore.dart';

import '../resources/support_function.dart';

class MessageChat {
  late String? id;
  late String? message;
  late bool? isUserMessage;
  late String? timeStamp;

  MessageChat({this.id, this.message, this.isUserMessage, this.timeStamp});

  static List<MessageChat> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return MessageChat(
        id: snapshot.id,
        message: dataMap['message'] ?? "",
        isUserMessage: dataMap['isUserMessage'] ?? false,
        timeStamp: readTimestampForChat(dataMap['timeStamp']),
      );
    }).toList();
  }

  static MessageChat fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return MessageChat(
      id: snap.id,
      message: snapshot['message'] ?? "",
      isUserMessage: snapshot['isUserMessage'] ?? false,
      timeStamp: readTimestampForChat(snapshot['timeStamp']),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getTruncatedTitle(String actualString, int maxLetters) {
  return actualString.length > maxLetters
      ? actualString.substring(0, maxLetters) + "..."
      : actualString;
}

String readTimestamp(Timestamp timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date =
      DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' ngày trước';
    } else {
      time = diff.inDays.toString() + ' ngày trước';
    }
  }

  return time;
}

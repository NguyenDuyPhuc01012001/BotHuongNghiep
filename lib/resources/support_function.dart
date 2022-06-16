import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

String getTruncatedTitle(String actualString, int maxLetters) {
  return actualString.length > maxLetters
      ? actualString.substring(0, maxLetters) + "..."
      : actualString;
}

String readTimestamp(Timestamp timestamp) {
  DateTime myDateTime = DateTime.parse(timestamp.toDate().toString());
  String formattedTime = DateFormat('hh:mm a').format(myDateTime);
  String formattedDate = DateFormat('dd-MM-yyyy').format(myDateTime);
  String formattedDateTime = "$formattedTime ngày $formattedDate";

  return formattedDateTime;
}

String readTimestampForChat(Timestamp timestamp) {
  initializeDateFormatting();
  DateFormat dateFormat = DateFormat.MMMEd('vi');
  DateFormat weekDayFormat = DateFormat.E('vi');
  DateFormat timeFormat = DateFormat.Hm('vi');

  DateTime myDateTime = DateTime.parse(timestamp.toDate().toString());
  DateTime now = DateTime.now();

  int dayDiff = daysBetween(myDateTime, now);

  String formattedTime = timeFormat.format(myDateTime);
  String formattedDate = dayDiff > 6
      ? dateFormat.format(myDateTime)
      : weekDayFormat.format(myDateTime);
  String formattedDateTime = "$formattedDate lúc $formattedTime ";

  return dayDiff == 0 ? formattedTime : formattedDateTime;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

String getReadTime(List<String> content) {
  String listContent = "";
  for (String element in content) {
    listContent += element + " ";
  }
  int time = listContent.split(' ').length >= 200
      ? (listContent.split(' ').length / 200).floor()
      : (listContent.split(' ').length / 200 * 60).floor();
  String timeUnit = listContent.split(' ').length >= 200 ? "phút" : "giây";
  return "$time $timeUnit";
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Score {
  late String? title;
  late int? score;

  Score({this.title, this.score});

  static fromSnap(AsyncSnapshot<DocumentSnapshot> snap, String type) {
    var snapshot = snap.data!.data() as Map<String, dynamic>;
    Map<String, int> scMap = {};
    if (type == "MBTI") {
      scMap['E'] = snapshot['E'];
      scMap['I'] = snapshot['I'];
      scMap['S'] = snapshot['S'];
      scMap['N'] = snapshot['N'];
      scMap['T'] = snapshot['T'];
      scMap['F'] = snapshot['F'];
      scMap['J'] = snapshot['J'];
      scMap['P'] = snapshot['P'];
    } else {
      // type= "Holland"
      scMap['R'] = snapshot['R'];
      scMap['I'] = snapshot['I'];
      scMap['A'] = snapshot['A'];
      scMap['S'] = snapshot['S'];
      scMap['E'] = snapshot['E'];
      scMap['C'] = snapshot['C'];
    }
    return scMap;
  }
}

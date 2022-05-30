// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:huong_nghiep/models/tests/explanation.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';

import '../../../utils/colors.dart';

class ExplanationContainer extends StatelessWidget {
  final String type;
  final String resultKey;

  const ExplanationContainer({
    Key? key,
    required this.type,
    required this.resultKey,
  }) : super(key: key);

  List<Widget> getListExplanation(List<Explanation> explanations) {
    List<Widget> children = [];

    for (int i = 0; i < resultKey.length; i++)
      // ignore: curly_braces_in_flow_control_structures
      for (int j = 0; j < explanations.length; j++) {
        if (explanations[j].id == resultKey[i]) {
          children.add(getExplanationContainer(
              explanations[j].title, explanations[j].explanation));
        }
      }

    if (resultKey.length > 1)
      // ignore: curly_braces_in_flow_control_structures
      for (int j = 0; j < explanations.length; j++) {
        if (explanations[j].id == resultKey) {
          children.add(getExplanationContainer(
              explanations[j].title, explanations[j].explanation));
        }
      }

    return children;
  }

  Widget getExplanationContainer(String title, String explanation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 228, 181, 0.8),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        Text(
          explanation,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: kSecondaryColor),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Explanation>>(
        future: LoadExplanationFromJson.loadExplanationData(context, type),
        builder: (context, snapshot) {
          final _explanations = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Some error occurred!'));
              } else {
                print(_explanations);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getListExplanation(_explanations!),
                );
              }
          }
        });
  }
}

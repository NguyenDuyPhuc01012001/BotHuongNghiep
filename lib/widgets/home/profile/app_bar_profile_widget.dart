// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

AppBar AppBarProfileWidget(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    // set backbutton color here which will reflect in all screens.
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

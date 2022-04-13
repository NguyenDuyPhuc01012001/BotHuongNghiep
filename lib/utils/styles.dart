//TextStyles
import 'package:flutter/material.dart';
import 'package:huong_nghiep/utils/colors.dart';

//FontSize
const double h1 = 32;
const double h2 = 24;
const double h3 = 18.72;
const double h4 = 16;
const double h5 = 13.28;
const double h6 = 10.72;

const TextStyle kDefaultTextStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: h4);

const TextStyle ktsMediumTitleText =
    TextStyle(color: kcPrimaryColor, fontWeight: FontWeight.bold, fontSize: h2);

const TextStyle ktsMediumInputText =
    TextStyle(color: kcPrimaryTextColor, fontSize: h4);

const TextStyle ktsButton =
    TextStyle(fontWeight: FontWeight.bold, fontSize: h4);

const TextStyle ktsMediumLabelInputText = TextStyle(
    color: kcPrimaryTextColor, fontWeight: FontWeight.bold, fontSize: h4);

const TextStyle kBottomNavigationItemStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
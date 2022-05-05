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

TextStyle kItemText = TextStyle(
    fontSize: h5, fontWeight: FontWeight.w600, color: Colors.grey[700]);

const kTitle =
    TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500);

const kDescription =
    TextStyle(color: Colors.black, fontSize: h3, fontWeight: FontWeight.normal);
const ktsHeaderAccordion = TextStyle(
    color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
const contentStyleHeader = TextStyle(
    color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
const ktsContentAccordion = TextStyle(
    color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

const kDescriptionBoldItalic = TextStyle(
    color: Colors.black,
    fontSize: h3,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic);

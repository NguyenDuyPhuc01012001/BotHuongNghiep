// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NewsSearchBar extends StatelessWidget {
  const NewsSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTEC = TextEditingController();
    return TextField(
        controller: searchTEC,
        style: TextStyle(fontSize: 18),
        cursorColor: Colors.black,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
            hintText: "Tìm kiếm tin tức",
            filled: true,
            fillColor: Colors.grey[200]));
  }
}

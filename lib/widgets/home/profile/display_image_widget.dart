// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DisplayImageWidget extends StatelessWidget {
  const DisplayImageWidget(
      {Key? key, required this.imagePath, required this.onPressed})
      : super(key: key);

  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(64, 105, 225, 1);

    return Center(
        child: Stack(children: [
      buildImage(color),
      Positioned(
        child: buildEditIcon(color),
        right: 4,
        top: 10,
      )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imagePath.isEmpty
        ? AssetImage("assets/images/default_avatar.jpg")
        : imagePath.contains('https://')
            ? NetworkImage(imagePath)
            : AssetImage(imagePath);

    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}

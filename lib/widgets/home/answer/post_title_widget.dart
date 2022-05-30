// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../models/posts.dart';
import '../../../utils/styles.dart';
import '../../custom/custom_shape.dart';

class PostTitleWidget extends StatelessWidget {
  const PostTitleWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 10, top: 15, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: Image.network(
                  post.userImage!,
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 8),
              Text(post.email!, style: kItemText),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: CustomPaint(
                  painter: CustomShape(Color(0xffFFEFEF)),
                ),
              ),
              Container(
                width: size.width * 0.9,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xffFFEFEF),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(post.question!,
                          style: kContentText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18)),
                    ),
                    SizedBox(height: 4),
                    post.image! == ""
                        ? SizedBox()
                        : ClipRRect(
                            child: CachedNetworkImage(
                                imageUrl: post.image!,
                                width: size.width,
                                height: 200,
                                fit: BoxFit.fitWidth,
                                placeholder: (context, _) => SpinKitChasingDots(
                                    color: Colors.brown, size: 32),
                                errorWidget: (context, _, error) =>
                                    Icon(Icons.error)),
                            borderRadius: BorderRadius.circular(10),
                          )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: Text(
              "Đã đăng vào lúc ${post.time!}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}

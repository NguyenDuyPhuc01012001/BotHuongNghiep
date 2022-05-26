// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/answer.dart';

import '../../../resources/firebase_handle.dart';
import '../../../utils/styles.dart';
import '../../alert.dart';
import '../../custom/custom_shape.dart';

class AnswerTitleWidget extends StatefulWidget {
  const AnswerTitleWidget({
    Key? key,
    required this.answer,
    required this.postID,
    required this.isAdmin,
  }) : super(key: key);

  final Answer answer;
  final String postID;
  final bool isAdmin;

  @override
  State<AnswerTitleWidget> createState() => _AnswerTitleWidgetState();
}

class _AnswerTitleWidgetState extends State<AnswerTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipOval(
                child: Image.network(
                  widget.answer.sourceImage!,
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 8),
              Text(widget.answer.source!, style: kItemText),
            ],
          ),
          Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              setState(() {
                Alerts().confirm(
                    "Bạn có muốn xoá câu trả lời này không?", 'Đồng ý', 'Hủy',
                    () async {
                  await FirebaseHandler.deleteAnswerPost(
                          widget.postID, widget.answer.id!)
                      .whenComplete(() => {Get.back()});
                }, () => Get.back(), context);
              });
            },
            confirmDismiss: (direction) async => widget.isAdmin,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Color(0xffFEF8E8),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 320),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.answer.answer!,
                              style: kContentText.copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                          widget.answer.image! == ""
                              ? SizedBox()
                              : ClipRRect(
                                  child: CachedNetworkImage(
                                      imageUrl: widget.answer.image!,
                                      width: widget.answer.answer!.length > 50
                                          ? 320
                                          : 150,
                                      height: 150,
                                      fit: BoxFit.fitWidth,
                                      placeholder: (context, _) =>
                                          SpinKitChasingDots(
                                              color: Colors.brown, size: 32),
                                      errorWidget: (context, _, error) =>
                                          Icon(Icons.error)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomPaint(painter: CustomShape(Color(0xffFEF8E8))),
              ],
            ),
            background: Card(
              elevation: 20,
              color: widget.isAdmin ? Colors.red : Colors.green,
              child: Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: widget.isAdmin
                      ? Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      : Text(
                          "Không có gì xảy ra đâu.",
                          style: kContentText.copyWith(
                              color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8),
            child: Text(
              "Đã trả lời vào lúc ${widget.answer.time!}",
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/posts.dart';
import '../../../screens/home/detailpage/answer_page_screen.dart';
import '../../../utils/styles.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const SizedBox(width: 8),
                      Text(post.email!, style: kItemText),
                    ],
                  ),
                  Text(
                    post.time!,
                    style: kItemText,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(post.question!,
                    style:
                        kContentText.copyWith(fontWeight: FontWeight.normal)),
              ),
              const SizedBox(height: 4),
              post.image! == ""
                  ? const SizedBox()
                  : ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl: post.image!,
                        width: size.width,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      hoverColor: Colors.grey,
                      onPressed: () {
                        Get.to(AnswerPageScreen(postID: post.id!));
                      },
                      icon: const Icon(Icons.question_answer_outlined)),
                  Text("Đã có ${post.numAnswer} trả lời")
                ],
              )
            ],
          ),
        ));
  }
}

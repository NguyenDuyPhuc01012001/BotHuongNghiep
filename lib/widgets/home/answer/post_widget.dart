// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/utils/constants.dart';

import '../../../models/posts.dart';
import '../../../models/user.dart';
import '../../../resources/firebase_handle.dart';
import '../../../resources/firebase_reference.dart';
import '../../../screens/home/detailpage/answer_page_screen.dart';
import '../../../screens/other/error_screen.dart';
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Get.to(AnswerPageScreen(postID: post.id!));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(
                        post.userImage!,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    horizontalSpaceSmall,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: userFR.doc(post.uid).get(),
                            builder: ((context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print('Something went Wrong');
                                return ErrorScreen();
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: SpinKitChasingDots(
                                      color: Colors.brown, size: 32),
                                );
                              }
                              UserData userData =
                                  UserData.fromSnap(snapshot.data!);
                              return userData.isAdmin
                                  ? Row(
                                      children: [
                                        Text(post.name!,
                                            style: kItemText.copyWith(
                                                color: Colors.green)),
                                        Icon(Icons.star, color: Colors.yellow),
                                        Text("Admin",
                                            style: kItemText.copyWith(
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    )
                                  : Text(post.name!,
                                      style: kItemText.copyWith(
                                          color: Colors.green));
                            })),
                        // Text(post.name!,
                        //     style: kItemText.copyWith(color: Colors.green)),
                        Text(
                          post.time!,
                          style: kItemText.copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text.rich(TextSpan(
                        text: "Câu hỏi: ",
                        children: <TextSpan>[
                          TextSpan(
                              text: post.question!,
                              style: kContentText.copyWith(
                                  fontStyle: FontStyle.normal))
                        ],
                        style: kContentText.copyWith(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic)))),
                const SizedBox(height: 4),
                post.image! == ""
                    ? const SizedBox()
                    : ClipRRect(
                        child: CachedNetworkImage(
                            imageUrl: post.image!,
                            width: size.width,
                            height: 200,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => SpinKitChasingDots(
                                color: Colors.brown, size: 32),
                            errorWidget: (context, _, error) =>
                                Icon(Icons.error)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder(
                          stream: userFR
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("favoritePost")
                              .where("favoriteID", isEqualTo: post.id)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Text("");
                            }
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: IconButton(
                                onPressed: () => snapshot.data.docs.length == 0
                                    ? addToFavorite(post.id!)
                                    : deleteFavorite(post.id!),
                                icon: snapshot.data.docs.length == 0
                                    ? Icon(
                                        Icons.favorite_outline,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                              ),
                            );
                          },
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: postsFR.doc(post.id).snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.data == null) {
                              return Text("");
                            }
                            Post post = Post.fromSnap(snapshot.data!);
                            return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  "${post.numFavorite} yêu thích",
                                  style: kContentText,
                                ));
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.question_answer_outlined),
                        horizontalSpaceSmall,
                        Text.rich(TextSpan(
                          text: "Đã có ",
                          children: <TextSpan>[
                            TextSpan(
                                text: "${post.numAnswer}",
                                style: kDefaultTextStyle),
                            TextSpan(text: " phản hồi")
                          ],
                          style: kDefaultTextStyle.copyWith(
                              fontWeight: FontWeight.normal),
                        ))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

Future addToFavorite(String id) async {
  await FirebaseHandler.addToFavoritePost(id);
}

Future deleteFavorite(String id) async {
  await FirebaseHandler.deleteFromFavoritePost(id);
}

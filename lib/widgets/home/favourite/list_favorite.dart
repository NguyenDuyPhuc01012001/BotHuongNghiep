// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/favorite.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/screens/home/detailpage/jobs_page_screen.dart';

import '../../../resources/support_function.dart';
import '../../../screens/home/detailpage/news_page_screen.dart';
import '../../../utils/styles.dart';

class ListFavouriteWidget extends StatefulWidget {
  const ListFavouriteWidget({Key? key}) : super(key: key);

  @override
  State<ListFavouriteWidget> createState() => _ListFavouriteWidgetState();
}

class _ListFavouriteWidgetState extends State<ListFavouriteWidget> {
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    final favoriteStream = FirebaseHandler.getListFavorite();

    return StreamBuilder<QuerySnapshot>(
        stream: favoriteStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          List<Favorite> favoriteDocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Favorite favorite = Favorite.fromSnap(document);
            favoriteDocs.add(favorite);
          }).toList();

          return Column(children: [
            for (var i = 0; i < favoriteDocs.length; i++) ...[
              GestureDetector(
                  onTap: () {
                    if (favoriteDocs[i].favoriteType! == "news") {
                      Get.to(NewsPageScreen(
                          newsPostID: favoriteDocs[i].favoriteID!));
                    } else if (favoriteDocs[i].favoriteType! == "jobs") {
                      Get.to(JobsPageScreen(
                          jobsPostID: favoriteDocs[i].favoriteID!));
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: favoriteDocs[i].image!,
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                    getTruncatedTitle(
                                        favoriteDocs[i].title!, 60),
                                    style: kItemText.copyWith(
                                        fontWeight: FontWeight.normal)),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Đã yêu thích vào " +
                                          favoriteDocs[i].time!,
                                      style: kItemText,
                                    ),
                                    Icon(Icons.bookmark)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )))
            ]
          ]);
        });
  }
}

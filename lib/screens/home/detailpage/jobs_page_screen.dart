// ignore_for_file: prefer_const_constructors, avoid_print, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/utils/styles.dart';

import '../../../models/jobs.dart';
import '../../../resources/firebase_handle.dart';
import '../../../resources/firebase_reference.dart';
import '../../../utils/constants.dart';

class JobsPageScreen extends StatefulWidget {
  final String jobsPostID;
  const JobsPageScreen({Key? key, required this.jobsPostID}) : super(key: key);

  @override
  State<JobsPageScreen> createState() => _JobsPageScreenState();
}

class _JobsPageScreenState extends State<JobsPageScreen> {
  Future addToFavorite(String id, String title, String image) async {
    await FirebaseHandler.addToFavorite(id, "jobs", title, image);
  }

  Future deleteFavorite(String id) async {
    await FirebaseHandler.deleteFromFavorite(id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<Jobs>(
          future: FirebaseHandler.getJobsByID(widget.jobsPostID),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              print('Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Jobs jobsPost = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black54])
                              .createShader(Rect.fromLTRB(
                                  0, -140, rect.width, rect.height * 0.8));
                        },
                        blendMode: BlendMode.darken,
                        child: ClipRRect(
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(jobsPost.image!),
                                height: size.height * 0.4,
                                width: size.width)),
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: const [
                              Color(0xCC000000),
                              Color(0x00000000),
                              Color(0x00000000),
                              Color(0xCC000000),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 30, left: 10),
                            child: Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            jobsPost.title!,
                            style: kTitle,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(jobsPost.sourceImage!))),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobsPost.source!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      jobsPost.time!,
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  StreamBuilder(
                                    stream: userFR
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .collection("favorite")
                                        .where("favoriteID",
                                            isEqualTo: jobsPost.id)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.data == null) {
                                        return Text("");
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: IconButton(
                                            onPressed: () => snapshot
                                                        .data.docs.length ==
                                                    0
                                                ? addToFavorite(
                                                    jobsPost.id!,
                                                    jobsPost.title!,
                                                    jobsPost.image!)
                                                : deleteFavorite(jobsPost.id!),
                                            icon: snapshot.data.docs.length == 0
                                                ? Icon(
                                                    Icons.favorite_outline,
                                                    color: Colors.white,
                                                  )
                                                : Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share,
                                        color: Colors.blue, size: 30),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 2,
                          decoration: BoxDecoration(color: Colors.grey[400]),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: jobsPost.listTitle!.length,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                "Mục thứ ${index + 1}. ${jobsPost.listTitle![index].title}",
                                                style: kDescription.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: Text(
                                            jobsPost.listTitle![index].content!,
                                            style: kDescription,
                                            textAlign: TextAlign.justify),
                                      ),
                                      jobsPost.listTitle![index].image! != ""
                                          ? CachedNetworkImage(
                                              imageUrl: jobsPost
                                                  .listTitle![index].image!,
                                              fit: BoxFit.contain,
                                              height: 250)
                                          : SizedBox(),
                                    ],
                                  );
                                }),
                              ),
                              verticalSpaceMedium
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

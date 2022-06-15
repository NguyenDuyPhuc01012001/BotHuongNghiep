// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../models/jobs.dart';
import '../../../resources/firebase_reference.dart';
import '../../../screens/home/detailpage/jobs_page_screen.dart';
import '../../../screens/other/error_screen.dart';

class JobsCarousel extends StatefulWidget {
  const JobsCarousel({Key? key}) : super(key: key);

  @override
  State<JobsCarousel> createState() => _JobsCarouselState();
}

class _JobsCarouselState extends State<JobsCarousel> {
  final _random = Random();
  bool _isFirst = true;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> jobsStream =
        jobsFR.orderBy('time', descending: true).snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: jobsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }
          List<Jobs> jobsdocs = [];
          int count = 1;
          snapshot.data!.docs.map((DocumentSnapshot document) {
            if (_isFirst && count < 4) {
              _isFirst = false;
              Jobs jobs = Jobs.fromSnap(document);
              jobsdocs.add(jobs);
              count++;
            } else {
              var number = _random.nextInt(50);
              if (number % 2 == 0) {
                Jobs jobs = Jobs.fromSnap(document);
                jobsdocs.add(jobs);
              }
            }
          }).toList();

          return CarouselSlider(
            options: CarouselOptions(
              // height: 200.0,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 1.44,
              initialPage: 1,
            ),
            items: jobsdocs.map((jobs) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(JobsPageScreen(jobsPostID: jobs.id!));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CachedNetworkImage(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    imageUrl: jobs.image!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, _) =>
                                        SpinKitChasingDots(
                                            color: Colors.brown, size: 32),
                                    errorWidget: (context, _, error) =>
                                        Icon(Icons.error),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              child: Text(
                                jobs.title!,
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        });
  }
}

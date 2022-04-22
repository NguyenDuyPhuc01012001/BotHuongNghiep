// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/jobs/jobs_page_screen.dart';

import '../../../utils/values.dart';

class JobCarousel extends StatelessWidget {
  JobCarousel({Key? key}) : super(key: key);
  final StaticValues staticValues = StaticValues();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0,
      ),
      items: staticValues.jobs.map((jobs) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Get.to(JobPageScreen(jobsPost: jobs));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(jobs.image),
                        height: 250,
                        // width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                          // image: DecorationImage(
                          //     colorFilter: new ColorFilter.mode(
                          //         Colors.black, BlendMode.dstATop),
                          //     image: NetworkImage(news.image),
                          //     fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            jobs.title,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

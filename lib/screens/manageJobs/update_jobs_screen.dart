// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_reference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../model/jobs/jobs.dart';
import '../../resources/firebase_handle.dart';
import '../../utils/styles.dart';

class UpdateJobsScreen extends StatefulWidget {
  final String jobsPostID;
  const UpdateJobsScreen({Key? key, required this.jobsPostID})
      : super(key: key);

  @override
  State<UpdateJobsScreen> createState() => _UpdateJobsScreenState();
}

class _UpdateJobsScreenState extends State<UpdateJobsScreen> {
  final _formKey = GlobalKey<FormState>();
  var filePath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cập nhật bài đăng"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: jobsFR.doc(widget.jobsPostID).get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Jobs jobsPost = Jobs.fromSnap(snapshot.data!);
              var title = jobsPost.title;
              var define = jobsPost.define;
              var qualities = jobsPost.qualities;
              var income = jobsPost.income;
              var source = jobsPost.source;
              var time = jobsPost.time;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Text("Tiêu đề", style: ktsMediumTitleText)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: title,
                        onChanged: (value) => title = value,
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: 'Nhập tiêu đề',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập tiêu đề';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Text(
                            "Người đăng/sửa bài: $source \nThời gian: $time",
                            style: ktsMediumLabelInputText)),
                    SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child:
                            Text("Hình ảnh", style: ktsMediumLabelInputText)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4),
                      child: GestureDetector(
                          onTap: () async {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);

                            if (image == null) return;

                            final location =
                                await getApplicationDocumentsDirectory();
                            final name = basename(image.path);
                            final imageFile = File('${location.path}/$name');
                            final newImage =
                                await File(image.path).copy(imageFile.path);
                            setState(() {
                              filePath = newImage.path;
                              print('File Path: ' + filePath);
                            });
                          },
                          child: filePath == ''
                              ? CachedNetworkImage(
                                  width: 250,
                                  height: 250,
                                  fit: BoxFit.fill,
                                  imageUrl: jobsPost.image!,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.black)),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.file(
                                      File(filePath),
                                      fit: BoxFit.fill,
                                      width: 250,
                                      height: 250,
                                    ),
                                  ))),
                    ),
                    SizedBox(height: 10),
                    Divider(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Text("Chi tiết bài đăng",
                            style: ktsMediumLabelInputText)),
                    Divider(height: 6),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child: Text("1. Khái niệm",
                            style: kDescriptionBoldItalic)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: define,
                        onChanged: (value) => define = value,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: 'Nhập khái niệm',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Khái niệm không được bỏ trống';
                          }
                          return null;
                        },
                      ),
                    ),
                    Divider(height: 6),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child:
                            Text("2. Tố chất", style: kDescriptionBoldItalic)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: qualities,
                        onChanged: (value) => qualities = value,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: 'Nhập tố chất',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tố chất không được bỏ trống';
                          }
                          return null;
                        },
                      ),
                    ),
                    Divider(height: 6),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4),
                        child:
                            Text("3. Thu nhập", style: kDescriptionBoldItalic)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        autofocus: false,
                        initialValue: income,
                        onChanged: (value) => income = value,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            hintText: 'Nhập thu nhập',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Thu nhập không được bỏ trống';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              await FirebaseHandler.updateJobs(
                                  widget.jobsPostID,
                                  title!,
                                  define!,
                                  qualities!,
                                  income!,
                                  filePath);
                              Get.back();
                            }
                          },
                          child: Text(
                            'Cập nhật',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              title = jobsPost.title;
                              income = jobsPost.income;
                              qualities = jobsPost.qualities;
                              define = jobsPost.define;
                              filePath = "";
                            });
                          },
                          child: Text(
                            'Clear',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}

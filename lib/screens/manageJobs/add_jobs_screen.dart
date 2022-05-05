// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../resources/firebase_handle.dart';
import '../../utils/styles.dart';
import '../../widgets/authentication/custom_error_box.dart';

class AddJobsScreen extends StatefulWidget {
  const AddJobsScreen({Key? key}) : super(key: key);

  @override
  State<AddJobsScreen> createState() => _AddJobsScreenState();
}

class _AddJobsScreenState extends State<AddJobsScreen> {
  final _formKey = GlobalKey<FormState>();

  var title = "";
  var define = "";
  var qualities = "";
  var income = "";
  var filePath = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final titleController = TextEditingController();
  final defineController = TextEditingController();
  final qualitiesController = TextEditingController();
  final incomeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    defineController.dispose();
    qualitiesController.dispose();
    incomeController.dispose();
    super.dispose();
  }

  clearText() {
    titleController.clear();
    defineController.clear();
    qualitiesController.clear();
    incomeController.clear();
    setState(() {
      filePath = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm bài đăng'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: ListView(
            children: [
              Divider(height: 10),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Text("Tiêu đề", style: ktsMediumTitleText)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  autofocus: false,
                  controller: titleController,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Nhập tiêu đề',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tiêu đề';
                    }
                    return null;
                  },
                ),
              ),
              Divider(height: 10),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Text("Hình ảnh", style: ktsMediumLabelInputText)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
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
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(Icons.add, size: 40),
                            width: 250,
                            height: 250,
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
              filePath == ""
                  ? CustomErrorBox(
                      message: "Vui lòng chọn hình ảnh cho bài đăng")
                  : SizedBox(),
              Divider(height: 10),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Text("Chi tiết bài đăng",
                      style: ktsMediumLabelInputText)),
              Divider(height: 6),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Text("1. Khái niệm", style: kDescriptionBoldItalic)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: defineController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Nhập khái niệm',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Text("2. Tố chất", style: kDescriptionBoldItalic)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: qualitiesController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Nhập tố chất',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child: Text("3. Thu nhập", style: kDescriptionBoldItalic)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: incomeController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Nhập thu nhập',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Thu nhập không được bỏ trống';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            title = titleController.text;
                            define = defineController.text;
                            qualities = qualitiesController.text;
                            income = incomeController.text;
                            if (filePath != "") {
                              FirebaseHandler.addJobs(
                                  title, define, qualities, income, filePath);
                              Get.back();
                            }
                            // addJobs();
                          });
                        }
                      },
                      child: Text(
                        'Thêm',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'Clear',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

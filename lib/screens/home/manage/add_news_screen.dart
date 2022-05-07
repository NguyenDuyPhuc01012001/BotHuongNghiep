// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../utils/styles.dart';
import '../../../widgets/authentication/custom_error_box.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final _formKey = GlobalKey<FormState>();

  var title = "";
  var description = "";
  var filePath = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  clearText() {
    titleController.clear();
    descriptionController.clear();
    setState(() {
      filePath = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm tin tức'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: ListView(
            children: [
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                      message: "Vui lòng chọn hình ảnh cho tin tức")
                  : SizedBox(),
              SizedBox(height: 10),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  child:
                      Text("Chi tiết tin tức", style: ktsMediumLabelInputText)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Nhập chi tiết tin tức',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Chi tiết tin tức không được bỏ trống';
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
                            description = descriptionController.text;
                            if (filePath != "") {
                              FirebaseHandler.addNews(
                                  title, description, filePath);
                              Get.back();
                            }
                            // addNews();
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

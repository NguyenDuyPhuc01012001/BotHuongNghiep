// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ResquestWidget extends StatefulWidget {
  const ResquestWidget({Key? key}) : super(key: key);

  @override
  State<ResquestWidget> createState() => _ResquestWidgetState();
}

class _ResquestWidgetState extends State<ResquestWidget> {
  final _formKey = GlobalKey<FormState>();
  final postController = TextEditingController();
  var post = "";
  var filePath = "";
  bool isImage = false;
  bool isLoading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    postController.dispose();
    super.dispose();
  }

  clearText() {
    postController.clear();
    setState(() {
      isImage = false;
      filePath = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        isLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              )
            : Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                              autofocus: false,
                              controller: postController,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: 'Câu hỏi của bạn là ....',
                                  hintStyle: TextStyle(color: Colors.grey))),
                        ),
                        isImage
                            ? Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Divider(
                                    height: 10.0,
                                    thickness: 1,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.file(
                                          File(filePath),
                                          fit: BoxFit.fill,
                                          width: 400,
                                          height: 250,
                                        ),
                                      ))
                                ],
                              )
                            : SizedBox(),
                        const Divider(
                          height: 10.0,
                          thickness: 1,
                        ),
                        Container(
                          height: 40.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  final image = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);

                                  if (image == null) return;

                                  final location =
                                      await getApplicationDocumentsDirectory();
                                  final name = basename(image.path);
                                  final imageFile =
                                      File('${location.path}/$name');
                                  final newImage = await File(image.path)
                                      .copy(imageFile.path);
                                  setState(() {
                                    filePath = newImage.path;
                                    isImage = true;
                                    print('File Path: ' + filePath);
                                  });
                                },
                                icon: const Icon(
                                  Icons.photo_library,
                                  color: Colors.green,
                                ),
                                label: const Text('Hình ảnh'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    clearText();
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                label: const Text('Huỷ'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                    post = postController.text;
                                    if (post != "") {
                                      FirebaseHandler.addPost(post, filePath)
                                          .whenComplete(() {
                                        clearText();
                                        isLoading = false;
                                      });
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                                label: const Text('Gửi'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }
}

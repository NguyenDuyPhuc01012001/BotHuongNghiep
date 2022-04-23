// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:huong_nghiep/model/storage.dart';
import 'package:huong_nghiep/model/user.dart';
import 'package:huong_nghiep/providers/home/home_provider.dart';
import 'package:huong_nghiep/widgets/home/profile/app_bar_profile_widget.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class EditImageWidget extends StatefulWidget {
  const EditImageWidget({Key? key}) : super(key: key);

  @override
  State<EditImageWidget> createState() => _EditImageWidgetState();
}

class _EditImageWidgetState extends State<EditImageWidget> {
  final storage = Storage();

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    var filePath = '';
    return Scaffold(
      appBar: AppBarProfileWidget(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: 330,
              child: const Text(
                "Cập nhật hình ảnh bản thân:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
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
                      homeProvider.setImage(newImage.path);
                      filePath = newImage.path;
                      print(filePath);
                    },
                    child: homeProvider.user.image == ''
                        ? Image.network(
                            'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          )
                        : Image.file(
                            File(homeProvider.user.image),
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: homeProvider.updateImageToStorage,
                      child: homeProvider.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                    ),
                  )))
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  var filePath = '';

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
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
                            imageUrl: homeProvider.user.image,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                    color: Colors.black)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Image.file(
                            File(filePath),
                            fit: BoxFit.fill,
                            width: 250,
                            height: 250,
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
                      onPressed: () =>
                          homeProvider.updateImageToStorage(filePath),
                      child: homeProvider.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Cập nhật',
                              style: TextStyle(fontSize: 15),
                            ),
                    ),
                  )))
        ],
      ),
    );
  }
}

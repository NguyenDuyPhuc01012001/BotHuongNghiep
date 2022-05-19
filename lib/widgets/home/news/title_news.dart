// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:huong_nghiep/utils/constants.dart';

import '../../../utils/styles.dart';

class TitleNewsWidget extends StatefulWidget {
  TextEditingController titleController = TextEditingController();
  String? id;
  String filePath = "";

  TitleNewsWidget({Key? key, this.id}) : super(key: key);

  @override
  State<TitleNewsWidget> createState() => _TitleNewsWidgetState();
}

class _TitleNewsWidgetState extends State<TitleNewsWidget> {
  addImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final location = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final imageFile = File('${location.path}/$name');
    final newImage = await File(image.path).copy(imageFile.path);
    setState(() {
      widget.filePath = newImage.path;
    });
  }

  clearImage() {
    setState(() {
      widget.filePath = "";
    });
  }

  @override
  void dispose() {
    // widget.titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 20,
      shadowColor: Colors.black87,
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ListBody(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  controller: widget.titleController,
                  decoration: const InputDecoration(
                      labelText: 'Tiêu đề chính',
                      labelStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: h4),
                      hintText: 'Tiêu đề chính (Bắt buộc)',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tiêu đề';
                    }
                    return null;
                  },
                ),
              ),
              verticalSpaceSmall,
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hình ảnh (bắt buộc)",
                          style: kDefaultTextStyle.copyWith(color: Colors.red)),
                      Row(
                        children: [
                          IconButton(
                              onPressed: addImage,
                              icon: Icon(MdiIcons.cameraPlus),
                              iconSize: 32),
                          if (widget.filePath != "")
                            IconButton(
                                onPressed: clearImage,
                                icon: Icon(MdiIcons.imageRemove),
                                iconSize: 32),
                        ],
                      ),
                    ]),
              ),
              if (widget.filePath != "")
                if (widget.filePath.contains("http"))
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: CachedNetworkImage(
                      alignment: Alignment.center,
                      height: 250,
                      fit: BoxFit.fill,
                      imageUrl: widget.filePath,
                      placeholder: (context, url) => Center(
                          child:
                              CircularProgressIndicator(color: Colors.black)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Container(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            File(widget.filePath),
                            fit: BoxFit.fill,
                            height: 250,
                          ),
                        )),
                  )
              else
                SizedBox()
            ],
          )
        ]),
      ),
    );
  }
}

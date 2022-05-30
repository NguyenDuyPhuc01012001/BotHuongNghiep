// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/answer.dart';
import '../../../resources/firebase_handle.dart';

class AddAnswerWidget extends StatefulWidget {
  final String postID;

  const AddAnswerWidget({Key? key, required this.postID}) : super(key: key);

  @override
  State<AddAnswerWidget> createState() => _AddAnswerWidgetState();
}

class _AddAnswerWidgetState extends State<AddAnswerWidget> {
  final TextEditingController answerController = TextEditingController();
  String filePath = "";

  addImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final location = await getApplicationDocumentsDirectory();
    final name = basename(image.path);
    final imageFile = File('${location.path}/$name');
    final newImage = await File(image.path).copy(imageFile.path);
    setState(() {
      filePath = newImage.path;
    });
  }

  clearImage() {
    setState(() {
      filePath = "";
    });
  }

  clearText() {
    setState(() {
      filePath = "";
      answerController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          children: [
            if (filePath != "")
              if (filePath.contains("http"))
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                          height: 100,
                          width: 180,
                          fit: BoxFit.fill,
                          imageUrl: filePath,
                          placeholder: (context, _) =>
                              SpinKitChasingDots(color: Colors.brown, size: 32),
                          errorWidget: (context, _, error) =>
                              Icon(Icons.error)),
                    ),
                  ),
                )
              else
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                  child: Container(
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          File(filePath),
                          fit: BoxFit.fill,
                          height: 100,
                          width: 180,
                        ),
                      )),
                )
            else
              SizedBox(),
            verticalSpaceTiny,
            Row(
              children: [
                if (filePath == "")
                  IconButton(
                      onPressed: addImage,
                      icon: Icon(MdiIcons.cameraPlus),
                      iconSize: 32)
                else
                  IconButton(
                      onPressed: clearImage,
                      icon: Icon(MdiIcons.imageRemove),
                      iconSize: 32),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: answerController,
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Roboto'),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: 'Gửi câu trả lời',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.send),
                  iconSize: 32,
                  onPressed: () async {
                    String answerMessage = answerController.text;
                    if (answerMessage.isNotEmpty) {
                      Answer answer =
                          Answer(answer: answerMessage, image: filePath);
                      await FirebaseHandler.addAnswerPost(answer, widget.postID)
                          .then(clearText());
                      print(answerMessage);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

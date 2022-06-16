// ignore_for_file: prefer_const_constructors, avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/models/message.dart';
import 'package:huong_nghiep/resources/firebase_handle.dart';
import 'package:huong_nghiep/screens/other/error_screen.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../utils/styles.dart';
import '../../widgets/alert.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  String text = "";
  late DialogFlowtter dialogFlowtter;
  final TextEditingController messageController = TextEditingController();

  String helloText = "Xin chào";

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile(path: "assets/dialog_flow_auth.json")
        .then((instance) => dialogFlowtter = instance)
        .then((value) => greetingMessage());
  }

  @override
  Widget build(BuildContext context) {
    // print(text);
    if (!text.contains("")) {
      messageController.text = text;
    }
    var themeValue = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      backgroundColor:
          themeValue == Brightness.dark ? Color(0xff262626) : Color(0xffFFFFFF),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffBFBFBF),
                borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(top: 10, left: 10, bottom: 5),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text("Trò chuyện với Chatbot".capitalize!,
              style: kDefaultTextStyle.copyWith(
                  fontSize: 24, color: Color.fromARGB(255, 142, 142, 142)),
              textAlign: TextAlign.center),
        ),
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: deleteMessage,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  color: Color(0xffBFBFBF),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 10, bottom: 5),
              child: Icon(MdiIcons.delete),
            ),
          ),
          horizontalSpaceSmall
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Body(
              sendMessage: sendMessage,
            )),
            listSuggestion(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          border: Border.all(
                            color: themeValue == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            width: 1,
                          )),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        //Normal textInputField will be displayed
                        maxLines: 4,
                        controller: messageController,
                        style: TextStyle(
                            color: themeValue == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            fontFamily: 'Roboto'),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: themeValue == Brightness.dark
                                ? Colors.white54
                                : Colors.black54,
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                          hintText: 'Aa',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    color: themeValue == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    icon: Icon(Icons.send),
                    onPressed: () {
                      sendMessage(messageController.text);
                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> greetingMessage() async {
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput:
          QueryInput(text: TextInput(text: helloText, languageCode: "vi")),
    );

    if (response.message == null) return;
    for (Message message in response.queryResult!.fulfillmentMessages!) {
      addMessage(message);
    }
  }

  void sendMessage(String text) async {
    if (text.isEmpty) return;
    addMessage(
      Message(text: DialogText(text: [text])),
      true,
    );

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text, languageCode: "vi")),
    );

    if (response.message == null) return;
    addMessage(response.message!);
    await Future.delayed(Duration(seconds: 1));
    for (Message message in response.queryResult!.fulfillmentMessages!) {
      if (message != response.message) addMessage(message);
    }

    // for (Message message in response.queryResult!.fulfillmentMessages!) {
    //    addMessage(message);
    // }
  }

  void addMessage(Message message, [bool isUserMessage = false]) {
    FirebaseHandler.addMessage(message.text!.text![0], isUserMessage);
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  List<String> listSuggestionString = [
    "Hiểu về bản thân",
    "Hiểu về trường",
    "Hiểu về nghề",
    "Hiểu về ngành"
  ];
  Widget listSuggestion() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listSuggestionString.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () => {sendMessage(listSuggestionString[index])},
                child: Chip(
                  elevation: 20,
                  padding: EdgeInsets.all(8),
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.black,
                  avatar: CircleAvatar(
                    child: Text("${index + 1}"), //NetwordImage
                  ),
                  label: Text(
                    listSuggestionString[index],
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            );
          })),
    );
  }

  deleteMessage() async {
    setState(() {
      Alerts().confirm(
          "Bạn có muốn xoá lịch sử nhắn tin không?", 'Đồng ý', 'Hủy', () async {
        await FirebaseHandler.deleteMessage()
            .whenComplete(() => {Get.back(), setState(() {})});
      }, () => Get.back(), context);
    });
  }
}

class Body extends StatelessWidget {
  late Function(String) sendMessage;

  Body({
    Key? key,
    required this.sendMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHandler.getListMessage(),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            print('Something Went Wrong');
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitChasingDots(color: Colors.brown, size: 32),
            );
          }
          List<MessageChat> messages = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            MessageChat answer = MessageChat.fromSnap(document);
            messages.add(answer);
          }).toList();
          // Post post = Post.fromSnap(snapshot.data!);
          return ListView.separated(
            itemBuilder: (context, i) {
              var obj = messages[messages.length - 1 - i];
              String message = obj.message ?? "";
              bool isUserMessage = obj.isUserMessage ?? false;
              var time = obj.timeStamp ?? "";
              var date = obj.timeStamp ?? "";
              DateTime now = DateTime.now();
              String today = DateFormat.yMMMMEEEEd().format(now);
              return Container(
                  child: (message.contains(RegExp('^[-]'), 0) && !isUserMessage)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              MessageButton(
                                  message: message, sendMessage: sendMessage)
                            ])
                      : Column(children: [
                          Center(child: Text(today == date ? time : date)),
                          // Center(child: Text(date)),
                          Row(
                              mainAxisAlignment: isUserMessage
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                MessageContainer(
                                    message: message,
                                    isUserMessage: isUserMessage),
                              ]),
                        ]));
            },
            separatorBuilder: (_, i) => Container(height: 10),
            itemCount: messages.length,
            reverse: true,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
          );
        });
  }
}

class MessageContainer extends StatelessWidget {
  final String message;
  final bool isUserMessage;

  const MessageContainer(
      {Key? key, required this.message, this.isUserMessage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return isUserMessage
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/chatbot.jpg'),
                            radius: 50,
                          ),
                        ),
                        horizontalSpaceTiny,
                        Text(
                          "Job Bot",
                          style: ktsMediumLabelInputText.copyWith(
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    verticalSpaceTiny,
                    Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                        color: Color(0xffBFBFBF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        message,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

class MessageButton extends StatefulWidget {
  final String message;
  late Function(String) sendMessage;
  MessageButton({
    Key? key,
    required this.message,
    required this.sendMessage,
  }) : super(key: key);

  @override
  State<MessageButton> createState() => _MessageButtonState();
}

class _MessageButtonState extends State<MessageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return InkWell(
            onTap: () {
              // setState(() {
              //   widget.sendMessage(widget.message);
              // });
              widget.sendMessage(widget.message);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: kgOptionChat,
                color: Color.fromARGB(255, 132, 132, 132),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

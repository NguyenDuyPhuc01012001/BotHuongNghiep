// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/utils/constants.dart';
import 'package:huong_nghiep/widgets/home/profile/app_bar_profile_widget.dart';
import '../../../utils/styles.dart';

class EditPasswordWidget extends StatefulWidget {
  const EditPasswordWidget({Key? key}) : super(key: key);

  @override
  State<EditPasswordWidget> createState() => _EditPasswordWidgetState();
}

class _EditPasswordWidgetState extends State<EditPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final String rule = "*Độ dài mật khẩu tối thiểu 6 ký tự*";

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void changePassword(String password) async {
    //Create an instance of the current user.
    User user = FirebaseAuth.instance.currentUser!;

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarProfileWidget(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                    width: 320,
                    child: const Text(
                      "Password của bạn",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu của bạn';
                            } else if (value.length < 6) {
                              return 'Mật khẩu phải tối thiểu 6 ký tự';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Mật khẩu'),
                          controller: passwordController,
                        ))),
                verticalSpaceRegular,
                Text(rule, style: ktsMediumInputText),
                verticalSpaceLarge,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            changePassword(passwordController.text);
                            Get.back();
                          }
                        },
                        child: const Text(
                          'Cập nhật',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ))
              ]),
        ));
  }
}

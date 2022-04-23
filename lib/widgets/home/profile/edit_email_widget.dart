// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/widgets/home/profile/app_bar_profile_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/home/home_provider.dart';

class EditEmailWidget extends StatefulWidget {
  const EditEmailWidget({Key? key}) : super(key: key);

  @override
  State<EditEmailWidget> createState() => _EditEmailWidgetState();
}

class _EditEmailWidgetState extends State<EditEmailWidget> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
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
                      "Email của bạn",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập email của bạn';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Vui lòng nhập đúng đinh dạng email';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Địa chỉ email'),
                          controller: emailController,
                        ))),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate() &&
                              EmailValidator.validate(emailController.text)) {
                            homeProvider.updateUserEmail(emailController.text);
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

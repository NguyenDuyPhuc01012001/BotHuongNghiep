// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/widgets/home/profile/app_bar_profile_widget.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

import '../../../providers/home/home_provider.dart';

class EditNameWidget extends StatefulWidget {
  const EditNameWidget({Key? key}) : super(key: key);

  @override
  State<EditNameWidget> createState() => _EditNameWidgetState();
}

class _EditNameWidgetState extends State<EditNameWidget> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
                  width: 330,
                  child: const Text(
                    "Họ và tên của bạn",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 320,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Hãy nhập tên của bạn';
                              } else if (isNumeric(value)) {
                                return 'Tên chỉ được phép ký tự';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Họ và tên'),
                            controller: nameController,
                          ))),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate() &&
                            nameController.text
                                    .compareTo(homeProvider.user.name) !=
                                0) {
                          homeProvider.updateUserName(nameController.text);
                          Get.back();
                        }
                      },
                      child: const Text(
                        'Cập nhật',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}

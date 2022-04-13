// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  int? switchScreen;

  @override
  void initState() {
    super.initState();
    switchScreen = 1;
  }

  Widget switchToAnotherScreen(BuildContext context) {
    if (switchScreen == 1) {
      return forgetPassword(context);
    } else {
      return CheckEmail(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
        height: screenSize.height * 0.7, child: switchToAnotherScreen(context));
  }

  Widget forgetPassword(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final TextEditingController _email = TextEditingController();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                      color: Color.fromRGBO(40, 40, 40, 1),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.015,
                  ),
                  const Text(
                    "Nhập email liên kết với tài khoản của bạn và chúng tôi sẽ gửi một hướng dẫn email để đặt lại mật khẩu của bạn.",
                    style: TextStyle(
                      color: Color.fromRGBO(40, 40, 40, 1),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Địa chỉ email",
              style: TextStyle(
                color: Color.fromRGBO(143, 143, 143, 1),
                fontFamily: "Roboto",
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: screenSize.height * 0.1,
                child: TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                      return "Địa chỉ email không hợp lệ";
                    } else {
                      return null;
                    }
                  },
                )),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            SizedBox(
              width: screenSize.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    auth.sendPasswordResetEmail(email: _email.text);
                    setState(() {
                      switchScreen = 2;
                    });
                  }
                },
                child: const Text(
                  "Gửi hướng dẫn",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget CheckEmail(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: const [
                    Text(
                      "Kiểm tra Email",
                      style: TextStyle(
                        color: Color.fromRGBO(40, 40, 40, 1),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Chúng tôi đã gửi một hướng dẫn khôi phục mật khẩu vào email đã đăng ký của bạn.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(40, 40, 40, 1),
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: screenSize.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Mở ứng dụng Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Tôi sẽ kiểm tra sau",
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Không nhận được email? Kiểm tra thư mục thư rác của bạn hoặc",
                style: TextStyle(
                  color: Color.fromRGBO(40, 40, 40, 1),
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    switchScreen = 1;
                  });
                },
                child: const Text(
                  "thử một địa chỉ email khác",
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

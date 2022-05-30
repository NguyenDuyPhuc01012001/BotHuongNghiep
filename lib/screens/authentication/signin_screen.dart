// ignore_for_file: unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:huong_nghiep/screens/authentication/signup_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication/signin_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/authentication/custom_error_box.dart';
import '../../widgets/authentication/custom_input_field.dart';
import '../../widgets/authentication/forget_password_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context);

    void signIn() {
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
        signInProvider.changeIsValidValue();
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54])
                  .createShader(
                      Rect.fromLTRB(0, -140, rect.width, rect.height * 0.8));
            },
            blendMode: BlendMode.darken,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/backgroundv2.jpg"),
                      fit: BoxFit.fill)),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/app_icon.png",
                            height: 100,
                            width: 100,
                          ),
                          const Text(
                            "X-JOB",
                            style: TextStyle(color: Colors.white, fontSize: 80),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CustomInputField(
                            customInputFieldType: CustomInputFieldType.text,
                            controller: _emailController,
                          ),
                          CustomInputField(
                              customInputFieldType:
                                  CustomInputFieldType.password,
                              controller: _passwordController),
                          signInProvider.isValid
                              ? Container()
                              : CustomErrorBox(
                                  message: signInProvider.errorMessage),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const ForgetPassword(),
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0)),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Quên mật khẩu",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    String result =
                                        await signInProvider.loginUser(
                                            email: _emailController.text,
                                            password: _passwordController.text);
                                  },
                                  child: signInProvider.isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Đăng nhập",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Bạn có thể tạo tài khoản",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          const SignUpScreen(),
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0)),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "ở đây",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

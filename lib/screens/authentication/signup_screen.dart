// ignore_for_file: unused_element, prefer_final_fields, unused_field, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication/signup_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/authentication/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final String welcome = "Đăng ký tài khoản";
  final String rule = "- Độ dài mật khẩu nên từ 8 đến 20 ký tự\n" +
      "- Mật khẩu nên có ký tự in thường\n" +
      "- Mật khẩu nên có ký tự in hoa\n" +
      "- Mật khẩu nên có một số hoặc ký tự chấp nhận được";
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  var _isProcessing = false;
  var _isClose = false;

  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              verticalSpaceLarge,
              Center(
                child: Text(
                  welcome,
                  style: ktsMediumTitleText,
                ),
              ),
              verticalSpaceMedium,
              SizedBox(
                  height: screenSize.height * 0.1,
                  child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Tên của bạn',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "Không được để trống tên";
                      return null;
                    },
                  )),
              SizedBox(
                  height: screenSize.height * 0.1,
                  child: TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      labelText: 'Địa chỉ email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Không được để trống địa chỉ email";
                      }
                      if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                          .hasMatch(value)) {
                        return "Địa chỉ email không đúng định dạng";
                      }
                      if (!signUpProvider.isValid) {
                        signUpProvider.isValid = true;
                        return signUpProvider.errorMessage;
                      }

                      return null;
                    },
                  )),
              // verticalSpaceSmall,
              SizedBox(
                height: screenSize.height * 0.1,
                child: TextFormField(
                  controller: _pass,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Mật khẩu",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xff9FA5C0),
                          ))),
                  obscureText: !_passwordVisible,
                  validator: (val) {
                    if (val!.isEmpty) return 'Không được để trống mật khẩu';
                    if (!(RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,20}$')
                            .hasMatch(val) ||
                        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~]).{8,20}$')
                            .hasMatch(val))) return 'Password is wrong format.';
                    return null;
                  },
                  onSaved: (val) => _pass.text = val!,
                ),
              ),
              // verticalSpaceSmall,
              Text(rule, style: ktsMediumInputText),
              verticalSpaceMedium,
              SizedBox(
                height: screenSize.height * 0.1,
                child: TextFormField(
                  controller: _confirmPass,
                  obscureText: !_confirmPasswordVisible,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Không được để trống xác nhận mật khẩu';
                    }
                    if (val != _pass.text) {
                      return 'Mật khẩu xác nhận không trùng khớp';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Xác nhận mật khẩu",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color(0xff9FA5C0),
                          ))),
                ),
              ),
              verticalSpaceSmall,
              // signUpProvider.isValid ? Container() : showAlertDialog(context),
              // signUpProvider.isValid ? Container() : Text("this is errorText"),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    child: const Text(
                      "Quay lại",
                      style: ktsButton,
                    ),
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(165, 50),
                      primary: kcPrimaryColor,
                      side: const BorderSide(width: 1.0, color: kcPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                horizontalSpaceSmall,
                Expanded(
                  child: CustomButton(
                    onPress: () async {
                      if (formKey.currentState!.validate()) {
                        await signUpProvider.signUp(
                          name: _name.text,
                          email: _email.text,
                          password: _pass.text,
                        );
                      }
                      if (!signUpProvider.isValid) {
                        formKey.currentState!.validate();
                      }
                    },
                    content: "Đăng ký",
                    isLoading: signUpProvider.isLoading,
                  ),
                ),
              ]),
            ],
          )),
    );
  }
}

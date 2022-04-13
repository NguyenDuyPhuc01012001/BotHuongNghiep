// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huong_nghiep/screens/authentication/signin_screen.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/authentication/draw_half_circle.dart';

class EmailVerifyScreen extends StatelessWidget {
  EmailVerifyScreen({Key? key}) : super(key: key);
  final User _user = FirebaseAuth.instance.currentUser!;
  String title = "Chỉ một bước nữa";
  String description =
      "Chúng tôi đã gửi một liên kết xác minh đến email này. Vui lòng kiểm tra email của bạn và xác nhận";
  String buttonContent = "Đi đến đăng nhập";
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kcWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomPaint(
            painter: MyPainter(),
            size: MediaQuery.of(context).size,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    //Back Button
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                // verticalSpaceSmall,
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: screenSize.height * 0.3,
                            child:
                                SvgPicture.asset("assets/images/Rating.svg")),
                        verticalSpaceMedium,
                        Text(
                          title,
                          style:
                              ktsMediumTitleText.copyWith(color: kcBlackColor),
                        ),
                        verticalSpaceTiny,
                        Text(
                          description,
                          style:
                              ktsMediumInputText.copyWith(color: kcBlackColor),
                        ),
                        verticalSpaceRegular,
                        Text(
                          _user.email!,
                          style: ktsMediumLabelInputText.copyWith(
                              color: kcBlackColor),
                        )
                      ],
                    ),
                  ),
                ),
                // verticalSpaceSmall,
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05),
                          child: ButtonTheme(
                            height: 39,
                            minWidth: 259,
                            child: ElevatedButton(
                                // onPressed: emailVerificationProvider.onSubmitClick,
                                onPressed: () {
                                  Get.to(SignInScreen());
                                },
                                child: Text(
                                  buttonContent,
                                  style:
                                      ktsButton.copyWith(color: kcWhiteColor),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

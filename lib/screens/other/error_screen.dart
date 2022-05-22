import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/other/slashing_screen.dart';
import 'package:huong_nghiep/utils/styles.dart';
import 'package:material_dialogs/material_dialogs.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              top: MediaQuery.of(context).size.height * 0.24,
              left: MediaQuery.of(context).size.width * 0.24,
              right: MediaQuery.of(context).size.width * 0.15,
              child: Text(
                "Ứng dụng đang gặp lỗi",
                style: kDefaultTextStyle.copyWith(
                    color: const Color(0xffBFBFBF), fontSize: 24),
                textAlign: TextAlign.justify,
              )),
          Center(
            child: Lottie.network(
                "https://assets3.lottiefiles.com/packages/lf20_k1rx9jox.json",
                fit: BoxFit.fitWidth),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xffBFBFBF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              onPressed: () {
                Get.off(const SplashingScreen());
              },
              child: Text(
                "Quay lại trang chủ".toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

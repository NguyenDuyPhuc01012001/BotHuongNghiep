import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:huong_nghiep/screens/menu/news_manage_screen.dart';

class SplashingScreen extends StatefulWidget {
  const SplashingScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashingScreen> {
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer(
      const Duration(seconds: 2),
      () => Get.offAll(const HomeScreen()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/jobs_icon.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

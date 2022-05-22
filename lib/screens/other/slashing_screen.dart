import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:provider/provider.dart';

import '../../providers/home/home_provider.dart';

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
      const Duration(seconds: 3),
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
    final homeProvider = Provider.of<HomeProvider>(context);
    homeProvider.getCurrentUser();
    return Material(
      child: Center(
        child: SizedBox(
          child: Lottie.network(
              "https://assets10.lottiefiles.com/packages/lf20_i9mtrven.json",
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

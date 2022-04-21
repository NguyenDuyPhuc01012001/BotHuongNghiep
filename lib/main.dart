// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/providers/authentication/emailverify_provider.dart';
import 'package:huong_nghiep/providers/authentication/signin_provider.dart';
import 'package:huong_nghiep/providers/authentication/signup_provider.dart';
import 'package:huong_nghiep/providers/home/home_provider.dart';
import 'package:huong_nghiep/screens/authentication/signin_screen.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:huong_nghiep/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInProvider>(
            create: (context) => SignInProvider()),
        ChangeNotifierProvider<SignUpProvider>(
            create: (context) => SignUpProvider()),
        ChangeNotifierProvider<EmailVerifyProvider>(
            create: (context) => EmailVerifyProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
      ],
      child: GetMaterialApp(
          title: 'Tư vấn hướng nghiệp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Roboto',
            primarySwatch: Colors.blue,
          ),
          home: FirebaseAuth.instance.currentUser == null
              ? SignInScreen()
              : HomeScreen(),
          routes: <String, WidgetBuilder>{
            // '/signin': (BuildContext context) => SignInScreen(),
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:huong_nghiep/controllers/question_controller.dart';
import 'package:huong_nghiep/providers/quiz/quiz_provider.dart';
import 'package:huong_nghiep/screens/home/home_screen.dart';
import 'package:huong_nghiep/utils/colors.dart';
import 'package:huong_nghiep/widgets/alert.dart';
import 'package:huong_nghiep/widgets/home/quiz/body.dart';
import 'package:provider/provider.dart';

// import '../../quiz/components/body.dart';

class QuizScreen extends StatelessWidget {
  final String type;
  const QuizScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _quizProvider = Provider.of<QuizProvider>(context);
    // _quizProvider.type = type;
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        //   // show the confirm dialog
        Alerts().confirm(
            'Bạn có chắc chắn muốn làm lại bài kiểm tra\n', 'Đồng ý', 'Hủy',
            () {
          willLeave = true;
          Get.back();
          Get.off(HomeScreen());
        }, () => Get.back(), context);
        return willLeave;
      },
      // () async {
      //   bool willLeave = false;
      //   // show the confirm dialog
      //   await showDialog(
      //       context: context,
      //       builder: (_) => AlertDialog(
      //             title: const Text('Are you sure want to leave?'),
      //             actions: [
      //               ElevatedButton(
      //                   onPressed: () {
      //                     willLeave = true;
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: const Text('Yes')),
      //               TextButton(
      //                   onPressed: () => Navigator.of(context).pop(),
      //                   child: const Text('No'))
      //             ],
      //           ));
      //   return willLeave;
      // },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // Fluttter show the back button automatically
          backgroundColor: kcPrimaryColor,
          elevation: 0,
        ),
        body: Body(type: type),
      ),
    );
  }
}

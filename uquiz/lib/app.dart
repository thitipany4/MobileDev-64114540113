import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/updatecontroller.dart';
import 'package:uquiz/members.dart';
import 'package:uquiz/shopping.dart';

// import 'home.dart';
// import 'shopping.dart';
import 'login.dart';

class UQuizBindings implements Bindings {
  @override
  void dependencies() {
    // Get.put(UquizController());
    Get.lazyPut(() =>
        UquizController(),); // lazyput คือยังไม่สร้างทางไปจะเปิดไปหน้าไหน ต้องเรียกใช้งานก่อนถึงสร้างความเร็วในการเปิดแอพ
       
  }
}

class UQuizApp extends StatefulWidget {
  const UQuizApp({super.key});

  @override
  State<UQuizApp> createState() => _UQuizAppState();
}

class _UQuizAppState extends State<UQuizApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UQuiz App',
      initialBinding: UQuizBindings(),
      // home: Home(),
      // home: MemberListPage(), //Shopping(),
      home: const LoginPage(),
    );
  }
}

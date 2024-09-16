import 'package:flutter/material.dart';
import 'package:uquiz/login.dart';
import 'package:uquiz/member.dart';

// import 'home.dart';
import 'shopping.dart';

class UQuizApp extends StatefulWidget {
  const UQuizApp({super.key});

  @override
  State<UQuizApp> createState() => _UQuizAppState();
}

class _UQuizAppState extends State<UQuizApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'UQuiz App',
      // home: Home(),
      home: LoginPage(),
    );
  }
}

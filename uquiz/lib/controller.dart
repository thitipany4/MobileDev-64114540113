import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uquiz/members.dart';
import 'package:uquiz/models.dart';
import 'package:uquiz/shopping.dart';

class UquizController extends GetxController {
  var appName = 'uQuiz'.obs;
  var memberCount = 0.obs;
  var memberList = <Member>[]
      .obs; // if you want to use list and <member>[].obs if you want get type of Member list
  final pb = PocketBase('http://127.0.0.1:8090');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isAdmin = false.obs;

  Future<void> authen(String email, String password) async {
    final res = pb.admins.authWithPassword(email, password);
    isAdmin = true.obs;
    if (pb.authStore.isValid) {
      print('admin logged in: ${email}');
      Get.to(() => const MemberListPage());
    } else {
      final res = pb.collection('users').authWithPassword(email, password);
      isAdmin = false.obs;
      if (pb.authStore.isValid) {
        print('user logged in: ${email}');
        Get.to(() => const Shopping());
      }
    }
  }
}

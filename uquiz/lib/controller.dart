import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uquiz/login.dart';
import 'package:uquiz/members.dart';
// import 'package:uquiz/models.dart';
import 'package:uquiz/shopping.dart';

class UquizController extends GetxController {
  var appName = 'uQuiz'.obs;
  // var memberCount = 0.obs;
  // var memberList = <Member>[].obs;
  var token = ''.obs;
  var isLoggedIn = false.obs;
  final pb = PocketBase('http://127.0.0.1:8090');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isAdmin = false.obs;
  var username = ''.obs; 
  var email = ''.obs;

  Future<void> authen(String email, String password) async {
    try {
      // ลองทำการล็อกอินในส่วน admin ก่อน
      final res = await pb.admins.authWithPassword(email, password);
      isAdmin.value = true; // กำหนดว่าเป็น admin
      print('Admin logged in: $email');
      
      // ตรวจสอบว่าการรับรองตัวตนสำเร็จ
      if (pb.authStore.isValid) {
        var pbToken = pb.authStore.token;
        print('token ${pbToken}');
        // setToken(pbToken);
        Get.to(() => const MemberListPage());
      }
    } catch (e) {
      // หากการรับรองตัวตนของ admin ล้มเหลว
      print('Admin login failed, trying user login...');
      try {
        // ลองล็อกอินเป็น user แผน แล้วทำการรับข้อมูล email เพื่อส่งไปให้ หน้า shopping แล้ว if เอาเพื่อแสดง ชื่อใน profile 
        final res = await pb.collection('users').authWithPassword(email, password);
        isAdmin.value = false; // กำหนดว่าเป็น user
        print('User logged in: $email');
        
        // ตรวจสอบว่าการรับรองตัวตนสำเร็จ
        if (pb.authStore.isValid) {
          var pbToken = pb.authStore.token;

          print('isvalid ${pb.authStore.isValid}');
          print('email="$email"');
          final members = await pb.collection('users').getList(
           filter: 'email="$email"',  // ค้นหาด้วยเงื่อนไข email ตรงกับที่ล็อกอิน
          );
          if (members.items.isNotEmpty) {
            // Access the first user in the items array
            var user = members.items[0];
            String username = user.getStringValue('username') ?? 'N/A';  // Get username
            String email = user.getStringValue('email') ?? 'N/A';        // Get email
            setToken(pbToken,username,email);
            print('Username: $username');
            print('Email: $email');
          } else {
            print('No members found');
          }
          // pb.authStore.clear();
          print('isvalid ${pb.authStore.isValid}');
          Get.to(() => const Shopping(), arguments: {'token': token});
        }
      } catch (e) {
        // หากการรับรองตัวตนล้มเหลวทั้ง admin และ user
        print('User login failed: $e');
        Get.snackbar('Login Failed', 'Incorrect email or password.');
      }
    }
  }
  void setToken(String newToken,String newUsername,String newEmail) {
    token.value = newToken;
    username.value = newUsername;
    email.value = newEmail;
    isLoggedIn.value = true;
  }
  void login() {
    Get.offAll(() => const LoginPage()); // กลับไปที่หน้า Login หลัง logout

  }
  // Logout function
  void logout() {
    token.value = '';
    isLoggedIn.value = false;
    pb.authStore.clear(); // Clear PocketBase auth data
    Get.offAll(() => const Shopping()); // กลับไปที่หน้า Login หลัง logout
  }
}

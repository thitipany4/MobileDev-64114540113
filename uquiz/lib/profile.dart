import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  final UquizController uquizController = Get.find<UquizController>();

  @override
  Widget build(BuildContext context) {
    var token = uquizController.token.value;
    var email = uquizController.email.value;
    var username = uquizController.username.value;
    print('username $username');
    print('email $email');


    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 20),
            // const Text('User Name', style: TextStyle(fontSize: 20)),
            // const SizedBox(height: 10),
            // const Text('Email: user@example.com', style: TextStyle(fontSize: 16)),
            
            // // แสดง token หากมีค่า
            if (token.isNotEmpty) 
               Text('Token: $token', style: const TextStyle(fontSize: 16)),
               Text('Token: $email', style: const TextStyle(fontSize: 16)),
               Text('Token: $username', style: const TextStyle(fontSize: 16)),

          ],
        ),
      ),
    );
  }

}

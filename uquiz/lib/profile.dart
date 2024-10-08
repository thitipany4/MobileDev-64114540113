import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/product.dart';
import 'package:uquiz/shopping.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UquizController uquizController = Get.find<UquizController>();
  final String image = 'https://randomuser.me/api/portraits/lego/5.jpg';

  @override
  Widget build(BuildContext context) {
    // var token = uquizController.token.value;
    var email = uquizController.email.value;
    var username = uquizController.username.value;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(image),
                // backgroundColor: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                username.isNotEmpty ? username : "Username",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email.isNotEmpty ? email : "Email not available",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
            //   if (token.isNotEmpty)
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //       child: Text(
            //         "Token: $token",
            //         style: const TextStyle(
            //           fontSize: 14,
            //           color: Colors.white54,
            //           fontStyle: FontStyle.italic,
            //         ),
            //         textAlign: TextAlign.center,
            //       ),
            //     ),
            ],
          ),
        ),
      ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (index) {
                if (index == 0) {
                  Get.to(() => const Product());
                } else if (index == 1) {
                  Get.to(() => const Shopping());
                }
              },
              selectedIndex: 1,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Product'),
                NavigationDestination(icon: Icon(Icons.shop), label: 'Shop'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'Profile'),
              ],
            ),
    );
  }
}

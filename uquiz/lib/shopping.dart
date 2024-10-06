import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:requests/requests.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/profile.dart';
import 'home.dart';
import 'package:get/get.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  final UquizController uquizController = Get.find<UquizController>();
  @override
  Widget build(BuildContext context) {
    // url = 'https://fakestoreapi.com/products?limit=5'
    // var token = Get.arguments['token'];
    // print('Received token: $token');
    var token = uquizController.token.value;
    var email = uquizController.email.value;
    var username = uquizController.username.value;

    print('Token: $token');
    print('Email: $email');
    print('Username: $username');
    const images = [
      "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
      "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
      "https://fakestoreapi.com/img/71YXzeOuslL._AC_UY879_.jpg",
      "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("UQuiz Shopping"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                if (uquizController.isLoggedIn.value) ...[ // ถ้าล็อกอินแสดงข้อมูลผู้ใช้
                  Text(
                    username, // Display username if logged in
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      uquizController.logout(); // เรียกใช้ฟังก์ชัน logout
                      print('Logout successful');
                      // Clear navigation stack and go back to login page
                      // Get.offAllNamed('/login'); 
                    },
                  ),
                ] else ...[ // ถ้าไม่ได้ล็อกอิน แสดงปุ่ม Login
                  IconButton(
                    icon: const Icon(Icons.login),
                    onPressed: () {
                      uquizController.login();
                      print('you dont login');
                      // Navigate to login screen
                      // Get.toNamed('/login');
                    },
                  ),
                ]
              ],
            ),
          ),
        ],
      ),

      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Center(child: Image.network(images[index]));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(padding: EdgeInsets.all(8), child: Text(''));
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          print('select page: $index');
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home(),));
          } else if (index == 2) {  // เมื่อผู้ใช้กดปุ่มโปรไฟล์
           Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const ProfilePage())
          );
          }
        },
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.shop), label: 'Shop'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Profile'),
        ],
      ),
    );
  }
}

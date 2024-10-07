import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/members.dart';
import 'package:uquiz/register.dart';
import 'package:uquiz/shopping.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // final emailController = TextEditingController();
  // final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UquizController>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Login', style: TextStyle(fontSize: 20))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: false,
                controller: ctrl.emailController,
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                controller: ctrl.passwordController,
                validator: (value) {
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 209, 173, 54), // เปลี่ยนเป็นสีเขียว
                      overlayColor: Colors.white, // ข้อความบนปุ่มเป็นสีขาว
                      shadowColor: const Color.fromARGB(255, 212, 116, 42), // เปลี่ยนสีเงาเมื่อกดปุ่ม
                      elevation: 5, // เพิ่มความสูงเงาของปุ่ม
                      minimumSize: const Size(double.infinity, 50), // กำหนดขนาดความยาว
                  
                    ),
                  onPressed: () {
                      //Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  child: const Text('Sign Up',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                
                  ),),
                ),
              ),
            ),      
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 129, 68, 242), // เปลี่ยนเป็นสีเขียว
                      overlayColor: Colors.white, // ข้อความบนปุ่มเป็นสีขาว
                      shadowColor: const Color.fromARGB(255, 114, 54, 244), // เปลี่ยนสีเงาเมื่อกดปุ่ม
                      elevation: 5, // เพิ่มความสูงเงาของปุ่ม
                      minimumSize: const Size(double.infinity, 50), // กำหนดขนาดความยาว
                    ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform login logic here
                      print('email: ${ctrl.emailController.text}');
                      print('password: ${ctrl.passwordController.text}');
                
                      //Navigator.pop(context);
                      ctrl.authen(ctrl.emailController.text,
                          ctrl.passwordController.text);
                    }
                  },
                  child: const Text('Sign In',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void to(BuildContext context, Widget page) {
  //   Navigator.push<void>(
  //     context,
  //     MaterialPageRoute<void>(
  //       builder: (BuildContext context) => page,
  //     ),
  //   );
  // }
}

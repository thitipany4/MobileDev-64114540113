import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
// import 'package:pocketbase/pocketbase.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final pb = PocketBase('https://your-pocketbase-url.com');
  final _formKey = GlobalKey<FormState>();
 @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<UquizController>();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Register', style: TextStyle(fontSize: 20))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: false,
                controller: ctrl.usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: false,
                controller: ctrl.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: false,
                controller: ctrl.nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                controller: ctrl.passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                controller: ctrl.passwordconfirmController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password Confirm',
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
                      Navigator.pop(context);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 19, 21, 157), // เปลี่ยนเป็นสีเขียว
                      overlayColor: Colors.white, // ข้อความบนปุ่มเป็นสีขาว
                      shadowColor: const Color.fromARGB(255, 20, 25, 77), // เปลี่ยนสีเงาเมื่อกดปุ่ม
                      elevation: 5, // เพิ่มความสูงเงาของปุ่ม
                      minimumSize: const Size(double.infinity, 50), // กำหนดขนาดความยาว
                    ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform login logic here
                      print('email: ${ctrl.emailController.text}');
                      print('password: ${ctrl.passwordController.text}');
                
                      //Navigator.pop(context);
                      ctrl.register(ctrl.usernameController.text,
                      ctrl.emailController.text,
                      ctrl.nameController.text,
                      ctrl.passwordController.text,
                      ctrl.passwordconfirmController.text

                      );
                
                    }
                  },

                  child: const Text('Submit',
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
}
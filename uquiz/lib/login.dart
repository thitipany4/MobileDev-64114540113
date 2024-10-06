import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/members.dart';
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
              child: ElevatedButton(
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
                child: const Text('Submit'),
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

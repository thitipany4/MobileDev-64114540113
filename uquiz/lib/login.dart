import 'package:flutter/material.dart';
import 'package:uquiz/shopping.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailControllter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(

        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(8.0), child: Text("Login")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailControllter,
                // validator: (value),
              ),
            ),
            const Text("password"),
            Padding(padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push<void>((context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext)) => const Shopping(),
                 
                ) as BuildContext,);
              }
            }, child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}

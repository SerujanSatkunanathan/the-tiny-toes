import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController username_controller = TextEditingController();
    TextEditingController password_controller = TextEditingController();

    final screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "The Tiny Toes",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          Form(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    controller: username_controller,
                    decoration: const InputDecoration(
                        label: Text("Username"),
                        hintText: "username",
                        prefixIcon: Icon(Icons.person_2)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password_controller,
                    obscureText: true,
                    decoration: const InputDecoration(
                        label: Text("Password"),
                        hintText: "password",
                        prefixIcon: Icon(Icons.password_rounded)),
                  )
                ],
              ),
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: screensize.width * 0.8,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: const Text("Login")))
        ],
      ),
    );
  }
}

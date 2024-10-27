import 'package:flutter/material.dart';
import 'package:the_tiny_toes_app/Screens/user_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _usernamecontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();

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
                    controller: _usernamecontroller,
                    decoration: const InputDecoration(
                        label: Text("Username"),
                        hintText: "username",
                        prefixIcon: Icon(Icons.person_2)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordcontroller,
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserPage()));
                  },
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

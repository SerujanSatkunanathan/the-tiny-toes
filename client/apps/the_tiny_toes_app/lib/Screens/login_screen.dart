import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes_app/Screens/user_page.dart';
import 'package:the_tiny_toes_app/provider/user_provider.dart';
import 'package:the_tiny_toes_app/service/storage.dart';

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
    final _storageService = StorageService();

    void login() {
      if (_usernamecontroller.text == 'admin' &&
          _passwordcontroller.text == 'password') {
        Provider.of<UserProvider>(context, listen: false)
            .login(_usernamecontroller.text);
        _storageService.saveusername(_usernamecontroller.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const UserPage()));
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text('Invalid username or password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }

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
                    login();
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

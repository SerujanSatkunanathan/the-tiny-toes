import 'package:flutter/material.dart';
import 'package:the_tiny_toes_app/Screens/login_screen.dart';
import 'package:the_tiny_toes_app/network/user_jason.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> users = [];
  UserJason usernames = UserJason();

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final fetchedUsername = await usernames.fetchUsers();
    setState(() {
      users = fetchedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Center(
            child: Text(
          "USER",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        )),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ),
        actions: [
          const Text("user"),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_2)),
        ],
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      users[index]['name'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}

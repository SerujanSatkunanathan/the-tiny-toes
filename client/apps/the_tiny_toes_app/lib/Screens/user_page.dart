import 'package:flutter/material.dart';
import 'package:the_tiny_toes_app/Screens/album_screen.dart';
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
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    try {
      final fetchedUsername = await usernames.fetchUsers();
      setState(() {
        users = fetchedUsername;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load users: ${error.toString()}';
        isLoading = false;
      });
    }
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
              Navigator.pushReplacement(
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
          const Text(
            "user",
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.person_2_rounded)),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserAlbumsScreen(
                                userId: users[index]['id'],
                                userName: users[index]['name'],
                              ),
                            ),
                          );
                        },
                        title: Text(
                          users[index]['name'],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

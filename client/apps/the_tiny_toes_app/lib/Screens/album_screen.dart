import 'package:flutter/material.dart';
import 'package:the_tiny_toes_app/Screens/login_screen.dart';
import 'package:the_tiny_toes_app/network/user_jason.dart';

class UserAlbumsScreen extends StatefulWidget {
  final int userId;
  final String userName;

  const UserAlbumsScreen(
      {Key? key, required this.userId, required this.userName})
      : super(key: key);

  @override
  State<UserAlbumsScreen> createState() => _UserAlbumsScreenState();
}

class _UserAlbumsScreenState extends State<UserAlbumsScreen> {
  List<Map<String, dynamic>> albums = [];
  Album albumService = Album();

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    final fetchedAlbums = await albumService.fetchAlbumsForUser(widget.userId);
    setState(() {
      albums = fetchedAlbums;
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
          "ALBUM",
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
          Text(widget.userName),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_2)),
        ],
      ),
      body: albums.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(albums[index]['title']),
                  ),
                );
              },
            ),
    );
  }
}

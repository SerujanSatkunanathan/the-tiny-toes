import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes_app/Screens/login_screen.dart';
import 'package:the_tiny_toes_app/provider/album_provider.dart';

class UserAlbumsScreen extends StatelessWidget {
  final int userId;
  final String userName;

  const UserAlbumsScreen({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (albumProvider.albums.isEmpty) {
        albumProvider.fetchAlbumsForUser(userId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Center(
            child: Text(
          "ALBUM",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
          Text(
            "$userName",
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.person_2_rounded)),
        ],
      ),
      body: Consumer<AlbumProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          } else if (provider.albums.isEmpty) {
            return const Center(child: Text("No albums found."));
          }

          return ListView.builder(
            itemCount: provider.albums.length,
            itemBuilder: (context, index) {
              final album = provider.albums[index];
              return Card(
                child: ListTile(
                  leading: album['thumbnailUrl'] != null
                      ? Image.network(album['thumbnailUrl'],
                          width: 50, height: 50)
                      : const Icon(Icons.image),
                  title: Text(album['title']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

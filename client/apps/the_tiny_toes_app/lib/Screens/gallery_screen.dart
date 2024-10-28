import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:the_tiny_toes_app/Screens/login_screen.dart';
import 'package:the_tiny_toes_app/provider/photo_provider.dart';

class GalleryPage extends StatelessWidget {
  final int albumId;
  final String userName;

  const GalleryPage({Key? key, required this.albumId, required this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      photoProvider.fetchPhotosForAlbum(albumId);
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Center(
            child: Text(
          "Gallery",
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
            userName,
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.person_2_rounded)),
        ],
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          } else if (provider.photos.isEmpty) {
            return const Center(child: Text("No photos found."));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: provider.photos.length,
              itemBuilder: (context, index) {
                final photo = provider.photos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullscreenGalleryView(
                          photos: provider.photos,
                          initialIndex: index,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        photo['thumbnailUrl'] ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FullscreenGalleryView extends StatelessWidget {
  final List<Map<String, dynamic>> photos;
  final int initialIndex;

  const FullscreenGalleryView({
    Key? key,
    required this.photos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo View"),
      ),
      body: PhotoViewGallery.builder(
        itemCount: photos.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photos[index]['url'] ?? ''),
            heroAttributes: PhotoViewHeroAttributes(tag: photos[index]['id']),
          );
        },
        pageController: PageController(initialPage: initialIndex),
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
      ),
    );
  }
}

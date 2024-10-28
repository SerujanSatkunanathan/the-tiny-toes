import 'package:flutter/material.dart';
import 'package:the_tiny_toes_app/network/user_jason.dart';

class AlbumProvider with ChangeNotifier {
  List<Map<String, dynamic>> _albums = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get albums => _albums;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final Album albumService = Album();

  Future<void> fetchAlbumsForUser(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    _albums = [];
    notifyListeners();

    try {
      final fetchedAlbums = await albumService.fetchAlbumsForUser(userId);
      _albums = fetchedAlbums;
    } catch (error) {
      _errorMessage = "Failed to load albums: ${error.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

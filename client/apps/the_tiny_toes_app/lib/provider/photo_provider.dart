import 'package:flutter/material.dart';
import 'package:the_tiny_toes_app/network/user_jason.dart';

class PhotoProvider with ChangeNotifier {
  List<Map<String, dynamic>> _photos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Map<String, dynamic>> get photos => _photos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final PhotoService _photoService = PhotoService();

  Future<void> fetchPhotosForAlbum(int albumId) async {
    _isLoading = true;
    _errorMessage = null;
    _photos = [];
    notifyListeners();

    try {
      final fetchedPhotos = await _photoService.fetchPhotosForAlbum(albumId);
      _photos = fetchedPhotos;
    } catch (error) {
      _errorMessage = "Failed to load photos: ${error.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

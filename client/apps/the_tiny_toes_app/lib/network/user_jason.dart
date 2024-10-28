import 'dart:convert';
import 'package:http/http.dart' as http;

class UserJason {
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final url = 'https://jsonplaceholder.typicode.com/users';

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to load users with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}

class Album {
  Future<List<Map<String, dynamic>>> fetchAlbumsForUser(int userId) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/albums?userId=$userId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception('Failed to load albums');
    }
  }
}

class PhotoService {
  Future<List<Map<String, dynamic>>> fetchPhotosForAlbum(int albumId) async {
    final url = 'https://jsonplaceholder.typicode.com/albums/$albumId/photos';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception("Failed to load photos");
      }
    } catch (e) {
      throw Exception("Error fetching photos: $e");
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserJason {
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse);
    } else {
      throw Exception('Failed to load users');
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

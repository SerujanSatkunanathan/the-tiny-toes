import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveusername(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', username);
  }

  Future<String?> getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('username');
  }

  Future<void> clearUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('username');
  }
}

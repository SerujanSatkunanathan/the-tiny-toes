import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? username;

  void login(String user) {
    username = user;
    notifyListeners();
  }

  void logout() {
    username = null;
    notifyListeners();
  }
}

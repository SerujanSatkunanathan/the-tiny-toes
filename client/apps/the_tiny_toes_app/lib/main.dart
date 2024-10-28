import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_tiny_toes_app/Screens/login_screen.dart';
import 'package:the_tiny_toes_app/provider/album_provider.dart';
import 'package:the_tiny_toes_app/provider/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}

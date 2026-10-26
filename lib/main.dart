import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const CatTechApp());
}

class CatTechApp extends StatelessWidget {
  const CatTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo Tech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

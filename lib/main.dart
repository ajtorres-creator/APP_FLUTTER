import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();

  await notificationService.initialize();
  await notificationService.requestPermission();

  runApp(const CatTechApp());
}

class CatTechApp extends StatelessWidget {
  const CatTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    const azulPrincipal = Color(0xFF2563EB);
    const azulOscuro = Color(0xFF101827);
    const celeste = Color(0xFF22D3EE);
    const fondo = Color(0xFFF1F5F9);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NexTech',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: fondo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: azulPrincipal,
          primary: azulPrincipal,
          secondary: celeste,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: azulOscuro,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: azulPrincipal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

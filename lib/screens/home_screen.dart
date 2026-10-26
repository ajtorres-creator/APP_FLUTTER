import 'package:flutter/material.dart';

import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Tech'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido a Catálogo Tech',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Descubre nuestros productos tecnológicos.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ProductCard(
              title: 'Smartphone Pro',
              description: 'Teléfono moderno con cámara de alta calidad.',
              price: '\$399.99',
              icon: Icons.smartphone,
            ),
            ProductCard(
              title: 'Laptop Ultra',
              description: 'Equipo ideal para estudiar y trabajar.',
              price: '\$799.99',
              icon: Icons.laptop,
            ),
            ProductCard(
              title: 'Auriculares Bluetooth',
              description: 'Escucha tu música con comodidad.',
              price: '\$49.99',
              icon: Icons.headphones,
            ),
          ],
        ),
      ),
    );
  }
}

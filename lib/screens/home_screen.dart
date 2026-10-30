import 'package:flutter/material.dart';

import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NexTech',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF101827), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tecnología que conecta contigo',
                    style: TextStyle(
                      color: Color(0xFF22D3EE),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Bienvenido a NexTech',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Descubre productos tecnológicos para tu día a día.',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Categorías destacadas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101827),
              ),
            ),

            const SizedBox(height: 12),

            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(avatar: Icon(Icons.phone), label: Text('Teléfonos')),
                Chip(avatar: Icon(Icons.laptop), label: Text('Computadoras')),
                Chip(avatar: Icon(Icons.headphones), label: Text('Accesorios')),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Nuestros productos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101827),
              ),
            ),

            const SizedBox(height: 12),

            ProductCard(
              title: 'Phone',
              description: 'Teléfono moderno con cámara de alta calidad.',
              price: '\$399.99',
              icon: Icons.phone,
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

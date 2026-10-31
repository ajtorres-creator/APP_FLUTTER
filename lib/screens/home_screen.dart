import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/connectivity_services.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ConnectivityService _connectivityService = ConnectivityService();

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _hasConnection = true;
  bool _loadingConnection = true;

  @override
  void initState() {
    super.initState();

    _checkInitialConnection();

    _subscription = _connectivityService.connectivityStream.listen((results) {
      if (!mounted) return;

      setState(() {
        _hasConnection = _connectivityService.hasConnection(results);
        _loadingConnection = false;
      });
    });
  }

  Future<void> _checkInitialConnection() async {
    try {
      final results = await _connectivityService.checkConnection();

      if (!mounted) return;

      setState(() {
        _hasConnection = _connectivityService.hasConnection(results);
        _loadingConnection = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _hasConnection = false;
        _loadingConnection = false;
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

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
            if (!_loadingConnection && !_hasConnection)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.wifi_off, color: Colors.red.shade700),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Sin conexión a Internet. Revisa tu red.',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

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

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/connectivity_services.dart';
import '../services/local_storage_service.dart';
import '../services/image_services.dart';
import '../services/notification_service.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ConnectivityService _connectivityService = ConnectivityService();
  final LocalStorageService _localStorageService = LocalStorageService();
  final ImageService _imageService = ImageService();
  final NotificationService _notificationService = NotificationService();

  File? _selectedImage;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _hasConnection = true;
  bool _loadingConnection = true;
  bool _sendingNotification = false;

  @override
  void initState() {
    super.initState();

    _initializeConnection();

    _subscription = _connectivityService.connectivityStream.listen((results) {
      _updateConnection(results);
    });
  }

  // Inicializar el estado de conexión
  Future<void> _initializeConnection() async {
    try {
      final savedStatus = await _localStorageService.getConnectionStatus();

      if (!mounted) return;

      if (savedStatus != null) {
        setState(() {
          _hasConnection = savedStatus;
          _loadingConnection = false;
        });
      }

      final results = await _connectivityService.checkConnection();

      if (!mounted) return;

      final currentStatus = _connectivityService.hasConnection(results);

      setState(() {
        _hasConnection = currentStatus;
        _loadingConnection = false;
      });

      await _localStorageService.saveConnectionStatus(currentStatus);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _hasConnection = false;
        _loadingConnection = false;
      });
    }
  }

  // Actualizar el estado de conexión
  Future<void> _updateConnection(List<ConnectivityResult> results) async {
    final connected = _connectivityService.hasConnection(results);

    if (!mounted) return;

    setState(() {
      _hasConnection = connected;
      _loadingConnection = false;
    });

    await _localStorageService.saveConnectionStatus(connected);
  }

  // Seleccionar imagen desde cámara o galería
  Future<void> _selectImage(bool fromCamera) async {
    try {
      final image = fromCamera
          ? await _imageService.takePhoto()
          : await _imageService.selectFromGallery();

      if (image == null || !mounted) return;

      setState(() {
        _selectedImage = image;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar imagen: $e')),
      );
    }
  }

  // Recortar imagen seleccionada
  Future<void> _cropSelectedImage() async {
    if (_selectedImage == null) return;

    try {
      final croppedImage = await _imageService.cropImage(_selectedImage!);

      if (croppedImage == null || !mounted) return;

      setState(() {
        _selectedImage = croppedImage;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al recortar imagen: $e')));
    }
  }

  // Enviar una notificación local de prueba
  Future<void> _sendNotification() async {
    if (_sendingNotification) return;

    setState(() {
      _sendingNotification = true;
    });

    try {
      await _notificationService.showNotification();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notificación enviada correctamente.')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar notificación: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _sendingNotification = false;
        });
      }
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
            // Aviso de conexión
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

            // Presentación NexTech
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

            // Categorías
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

            // Sección de cámara y galería
            const Text(
              'Mi imagen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101827),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _selectedImage != null
                        ? Image.file(_selectedImage!, fit: BoxFit.cover)
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 65,
                                color: Color(0xFF2563EB),
                              ),
                              SizedBox(height: 8),
                              Text('Sin imagen seleccionada'),
                            ],
                          ),
                  ),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _selectImage(true),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar fotografía'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _selectImage(false),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Seleccionar de galería'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2563EB),
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),

                  if (_selectedImage != null) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _cropSelectedImage,
                        icon: const Icon(Icons.crop),
                        label: const Text('Recortar imagen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF101827),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Sección de notificaciones
            const Text(
              'Notificaciones NexTech',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF101827),
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Color(0xFF2563EB),
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Mantente informado',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Recibe avisos y novedades directamente en tu dispositivo.',
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _sendingNotification
                          ? null
                          : _sendNotification,
                      icon: _sendingNotification
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.notifications),
                      label: Text(
                        _sendingNotification
                            ? 'Enviando...'
                            : 'Probar notificación',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Productos
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/connectivity_provider.dart';
import '../providers/image_provider.dart';
import '../services/notification_service.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationService _notificationService = NotificationService();

  bool _sendingNotification = false;

  void _showMessage(String message, {bool error = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : null,
      ),
    );
  }

  Future<void> _selectImage(bool fromCamera) async {
    final imageProvider = context.read<ImageProviderApp>();

    if (fromCamera) {
      await imageProvider.takePhoto();
    } else {
      await imageProvider.selectFromGallery();
    }

    if (!mounted) return;

    if (imageProvider.selectedImage != null) {
      _showMessage('Imagen seleccionada correctamente.');
    } else {
      _showMessage(
        imageProvider.errorMessage ?? 'No se seleccionó ninguna imagen.',
        error:
            imageProvider.errorMessage != null &&
            imageProvider.errorMessage != 'No se seleccionó ninguna imagen.',
      );
    }
  }

  Future<void> _cropSelectedImage() async {
    final imageProvider = context.read<ImageProviderApp>();

    await imageProvider.cropImage();

    if (!mounted) return;

    if (imageProvider.selectedImage != null &&
        imageProvider.errorMessage == null) {
      _showMessage('Imagen procesada correctamente.');
    } else if (imageProvider.errorMessage != null) {
      _showMessage(imageProvider.errorMessage!, error: true);
    }
  }

  Future<void> _sendNotification() async {
    if (_sendingNotification) return;

    setState(() {
      _sendingNotification = true;
    });

    try {
      await _notificationService.showNotification();

      if (!mounted) return;

      _showMessage('Notificación enviada correctamente.');
    } catch (e) {
      debugPrint('Error al enviar notificación: $e');

      if (!mounted) return;

      _showMessage('Error al enviar la notificación.', error: true);
    } finally {
      if (mounted) {
        setState(() {
          _sendingNotification = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final connection = context.watch<ConnectivityProvider>();
    final images = context.watch<ImageProviderApp>();

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
            if (!connection.loading && !connection.hasConnection)
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
                        'Sin conexión de red. Revisa tu conexión.',
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
                    child: images.selectedImage != null
                        ? Image.file(images.selectedImage!, fit: BoxFit.cover)
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
                      onPressed: images.loading
                          ? null
                          : () => _selectImage(true),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar fotografía'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: images.loading
                          ? null
                          : () => _selectImage(false),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Seleccionar de galería'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2563EB),
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),

                  if (images.selectedImage != null) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: images.loading ? null : _cropSelectedImage,
                        icon: const Icon(Icons.crop),
                        label: const Text('Recortar imagen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF101827),
                        ),
                      ),
                    ),
                  ],

                  if (images.loading) ...[
                    const SizedBox(height: 12),
                    const CircularProgressIndicator(),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 25),

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

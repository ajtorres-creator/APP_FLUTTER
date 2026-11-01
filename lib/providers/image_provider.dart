import 'dart:io';

import 'package:flutter/foundation.dart';

import '../services/image_services.dart';

class ImageProviderApp extends ChangeNotifier {
  final ImageService _imageService = ImageService();

  File? _selectedImage;
  bool _loading = false;
  String? _errorMessage;

  File? get selectedImage => _selectedImage;
  bool get loading => _loading;
  String? get errorMessage => _errorMessage;

  Future<void> selectFromGallery() async {
    await _processImage(_imageService.selectFromGallery);
  }

  Future<void> takePhoto() async {
    await _processImage(_imageService.takePhoto);
  }

  Future<void> cropImage() async {
    if (_selectedImage == null) return;

    await _processImage(() => _imageService.cropImage(_selectedImage!));
  }

  Future<void> _processImage(Future<File?> Function() operation) async {
    if (_loading) return;

    _loading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final image = await operation();

      if (image != null) {
        _selectedImage = image;
      } else {
        _errorMessage =
            _imageService.lastError ?? 'No se seleccionó ninguna imagen.';
      }
    } catch (e) {
      _errorMessage = 'Ocurrió un error al procesar la imagen.';
      debugPrint('Error en ImageProvider: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

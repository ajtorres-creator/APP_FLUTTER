import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  String? lastError;

  // Seleccionar una imagen desde la galería
  Future<File?> selectFromGallery() async {
    lastError = null;

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (e) {
      lastError = 'No se pudo acceder a la galería. Revisa los permisos.';
      debugPrint('Error de galería: ${e.message}');
      return null;
    } catch (e) {
      lastError = 'Ocurrió un error al seleccionar la imagen.';
      debugPrint('Error al seleccionar imagen: $e');
      return null;
    }
  }

  // Tomar una fotografía con la cámara
  Future<File?> takePhoto() async {
    lastError = null;

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image == null) return null;

      return File(image.path);
    } on PlatformException catch (e) {
      lastError = 'No se pudo acceder a la cámara. Revisa los permisos.';
      debugPrint('Error de cámara: ${e.message}');
      return null;
    } catch (e) {
      lastError = 'Ocurrió un error al tomar la fotografía.';
      debugPrint('Error al tomar fotografía: $e');
      return null;
    }
  }

  // Recortar y comprimir una imagen
  Future<File?> cropImage(File imageFile) async {
    lastError = null;

    try {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Recortar imagen',
            toolbarColor: const Color(0xFF101827),
            toolbarWidgetColor: const Color(0xFFFFFFFF),
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedImage == null) return null;

      return File(croppedImage.path);
    } on PlatformException catch (e) {
      lastError = 'No se pudo recortar la imagen.';
      debugPrint('Error al recortar: ${e.message}');
      return null;
    } catch (e) {
      lastError = 'Ocurrió un error al procesar la imagen.';
      debugPrint('Error al procesar imagen: $e');
      return null;
    }
  }
}

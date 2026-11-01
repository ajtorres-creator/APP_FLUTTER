import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  // Seleccionar una imagen desde la galería
  Future<File?> selectFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return null;

    return File(image.path);
  }

  // Tomar una fotografía con la cámara
  Future<File?> takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image == null) return null;

    return File(image.path);
  }

  // Recortar una imagen
  Future<File?> cropImage(File imageFile) async {
    final CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 80,
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
  }
}

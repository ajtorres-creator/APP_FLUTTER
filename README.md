# NexTech

**Tecnología que conecta contigo.**

NexTech es una aplicación móvil desarrollada con Flutter y Dart, orientada a la presentación de productos tecnológicos. El proyecto incorpora una identidad visual renovada y servicios nativos del dispositivo para mejorar la experiencia del usuario.

## Funcionalidades principales

- Catálogo de productos tecnológicos.
- Visualización de información y detalles de productos.
- Navegación entre pantallas mediante Navigator.
- Detección reactiva de cambios en la conectividad de red.
- Banner informativo cuando no existe conexión de red.
- Persistencia local de información mediante SharedPreferences.
- Selección de imágenes desde la galería.
- Captura de fotografías con la cámara.
- Recorte de imágenes.
- Notificaciones locales.

## Tecnologías utilizadas

- Flutter
- Dart
- Material Design
- Provider
- connectivity_plus
- shared_preferences
- image_picker
- image_cropper
- flutter_local_notifications
- Git y GitHub

## Arquitectura del proyecto

```text
lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   └── detail_screen.dart
├── widgets/
│   └── product_card.dart
├── services/
│   ├── connectivity_services.dart
│   ├── local_storage_service.dart
│   ├── image_services.dart
│   └── notification_service.dart
└── providers/
    ├── connectivity_provider.dart
    └── image_provider.dart


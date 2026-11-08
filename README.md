# NexTech

**Tecnología que conecta contigo.**

NexTech es una aplicación móvil desarrollada con Flutter y Dart, orientada a la presentación y consulta de productos tecnológicos. Su objetivo es ofrecer una experiencia sencilla e intuitiva mediante una interfaz moderna, consumo de servicios web y funcionalidades nativas del dispositivo.

## Funcionalidades principales

- Catálogo de productos tecnológicos mediante una API REST.
- Visualización de imágenes, nombres, categorías, precios y valoraciones.
- Filtros por categorías: Teléfonos, Computadoras y Accesorios.
- Opción para visualizar todos los productos.
- Actualización del catálogo mediante Pull-to-Refresh.
- Estados de carga, mensajes de error y opción para reintentar.
- Visualización de información y detalles de productos.
- Navegación entre pantallas mediante Navigator.
- Detección de cambios en la conectividad de red.
- Banner informativo cuando no existe conexión.
- Almacenamiento local mediante SharedPreferences.
- Selección de imágenes desde la galería.
- Captura de fotografías con la cámara.
- Recorte de imágenes.
- Notificaciones locales.

## Tecnologías utilizadas

- **Flutter:** desarrollo de la aplicación móvil.
- **Dart:** lenguaje de programación.
- **Material Design:** diseño de la interfaz.
- **Provider:** administración del estado.
- **HTTP:** consumo de servicios REST.
- **DummyJSON:** API utilizada para obtener los productos.
- **connectivity_plus:** detección de conectividad.
- **shared_preferences:** almacenamiento local.
- **image_picker:** selección y captura de imágenes.
- **image_cropper:** recorte de imágenes.
- **flutter_local_notifications:** notificaciones locales.
- **Git y GitHub:** control de versiones y almacenamiento del código fuente.

## API REST utilizada

Para obtener los productos tecnológicos se utiliza la API pública DummyJSON.

**Documentación:** https://dummyjson.com/docs/products

**Endpoint principal:**

`https://dummyjson.com/products`

La aplicación realiza peticiones a los siguientes endpoints por categoría:

- Smartphones: `https://dummyjson.com/products/category/smartphones`
- Laptops: `https://dummyjson.com/products/category/laptops`
- Tablets: `https://dummyjson.com/products/category/tablets`
- Accesorios: `https://dummyjson.com/products/category/mobile-accessories`

La API no requiere autenticación para estas consultas.

Los datos recibidos en formato JSON son procesados mediante el modelo Product y presentados en la interfaz de la aplicación.

## Arquitectura del proyecto

El proyecto está organizado mediante carpetas para separar modelos, pantallas, servicios, proveedores de estado y componentes visuales.

```text
lib/
├── main.dart
├── models/
│   └── product.dart
├── providers/
│   ├── connectivity_provider.dart
│   ├── image_provider.dart
│   └── product_provider.dart
├── screens/
│   ├── detail_screen.dart
│   └── home_screen.dart
├── services/
│   ├── connectivity_services.dart
│   ├── image_services.dart
│   ├── local_storage_service.dart
│   ├── notification_service.dart
│   └── product_service.dart
└── widgets/
    └── products_section.dart
```

### Administración del estado con Provider

Se utiliza Provider para separar la lógica de la interfaz y facilitar la actualización de los datos.

- **ProductProvider:** administra la lista de productos, los estados de carga, los errores y los filtros por categoría.
- **ConnectivityProvider:** administra el estado de la conectividad.
- **ImageProvider:** gestiona la información relacionada con las imágenes seleccionadas.

### Consumo de la API

El servicio ProductService realiza las peticiones HTTP a DummyJSON y procesa la información recibida.

El modelo Product representa los datos de cada producto.

### Filtrado de productos

Los productos se pueden organizar mediante cuatro opciones:

- Teléfonos: smartphones.
- Computadoras: laptops y tablets.
- Accesorios: accesorios tecnológicos.
- Todos: muestra el catálogo completo.

El filtrado se realiza localmente mediante ProductProvider, sin necesidad de realizar una nueva petición a la API cada vez que se cambia de categoría.

## Instalación y ejecución

### Requisitos

- Flutter instalado.
- Dart SDK.
- Visual Studio Code o Android Studio.
- Emulador Android o dispositivo físico.
- Conexión a Internet para consultar la API.

### Pasos para ejecutar el proyecto

1. Clonar el repositorio:

```bash
git clone https://github.com/ajtorres-creator/APP_FLUTTER.git
```

2. Ingresar a la carpeta del proyecto:

```bash
cd APP_FLUTTER
```

3. Instalar las dependencias:

```bash
flutter pub get
```

4. Verificar la configuración del entorno:

```bash
flutter doctor
```

5. Ejecutar la aplicación:

```bash
flutter run
```

## Repositorio

Código fuente disponible en GitHub:

https://github.com/ajtorres-creator/APP_FLUTTER

Rama de desarrollo de la integración API:

`feature/api-integration`

## Autor

**Anthony Josue Torres Tapia**

Carrera: Ingeniería en Sistemas

Universidad: Ecotec

Proyecto académico desarrollado como parte de la asignatura de Desarrollo de Aplicaciones Móviles.
